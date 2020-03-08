
<#
.Synopsis
   Sets the configuration of a StatusCake ContactGroup
.PARAMETER APICredential
   Credentials to access StatusCake API
.PARAMETER GroupName
    Name of the Contact Group to be created
.PARAMETER ContactID
    ID of the contact group to set
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
    Array of mobile number in International Format E.164 notation
.PARAMETER SetByGroupName
    Flag to set to allow Contact Group to be set by Group Name
.EXAMPLE
   Set-StatusCakeHelperContactGroup -GroupName "Example" -email @(test@example.com)
.FUNCTIONALITY
   Sets a StatusCake ContactGroup using the supplied parameters. Values supplied overwrite existing values
#>
function Set-StatusCakeHelperContactGroup
{
    [CmdletBinding(PositionalBinding=$false,SupportsShouldProcess=$true)]
    Param(
        [ValidateNotNullOrEmpty()]
        [System.Management.Automation.PSCredential] $APICredential = (Get-StatusCakeHelperAPIAuth),

        [Parameter(ParameterSetName='SetByContactID')]
        [int]$ContactID,

        [Parameter(ParameterSetName='SetByGroupName')]
        [switch]$SetByGroupName,

        [Parameter(ParameterSetName='SetByGroupName',Mandatory=$true)]
        [Parameter(ParameterSetName='SetByContactID')]
        [ValidateNotNullOrEmpty()]
        [string]$GroupName,

        [Parameter(ParameterSetName='SetByGroupName')]
        [Parameter(ParameterSetName='SetByContactID')]
        [boolean]$DesktopAlert,

        [Parameter(ParameterSetName='SetByGroupName')]
        [Parameter(ParameterSetName='SetByContactID')]
        [ValidateScript({
            if(!($_ | Test-StatusCakeHelperEmailAddress)){
                Throw "Invalid email address format supplied [$_]"
            }
            else{$true}
        })]
        [string[]]$Email,

        [Parameter(ParameterSetName='SetByGroupName')]
        [Parameter(ParameterSetName='SetByContactID')]
        [ValidatePattern('^((http|https):\/\/)([a-zA-Z0-9\-]+(\.[a-zA-Z]+)+.*)$|^(?!^.*,$)')]
        [string]$PingURL,

        [Parameter(ParameterSetName='SetByGroupName')]
        [Parameter(ParameterSetName='SetByContactID')]
        [ValidateNotNullOrEmpty()]
        [string]$Boxcar,

        [Parameter(ParameterSetName='SetByGroupName')]
        [Parameter(ParameterSetName='SetByContactID')]
        [ValidateNotNullOrEmpty()]
        [string]$Pushover,

        [Parameter(ParameterSetName='SetByGroupName')]
        [Parameter(ParameterSetName='SetByContactID')]
        [ValidateScript({
            if(!($_ | Test-StatusCakeHelperMobileNumber)){
                Throw "Mobile number is not in E.164 format [$_]"
            }
            else{$true}
        })]
        [string[]]$Mobile
    )

    if($SetByGroupName -and $GroupName)
    {
        if( $pscmdlet.ShouldProcess("StatusCake API", "Retrieve StatusCake ContactGroups"))
        {
            $contactGroupCheck = Get-StatusCakeHelperContactGroup -APICredential $APICredential -GroupName $GroupName
            if(!$contactGroupCheck)
            {
                Write-Error "Unable to find Contact Group with specified name [$GroupName]"
                Return $null
            }
            elseif($contactGroupCheck.GetType().Name -eq 'Object[]')
            {
                Write-Error "Multiple Contact Groups with the same name [$GroupName]"
                Return $null
            }
            $ContactID = $contactGroupCheck.ContactID
        }
    }

    $exclude=@("SetByGroupName")
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

    if( $pscmdlet.ShouldProcess("StatusCake API", "Set StatusCake ContactGroup") )
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
            $data = Get-StatusCakeHelperContactGroup -APICredential $APICredential -ContactID $ContactID
        }
        Return $data
    }

}