
<#
.Synopsis
   Retrieves a list of each period of data.
.EXAMPLE
   Get-StatusCakeHelperPeriodOfData -TestID 123456
.INPUTS
    basePeriodURL - Base URL endpoint of the statuscake API
    Username - Username associated with the API key
    ApiKey - APIKey to access the StatusCake API
    TestID - ID of the Test to retrieve the period of data for
    TestName - Name of the Test to retrieve the period of data for
.OUTPUTS    
    Returns an object with the details the periods of data
.FUNCTIONALITY
    Retrieves a list of each period of data. A period of data is two time stamps 
    in which status has remained the same, such as a period of downtime or uptime.
   
#>
function Get-StatusCakeHelperPeriodOfData
{
    [CmdletBinding(PositionalBinding=$false)]    
    Param(                     
        $basePeriodURL = "https://app.statuscake.com/API/Tests/Periods/",
         
        [Parameter(Mandatory=$true)]        
        [string]$Username,

        [Parameter(Mandatory=$true)]
        [string]$ApiKey,

        [Parameter(ParameterSetName = "Test ID")]        
        [int]$TestID,

        [Parameter(ParameterSetName = "Test Name")]              
        [ValidateNotNullOrEmpty()]            
        [string]$TestName
    )
    $authenticationHeader = @{"Username"="$username";"API"="$ApiKey"}

    if($TestName)
    {
        $testCheck = Get-StatusCakeHelperTest -Username $username -apikey $ApiKey -TestName $TestName
        if($testCheck.GetType().Name -eq 'Object[]')
        {
            Write-Error "Multiple Tests found with name [$TestName] [$($testCheck.TestID)]. Please retrieve the periods of data via TestID"
            Return $null            
        }
        $TestID = $testCheck.TestID
        else 
        {
            Write-Error "Unable to find Test with name [$TestName]"
            Return $null
        }
    }

    $uri = "$basePeriodURL`?TestID=$TestID"

    $requestParams = @{
        uri = $uri
        Headers = $authenticationHeader
        UseBasicParsing = $true
    }

    $jsonResponse = Invoke-WebRequest @requestParams
    $response = $jsonResponse | ConvertFrom-Json

    if(!$response)
    {
        Write-Warning "No checks have been carried out for the specified test [$TestID]"
        Return $null        
    }

    Return $response
}

