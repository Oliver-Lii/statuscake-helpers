
<#
.Synopsis
   Retrieves a StatusCake Contact Group with a specific name or Test ID
.PARAMETER APICredential
   Credentials to access StatusCake API
.PARAMETER GroupName
    Name of the Contact Group
.PARAMETER ContactID
    ID of the Contact Group to be copied
.EXAMPLE
   Get-StatusCakeHelperContactGroup -ContactID 123456
.OUTPUTS
    Returns the details of the test which exists returning $null if no matching test
.FUNCTIONALITY
    Retrieves StatusCake Test via the test name of the test or Test ID

#>
function Get-StatusCakeHelperContactGroup
{
    [CmdletBinding(PositionalBinding=$false,DefaultParameterSetName='all')]
    Param(
        [ValidateNotNullOrEmpty()]
        [System.Management.Automation.PSCredential] $APICredential = (Get-StatusCakeHelperAPIAuth),

        [Parameter(ParameterSetName = "Group Name")]
        [ValidateNotNullOrEmpty()]
        [string]$GroupName,

        [Parameter(ParameterSetName = "Contact ID")]
        [ValidateNotNullOrEmpty()]
        [int]$ContactID
    )

    $requestParams = @{
        uri = "https://app.statuscake.com/API/ContactGroups/"
        Headers = @{"Username"=$APICredential.Username;"API"=$APICredential.GetNetworkCredential().password}
        UseBasicParsing = $true
    }

    $response = Invoke-RestMethod @requestParams

    if($PSCmdlet.ParameterSetName -eq "all")
    {
        $matchingGroups = $response
    }
    elseif($GroupName)
    {
        $matchingGroups = $response | Where-Object {$_.GroupName -eq $GroupName}
    }
    elseif($ContactID)
    {
        $matchingGroups = $response | Where-Object {$_.ContactID -eq $ContactID}
    }

    Return $matchingGroups

}

