<#
.SYNOPSIS
    Retrieves a StatusCake Contact Group with a specific name or Test ID
.DESCRIPTION
    Retrieves a StatusCake contact group via the name or ID. If no name or id supplied all contact groups will be returned.
.PARAMETER APICredential
    Credentials to access StatusCake API
.PARAMETER Name
    Name of the Contact Group
.PARAMETER ID
    ID of the Contact Group to be retrieved
.EXAMPLE
    C:\PS>Get-StatusCakeHelperContactGroup
    Retrieve all contact groups
.EXAMPLE
    C:\PS>Get-StatusCakeHelperContactGroup -ID 123456
    Retrieve contact group with ID 123456
.OUTPUTS
    Returns the contact group(s)
        id              : 123456
        name            : Test Contact Group
        email_addresses : {test@example.com}
        mobile_numbers  : {}
        integrations    : {}
.LINK
    https://github.com/Oliver-Lii/statuscake-helpers/blob/master/Documentation/ContactGroups/Get-StatusCakeHelperContactGroup.md
.LINK
    https://www.statuscake.com/api/v1/#tag/contact-groups/operation/list-contact-groups
.LINK
    https://www.statuscake.com/api/v1/#tag/contact-groups/operation/get-contact-group
#>
function Get-StatusCakeHelperContactGroup
{
    [CmdletBinding(PositionalBinding=$false,DefaultParameterSetName='all')]
    Param(
        [ValidateNotNullOrEmpty()]
        [System.Management.Automation.PSCredential] $APICredential = (Get-StatusCakeHelperAPIAuth),

        [Parameter(ParameterSetName = "Group Name")]
        [ValidateNotNullOrEmpty()]
        [string]$Name,

        [Parameter(ParameterSetName = "Contact ID")]
        [Alias("GroupID","ContactID")]
        [ValidateNotNullOrEmpty()]
        [int]$ID
    )

    if($Name)
    {
        $statusCakeItem = Get-StatusCakeHelperItem -APICredential $APICredential -Type "Contact-Groups" | Where-Object{$_.name -eq $Name}
    }
    elseif($ID)
    {
        $statusCakeItem = Get-StatusCakeHelperItem -APICredential $APICredential -Type "Contact-Groups" -ID $ID
    }
    else
    {
        $statusCakeItem = Get-StatusCakeHelperItem -APICredential $APICredential -Type "Contact-Groups"
    }
    Return $statusCakeItem
}
