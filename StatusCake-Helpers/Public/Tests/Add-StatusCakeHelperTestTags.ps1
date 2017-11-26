
<#
.Synopsis
   Add tags to a StatusCake test
.EXAMPLE
   Add-StatusCakeHelperTestTags -Username "Username" -ApiKey "APIKEY" -TestID "123456" -TestTags @("Tag1","Tag2")
.INPUTS
    baseTestURL - Base URL endpoint of the statuscake test API
    Username - Username associated with the API key
    ApiKey - APIKey to access the StatusCake API
    TestID - The Test ID to modify the details for
    AddByTestName - Add tags to a test via the name of the test
    TestName - Name of the Test to be displayed in StatusCake
    TestTags - Array of tags to add

.FUNCTIONALITY
    Add tag(s) to a existing test.
   
#>
function Add-StatusCakeHelperTestTags
{
    [CmdletBinding(PositionalBinding=$false,SupportsShouldProcess=$true)]    
    Param(
        [Parameter(ParameterSetName='AddByTestName')]
        [Parameter(ParameterSetName='AddByTestID')]      
        $baseTestURL = "https://app.statuscake.com/API/Tests/Update",

        [Parameter(ParameterSetName='AddByTestName',Mandatory=$true)]
        [Parameter(ParameterSetName='AddByTestID',Mandatory=$true)]
        [Parameter(Mandatory=$true)]        
        $Username,

        [Parameter(ParameterSetName='AddByTestName',Mandatory=$true)]
        [Parameter(ParameterSetName='AddByTestID',Mandatory=$true)]
        [Parameter(Mandatory=$true)]        
        $ApiKey,

        [Parameter(ParameterSetName='AddByTestID',Mandatory=$true)]
        [ValidatePattern('^\d{1,}$')]           
        $TestID,

        [Parameter(ParameterSetName='AddByTestName',Mandatory=$true)]
        [switch]$AddByTestName,

        [Parameter(ParameterSetName='AddByTestName',Mandatory=$true)]
        [Parameter(ParameterSetName='AddByTestID')]           
        [ValidateNotNullOrEmpty()] 
        $TestName,

        [Parameter(ParameterSetName='AddByTestName')]
        [Parameter(ParameterSetName='AddByTestID')]
        [ValidateNotNullOrEmpty()]         
        [object]$TestTags
    )
    $authenticationHeader = @{"Username"="$username";"API"="$ApiKey"}
    $statusCakeFunctionAuth = @{"Username"=$username;"Apikey"=$apikey}

    if($AddByTestName -and $TestName)
    {   #If setting test by name check if a test or tests with that name exists
        if( $pscmdlet.ShouldProcess("StatusCake API", "Retrieve StatusCake Tests"))
        {      
            $testCheck = Get-StatusCakeHelperTest @statusCakeFunctionAuth -TestName $TestName
            if(!$testCheck)
            {
                Write-Error "No Test with Specified Name Exists [$TestName]"
                Return $null 
            }
            elseif($testCheck.GetType().Name -eq 'Object[]')
            {
                Write-Error "Multiple Tests with the same name [$TestName] [$($testCheck.TestID)]"
                Return $null          
            }            
            $TestID = $testCheck.TestID
        }
    }
    elseif($TestID)
    {   #If setting by TestID verify that TestID already exists
        if( $pscmdlet.ShouldProcess("StatusCake API", "Retrieve StatusCake Tests"))
        {      
            $testCheck = Get-StatusCakeHelperTest @statusCakeFunctionAuth -TestID $TestID
            if(!$testCheck)
            {
                Write-Error "No Test with Specified ID Exists [$TestID]"
                Return $null 
            }            
            $TestID = $testCheck.TestID
        }
    }

    if( $pscmdlet.ShouldProcess("StatusCake API", "Retrieve StatusCake Detailed Test Data") )
    {
        $detailedTestData = Get-StatusCakeHelperDetailedTestData @statusCakeFunctionAuth -TestID $TestID
    }

    #Tags property does not exist unless Test already has Tags
    if($detailedTestData.Tags)
    {
        $detailedTestData.Tags += $TestTags
        $TestTags = $detailedTestData.Tags | Select-Object -Unique        
    }

    $psParams = @{}
    $ParameterList = (Get-Command -Name $MyInvocation.InvocationName).Parameters
    $ParamsToIgnore = @("baseTestURL","Username","ApiKey","AddByTestName")
    foreach ($key in $ParameterList.keys)
    {
        $var = Get-Variable -Name $key -ErrorAction SilentlyContinue;
        if($ParamsToIgnore -contains $var.Name)
        {
            continue
        }
        elseif($var.value -or $var.value -eq 0)
        {        
            $psParams.Add($var.name,$var.value)                  
        }
    }     

    $statusCakeAPIParams = $psParams | ConvertTo-StatusCakeHelperAPIParams

    $putRequestParams = @{
        uri = $baseTestURL
        Headers = $authenticationHeader
        UseBasicParsing = $true
        method = "Put"
        ContentType = "application/x-www-form-urlencoded"
        body = $statusCakeAPIParams 
    }

    if( $pscmdlet.ShouldProcess("StatusCake API", "Set StatusCake Test") )
    {
        $jsonResponse = Invoke-WebRequest @putRequestParams
        $response = $jsonResponse | ConvertFrom-Json
        if($response.Success -ne "True")
        {
            Write-Error "$($response.Message) [$($response.Issues)]"
            Return $null
        }        
        Return $response
    }

}