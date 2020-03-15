
<#
.SYNOPSIS
    Retrieves a StatusCake Contact Group with a specific name or Test ID
.DESCRIPTION
    Retrieves StatusCake Test via the test name of the test or Test ID. If no group name or id supplied all contact groups will be returned
.PARAMETER APICredential
    Credentials to access StatusCake API
.PARAMETER GroupName
    Name of the Contact Group
.PARAMETER ContactID
    ID of the Contact Group to be copied
.EXAMPLE
    C:\PS>Get-StatusCakeHelperContactGroup
    Retrieve all contact groups
.EXAMPLE
    C:\PS>Get-StatusCakeHelperContactGroup -ContactID 123456
    Retrieve contact group with ID 123456
.OUTPUTS
    Returns the contact group(s) returning $null if no matching contact groups

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

