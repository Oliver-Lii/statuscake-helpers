
<#
.SYNOPSIS
    Create a StatusCake ContactGroup
.DESCRIPTION
    Creates a new StatusCake ContactGroup using the supplied parameters. The name of the contact group must be unique for the contact group to be created.
.PARAMETER APICredential
    Credentials to access StatusCake API
.PARAMETER GroupName
    Name of the Contact Group to be created
.PARAMETER DesktopAlert
    Set to 1 To Enable Desktop Alerts
.PARAMETER Email
    Array of email addresses to sent alerts to.
.PARAMETER Boxcar
    Boxcar API Key
.PARAMETER Pushover
    Pushover Account Key
.PARAMETER PingURL
    URL To Send a POST alert
.PARAMETER Mobile
    Array of mobile numbers in International Format E.164 notation
.EXAMPLE
    C:\PS>New-StatusCakeHelperContactGroup -GroupName "Example" -email @(test@example.com)
    Create contact group called "Example" using email address "test@example.com"
.LINK
    https://www.statuscake.com/api/Contact%20Groups/Add%20or%20Update%20Contact%20Group.md
.LINK
    https://github.com/Oliver-Lii/statuscake-helpers/blob/master/Documentation/ContactGroups/New-StatusCakeHelperContactGroup.md
#>
function New-StatusCakeHelperContactGroup
{
    [CmdletBinding(PositionalBinding=$false,SupportsShouldProcess=$true)]
    Param(
        [ValidateNotNullOrEmpty()]
        [System.Management.Automation.PSCredential] $APICredential = (Get-StatusCakeHelperAPIAuth),

        [Parameter(Mandatory=$true)]
        [ValidateNotNullOrEmpty()]
        [string]$GroupName,

        #Optional parameters
        [boolean]$DesktopAlert,

        [ValidateScript({
            if(!($_ | Test-StatusCakeHelperEmailAddress)){
                Throw "Invalid email address format supplied [$_]"
            }
            else{$true}
        })]
        [string[]]$Email,

        [ValidatePattern('^((http|https):\/\/)([a-zA-Z0-9\-]+(\.[a-zA-Z]+)+.*)$|^(?!^.*,$)')]
        [string]$PingURL,

        [ValidateNotNullOrEmpty()]
        [string]$Boxcar,

        [ValidateNotNullOrEmpty()]
        [string]$Pushover,

        [ValidateScript({
            if(!($_ | Test-StatusCakeHelperMobileNumber)){
                Throw "Mobile number is not in E.164 format [$_]"
            }
            else{$true}
        })]
        [string[]]$Mobile
    )

    if( $pscmdlet.ShouldProcess("StatusCake API", "Retrieve StatusCake ContactGroups") )
    {
        $ContactGroupCheck = Get-StatusCakeHelperContactGroup -APICredential $APICredential -GroupName $GroupName
        if($ContactGroupCheck)
        {
            Write-Error "ContactGroup with specified name already exists [$ContactGroupCheck]"
            Return $null
        }
    }

    $allParameterValues = $MyInvocation | Get-StatusCakeHelperParameterValue -BoundParameters $PSBoundParameters
    $statusCakeAPIParams = $allParameterValues | Get-StatusCakeHelperAPIParameter -InvocationInfo $MyInvocation -Exclude $exclude
    $statusCakeAPIParams = $statusCakeAPIParams | ConvertTo-StatusCakeHelperAPIParameter

    $requestParams = @{
        uri = "https://app.statuscake.com/API/ContactGroups/Update"
        Headers = @{"Username"=$APICredential.Username;"API"=$APICredential.GetNetworkCredential().password}
        UseBasicParsing = $true
        method = "Put"
        ContentType = "application/x-www-form-urlencoded"
        body = $statusCakeAPIParams
    }

    if( $pscmdlet.ShouldProcess("StatusCake API", "Add StatusCake ContactGroup") )
    {
        $response = Invoke-RestMethod @requestParams
        $requestParams=@{}
        if($response.Success -ne "True")
        {
            Write-Error "$($response.Message) [$($response.Issues)]"
            Return $null
        }
        else
        {
            $data = Get-StatusCakeHelperContactGroup -APICredential $APICredential -ContactID $response.InsertID
        }
        Return $data
    }

}