
<#
.Synopsis
   Retrieves a StatusCake Contact Group with a specific name or Test ID
.PARAMETER baseContactGroupURL
    Base URL endpoint of the statuscake Contact Group API
.PARAMETER Username
    Username associated with the API key
.PARAMETER ApiKey
    APIKey to access the StatusCake API
.PARAMETER GroupName
    Name of the Contact Group
.PARAMETER ContactID
    ID of the Contact Group to be copied
.EXAMPLE
   Get-StatusCakeHelperContactGroup -Username "Username" -ApiKey "APIKEY" -ContactID 123456
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

		[ValidateNotNullOrEmpty()]
        $Username = (Get-StatusCakeHelperAPIAuth).Username,
        [ValidateNotNullOrEmpty()]
        $ApiKey = (Get-StatusCakeHelperAPIAuth).GetNetworkCredential().password,

        [Parameter(ParameterSetName = "Group Name")]
        [ValidateNotNullOrEmpty()]
        [string]$GroupName,
        [Parameter(ParameterSetName = "Contact ID")]
        [ValidateNotNullOrEmpty()]
        [int]$ContactID
    )
    $authenticationHeader = @{"Username"="$Username";"API"="$ApiKey"}

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

