
<#
.Synopsis
   Remove HTTP Status Codes from a StatusCake test
.EXAMPLE
   Remove-StatusCakeHelperTestStatusCodes -Username "Username" -ApiKey "APIKEY" -TestID "123456" -StatusCodes @("401","404")
.INPUTS
    baseTestURL - Base URL endpoint of the statuscake test API
    Username - Username associated with the API key
    ApiKey - APIKey to access the StatusCake API
    TestID - The Test ID to modify the details for
    RemoveByTestName - Remove status code from a test via the name of the test
    TestName - Name of the Test
    StatusCodes - Array of status codes to be removed

.FUNCTIONALITY
    Remove HTTP Status Codes from an existing test.
   
#>
function Remove-StatusCakeHelperTestStatusCodes
{
    [CmdletBinding(PositionalBinding=$false,SupportsShouldProcess=$true)]    
    Param(
        [Parameter(ParameterSetName='RemoveByTestName')]
        [Parameter(ParameterSetName='RemoveByTestID')]      
        $baseTestURL = "https://app.statuscake.com/API/Tests/Update",

        [Parameter(ParameterSetName='RemoveByTestName',Mandatory=$true)]
        [Parameter(ParameterSetName='RemoveByTestID',Mandatory=$true)]
        [Parameter(Mandatory=$true)]        
        $Username,

        [Parameter(ParameterSetName='RemoveByTestName',Mandatory=$true)]
        [Parameter(ParameterSetName='RemoveByTestID',Mandatory=$true)]
        [Parameter(Mandatory=$true)]        
        $ApiKey,

        [Parameter(ParameterSetName='RemoveByTestID',Mandatory=$true)]
        [ValidatePattern('^\d{1,}$')]           
        $TestID,

        [Parameter(ParameterSetName='RemoveByTestName',Mandatory=$true)]
        [switch]$RemoveByTestName,

        [Parameter(ParameterSetName='RemoveByTestName',Mandatory=$true)]
        [Parameter(ParameterSetName='RemoveByTestID')]           
        [ValidateNotNullOrEmpty()] 
        $TestName,

        [Parameter(ParameterSetName='RemoveByTestName')]
        [Parameter(ParameterSetName='RemoveByTestID')]
        [ValidateNotNullOrEmpty()]         
        [object]$StatusCodes

    )
    $authenticationHeader = @{"Username"="$username";"API"="$ApiKey"}
    $statusCakeFunctionAuth = @{"Username"=$username;"Apikey"=$apikey}

    if($RemoveByTestName -and $TestName)
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

    foreach($statuscode in $StatusCodes)
    {
        Write-Verbose "Validating status code [$statuscode]"
        if(!$($statuscode | Test-StatusCakeHelperStatusCode))
        {
            Write-Error "Status code invalid [$statuscode]"
            Return $null           
        }
    }
    if(!$detailedTestData.StatusCodes)
    {
        Write-Verbose "Test currently contains no status codes"
        $detailedTestData.StatusCodes = ""
    }
    $StatusCodes = $StatusCodes | Select-Object -Unique        
    $differentStatusCodes = Compare-Object $detailedTestData.StatusCodes $StatusCodes -IncludeEqual
    $StatusCodes = $differentStatusCodes | Where-Object {$_.SideIndicator -eq "<="} | Select-Object -ExpandProperty InputObject | Sort-Object
    $RemovedStatusCodes = $differentStatusCodes | Where-Object {$_.SideIndicator -eq "=="} | Select-Object -ExpandProperty InputObject
    $StatusCodesNotPresent = $differentStatusCodes | Where-Object {$_.SideIndicator -eq "=>"} | Select-Object -ExpandProperty InputObject

    Write-Verbose "Removing Following Tags from Test [$RemovedStatusCodes]"
    Write-Verbose "Following Tags not attached to Test [$StatusCodesNotPresent]"

    $psParams = @{}
    $ParameterList = (Get-Command -Name $MyInvocation.InvocationName).Parameters
    $ParamsToIgnore = @("baseTestURL","Username","ApiKey","RemoveByTestName")
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