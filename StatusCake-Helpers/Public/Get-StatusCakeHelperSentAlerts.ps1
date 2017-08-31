
<#
.Synopsis
   Retrieves alerts that have been sent in relation to tests setup on the account
.EXAMPLE
   Get-StatusCakeHelperSentAlerts -TestID 123456 -since "2017-08-19 13:29:49"
.INPUTS
    baseAlertURL - Base URL endpoint of the statuscake alert API
    Username - Username associated with the API key
    ApiKey - APIKey to access the StatusCake API
    TestID - ID of the Test to retrieve the sent alerts for
    TestName - Name of the Test to retrieve the sent alerts for
    Since - Supply to include results only since the specified date
.OUTPUTS    
    Returns an object with the details on the Alerts Sent
.FUNCTIONALITY
    Retrieves alerts that have been sent in regards to tests setup on the account
   
#>
function Get-StatusCakeHelperSentAlerts
{
    [CmdletBinding(PositionalBinding=$false)]    
    Param(                     
        $baseAlertURL = "https://app.statuscake.com/API/Alerts/",
         
        [Parameter(Mandatory=$true)]        
        [string]$Username,

        [Parameter(Mandatory=$true)]
        [string]$ApiKey,
                    
        [int]$TestID,     
              
        [ValidateNotNullOrEmpty()]            
        [string]$TestName,
                   
        [datetime]$Since
    )
    $authenticationHeader = @{"Username"="$username";"API"="$ApiKey"}

    if($TestName)
    {
        $testCheck = Get-StatusCakeHelperTest -Username $username -apikey $ApiKey -TestName $TestName
        if($testCheck.GetType().Name -eq 'Object[]')
        {
            Write-Error "Multiple Tests found with name [$TestName] [$($testCheck.TestID)]. Please retrieve sent alerts via TestID"
            Return $null            
        }
        $TestID = $testCheck.TestID
        else 
        {
            Write-Error "Unable to find Test with name [$TestName]"
            Return $null
        }
    }

    $uri = $baseAlertURL
    if($TestID)
    {
        $uri = "$uri`?TestID=$TestID"
    }

    if($Since)
    {   #Calculate Unix timestamp
        $date1 = Get-Date -Date "01/01/1970"
        $unixTimestamp = (New-TimeSpan -Start $date1 -End $Since).TotalSeconds    
        if($TestID)
        {
            $uri = "$uri&Since=$unixTimestamp"
        }
        else
        {         
            $uri = "$uri`?Since=$unixTimestamp"
        }
    }

    $requestParams = @{
        uri = $uri
        Headers = $authenticationHeader
        UseBasicParsing = $true
    }

    $jsonResponse = Invoke-WebRequest @requestParams
    $response = $jsonResponse | ConvertFrom-Json
    Return $response
}

