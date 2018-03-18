
<#
.Synopsis
   Add additional HTTP status codes to alert on to a StatusCake test
.EXAMPLE
   Add-StatusCakeHelperTestStatusCodes -Username "Username" -ApiKey "APIKEY" -TestID "123456" -StatusCodes @("206","207")
.INPUTS
    baseTestURL - Base URL endpoint of the statuscake test API
    Username - Username associated with the API key
    ApiKey - APIKey to access the StatusCake API
    TestID - The Test ID to modify the details for
    AddByTestName - Add status codes to a test via the name of the test
    TestName - Name of the Test to be displayed in StatusCake
    StatusCodes - Array of status codes to add

.FUNCTIONALITY
    Add additional HTTP StatusCodes to alert on to an existing test.
   
#>
function Add-StatusCakeHelperTestStatusCodes
{
    [CmdletBinding(PositionalBinding=$false,SupportsShouldProcess=$true)]    
    Param(
        [Parameter(ParameterSetName='AddByTestName')]
        [Parameter(ParameterSetName='AddByTestID')]      
        $baseTestURL = "https://app.statuscake.com/API/Tests/Update",

        [Parameter(ParameterSetName='AddByTestName')]
        [Parameter(ParameterSetName='AddByTestID')]
        [ValidateNotNullOrEmpty()]        
        $Username = (Get-StatusCakeHelperAPIAuth).Username,

        [Parameter(ParameterSetName='AddByTestName')]
        [Parameter(ParameterSetName='AddByTestID')]
        [ValidateNotNullOrEmpty()]        
        $ApiKey = (Get-StatusCakeHelperAPIAuth).GetNetworkCredential().password,

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
        [object]$StatusCodes
    )

    $authenticationHeader = @{"Username"="$Username";"API"="$ApiKey"}
    $statusCakeFunctionAuth = @{"Username"=$Username;"Apikey"=$ApiKey}

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

    foreach($statusCode in $StatusCodes)
    {
        Write-Verbose "Validating HTTP Status Code [$statusCode]"
        if(!$($statusCode | Test-StatusCakeHelperStatusCode))
        {
            Write-Error "HTTP Status Code invalid [$statusCode]"
            Return $null           
        }
    }
    $detailedTestData.StatusCodes += $StatusCodes
    $StatusCodes = $detailedTestData.StatusCodes | Sort-Object -Unique

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