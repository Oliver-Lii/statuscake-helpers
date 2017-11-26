
<#
.Synopsis
   Retrieves a StatusCake Contact Group with a specific name or Test ID
.EXAMPLE
   Get-StatusCakeHelperContactGroup -Username "Username" -ApiKey "APIKEY" -ContactID 123456
.INPUTS
    baseTestURL - Base URL endpoint of the statuscake auth API
    Username - Username associated with the API key
    ApiKey - APIKey to access the StatusCake API
    TestName - Name of the test to retrieve
    TestID - Test ID to retrieve
.OUTPUTS    
    Returns the details of the test which exists returning $null if no matching test
.FUNCTIONALITY
    Retrieves StatusCake Test via the test name of the test or Test ID
   
#>
function Get-StatusCakeHelperContactGroup
{
    [CmdletBinding(PositionalBinding=$false)]    
    Param(
        $baseTestURL = "https://app.statuscake.com/API/ContactGroups/",
        [Parameter(Mandatory=$true)]        
        $Username,
        [Parameter(Mandatory=$true)]
        $ApiKey,
        [Parameter(ParameterSetName = "Group Name")]
        [ValidateNotNullOrEmpty()]            
        [string]$GroupName,
        [Parameter(ParameterSetName = "Contact ID")]
        [ValidateNotNullOrEmpty()]            
        [int]$ContactID        
    )
    $authenticationHeader = @{"Username"="$username";"API"="$ApiKey"}

    $requestParams = @{
        uri = $baseTestURL
        Headers = $authenticationHeader
        UseBasicParsing = $true
    }

    $jsonResponse = Invoke-WebRequest @requestParams
    $response = $jsonResponse | ConvertFrom-Json

    if($GroupName)
    {
        $matchingGroups = $response | Where-Object {$_.GroupName -eq $GroupName}
    }
    elseif($ContactID)
    {
        $matchingGroups = $response | Where-Object {$_.ContactID -eq $ContactID}
    }

    if($matchingGroups)
    {
        Return $matchingGroups
    }
    Return $null
}

