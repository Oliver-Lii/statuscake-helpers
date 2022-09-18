
<#
.SYNOPSIS
    Create a StatusCake ContactGroup
.DESCRIPTION
    Creates a new StatusCake ContactGroup using the supplied parameters. The name of the contact group must be unique for the contact group to be created.
.PARAMETER APICredential
    Credentials to access StatusCake API
.PARAMETER Name
    Name of the Contact Group to be created
.PARAMETER Email
    Array of email addresses to sent alerts to.
.PARAMETER IntegrationID
    List of integration IDs to link with this contact group
.PARAMETER PingURL
    URL or IP address of an endpoint to push uptime events. Currently this only supports HTTP GET endpoints
.PARAMETER Mobile
    Array of mobile numbers in International Format E.164 notation
.PARAMETER Force
    Force creation of the contact group even if a window with the same name already exists
.PARAMETER Passthru
    Return the contact group details instead of the contact id
.EXAMPLE
    C:\PS>New-StatusCakeHelperContactGroup -Name "Example" -email @(test@example.com)
    Create contact group called "Example" using email address "test@example.com"
.LINK
    https://github.com/Oliver-Lii/statuscake-helpers/blob/master/Documentation/ContactGroups/New-StatusCakeHelperContactGroup.md
.LINK
    https://www.statuscake.com/api/v1/#tag/contact-groups/operation/create-contact-group
#>
function New-StatusCakeHelperContactGroup
{
    [CmdletBinding(PositionalBinding=$false,SupportsShouldProcess=$true)]
    Param(
        [ValidateNotNullOrEmpty()]
        [System.Management.Automation.PSCredential] $APICredential = (Get-StatusCakeHelperAPIAuth),

        [Parameter(Mandatory=$true)]
        [ValidateNotNullOrEmpty()]
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
        [string[]]$Mobile,

        [switch]$Force,

        [switch]$PassThru
    )

    #If force flag not set then check if an existing test with the same name already exists
    if(!$Force)
    {
       $statusCakeItem = Get-StatusCakeHelperContactGroup -APICredential $APICredential -Name $Name
       if($statusCakeItem)
       {
            Write-Error "Existing contact group(s) found with name [$Name]. Please use a different name or use the -Force argument"
            Return $null
       }
    }

    $allParameterValues = $MyInvocation | Get-StatusCakeHelperParameterValue -BoundParameters $PSBoundParameters
    $statusCakeAPIParams = $allParameterValues | Get-StatusCakeHelperAPIParameter -InvocationInfo $MyInvocation -Exclude @("Force","PassThru") | ConvertTo-StatusCakeHelperAPIValue

    if( $pscmdlet.ShouldProcess("StatusCake API", "Create StatusCake contact group") )
    {
        Return (New-StatusCakeHelperItem -APICredential $APICredential -Type Contact-Groups -Parameter $statusCakeAPIParams -PassThru:$PassThru)
    }

}