
<#
.SYNOPSIS
    Updates the configuration of a StatusCake ContactGroup
.DESCRIPTION
    Updates a StatusCake ContactGroup using the supplied parameters. Values supplied overwrite existing values.
.PARAMETER APICredential
    Credentials to access StatusCake API
.PARAMETER Name
    Name of the Contact Group to be created
.PARAMETER ID
    ID of the contact group to set
.PARAMETER Email
    Array of email addresses to sent alerts to.
.PARAMETER PingURL
    URL To Send a POST alert
.PARAMETER Mobile
    Array of mobile number in International Format E.164 notation
.PARAMETER IntegrationID
    List of integration IDs to link with this contact group
.EXAMPLE
    C:\PS>Update-StatusCakeHelperContactGroup -Name "Example" -email @(test@example.com)
    Set the contact group name "Example" with email address "test@example.com"
.LINK
    https://github.com/Oliver-Lii/statuscake-helpers/blob/master/Documentation/ContactGroups/Update-StatusCakeHelperContactGroup.md
.LINK
    https://www.statuscake.com/api/v1/#tag/contact-groups/operation/update-contact-group
#>
function Update-StatusCakeHelperContactGroup
{
    [CmdletBinding(PositionalBinding=$false,SupportsShouldProcess=$true)]
    Param(
        [ValidateNotNullOrEmpty()]
        [System.Management.Automation.PSCredential] $APICredential = (Get-StatusCakeHelperAPIAuth),

        [Parameter(ParameterSetName = "ID")]
        [ValidateNotNullOrEmpty()]
        [Alias("group_id","GroupID","ContactID")]
        [int]$ID,

        [Parameter(ParameterSetName = "Name")]
        [ValidateNotNullOrEmpty()]
        [Alias("GroupName")]
        [string]$Name,

        [ValidateScript({
            if(!($_ | Test-StatusCakeHelperEmailAddress)){
                Throw "Invalid email address format supplied [$_]"
            }
            else{$true}
        })]
        [Alias("email_addresses")]
        [string[]]$Email,

        [Alias("integrations")]
        [int[]]$IntegrationID,

        [ValidatePattern('^((http|https):\/\/)([a-zA-Z0-9\-]+(\.[a-zA-Z]+)+.*)$|^(?!^.*,$)')]
        [Alias("ping_url")]
        [string]$PingURL,

        [ValidateScript({
            if(!($_ | Test-StatusCakeHelperMobileNumber)){
                Throw "Mobile number is not in E.164 format [$_]"
            }
            else{$true}
        })]
        [Alias("mobile_numbers")]
        [string[]]$Mobile
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
           Write-Error "Multiple contact groups found with name [$Name]. Please update the contact group  by ID"
           Return $null
       }
       $ID = $statusCakeItem.id
    }

    $allParameterValues = $MyInvocation | Get-StatusCakeHelperParameterValue -BoundParameters $PSBoundParameters
    $statusCakeAPIParams = $allParameterValues | Get-StatusCakeHelperAPIParameter -InvocationInfo $MyInvocation -Exclude @("Force","Name")  | ConvertTo-StatusCakeHelperAPIValue

    if( $pscmdlet.ShouldProcess("$ID", "Update StatusCake contact group") )
    {
        Return (Update-StatusCakeHelperItem -APICredential $APICredential -Type "Contact-Groups" -ID $ID -Parameter $statusCakeAPIParams)
    }

}