

<#
.SYNOPSIS
    Removes the specified StatusCake contact group
.DESCRIPTION
    Removes the StatusCake contact group via its ID or Name.
.PARAMETER APICredential
    Username and APIKey Credentials to access StatusCake API
.PARAMETER ID
    ID of the contact group to be removed
.PARAMETER Name
    Name of the Contact Group to be removed
.EXAMPLE
    C:\PS>Remove-StatusCakeHelperContactGroup -ID 123456
    Remove contact group with ID 123456
.OUTPUTS
    Returns the result of the contact group removal as an object
.LINK
    https://github.com/Oliver-Lii/statuscake-helpers/blob/master/Documentation/ContactGroups/Remove-StatusCakeHelperContactGroup.md
.LINK
    https://www.statuscake.com/api/v1/#tag/contact-groups/operation/delete-contact-group
#>
function Remove-StatusCakeHelperContactGroup
{
    [CmdletBinding(PositionalBinding=$false,SupportsShouldProcess=$true)]
    Param(
        [ValidateNotNullOrEmpty()]
        [System.Management.Automation.PSCredential] $APICredential = (Get-StatusCakeHelperAPIAuth),

        [Parameter(ParameterSetName = "ContactID")]
        [ValidateNotNullOrEmpty()]
        [Alias("group_id","GroupID","ContactID")]
        [int]$ID,

        [Parameter(ParameterSetName = "GroupName")]
        [ValidateNotNullOrEmpty()]
        [string]$Name
    )

    if($Name)
    {
       $statusCakeItem = Get-StatusCakeHelperContactGroup -APICredential $APICredential -Name $Name
       if(!$statusCakeItem)
       {
            Write-Error "No contact group(s) found with name [$Name]"
            Return $null
       }
       elseif($statusCakeItem.GetType().Name -eq 'Object[]')
       {
           Write-Error "Multiple contact group found with name [$Name]. Please delete the contact group by ID"
           Return $null
       }
       $ID = $statusCakeItem.id
    }

    if( $pscmdlet.ShouldProcess("$ID", "Delete StatusCake contact group") )
    {
        Return (Remove-StatusCakeHelperItem -APICredential $APICredential -Type Contact-Groups -ID $ID)
    }
}
