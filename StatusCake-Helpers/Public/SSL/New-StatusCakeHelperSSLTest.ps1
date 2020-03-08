
<#
.Synopsis
   Create a StatusCake SSL Test
.PARAMETER APICredential
    Credentials to access StatusCake API
.PARAMETER Domain
    Name of the test to retrieve
.PARAMETER ID
    Test ID to retrieve
.PARAMETER Checkrate
    Checkrate in seconds
.PARAMETER ContactIDs
    Array containing contact IDs to alert.
.PARAMETER AlertAt
    Number of days before expiration when reminders will be sent. Defaults to reminders at 60, 30 and 7 days. Must be 3 numeric values.
.PARAMETER AlertExpiry
    Set to true to enable expiration alerts. False to disable
.PARAMETER AlertReminder
    Set to true to enable reminder alerts. False to disable
.PARAMETER AlertBroken
    Set to true to enable broken alerts. False to disable
.PARAMETER AlertMixed
    Set to true to enable mixed content alerts. False to disable
.EXAMPLE
   New-StatusCakeHelperSSLTest -Domain "https://www.example.com" -checkrate 3600
.FUNCTIONALITY
   Creates a new StatusCake SSL Test using the supplied parameters.
#>
function New-StatusCakeHelperSSLTest
{
    [CmdletBinding(PositionalBinding=$false,SupportsShouldProcess=$true)]
    Param(
        [ValidateNotNullOrEmpty()]
        [System.Management.Automation.PSCredential] $APICredential = (Get-StatusCakeHelperAPIAuth),

        [Parameter(Mandatory=$true)]
        [ValidatePattern('^((https):\/\/)([a-zA-Z0-9\-]+(\.[a-zA-Z]+)+.*)$|^(?!^.*,$)')]
        [string]$Domain,

        #Contact_Groups must be supplied
        [Alias('contact_groups')]
        [int[]]$ContactIDs,

        [Parameter(Mandatory=$true)]
        [ValidateSet("300","600","1800","3600","86400","2073600")]
        [int]$Checkrate,

        [Alias('alert_at')]
        [ValidateCount(3,3)]
        [int[]]$AlertAt=@("7","14","30"),

        [Alias('alert_expiry')]
        [boolean]$AlertExpiry=$true,

        [Alias('alert_reminder')]
        [boolean]$AlertReminder=$true,

        [Alias('alert_broken')]
        [boolean]$AlertBroken=$true,

        [Alias('alert_mixed')]
        [boolean]$AlertMixed=$true

    )

    if( $pscmdlet.ShouldProcess("StatusCake API", "Retrieve StatusCake SSL Checks") )
    {
        $sslTest = Get-StatusCakeHelperSSLTest -APICredential $APICredential -Domain $Domain
        if($sslTest)
        {
            Write-Error "SSL Check with specified domain already exists [$Domain] [$($sslTest.id)]"
            Return $null
        }
    }

    $allParameterValues = $MyInvocation | Get-StatusCakeHelperParameterValue -BoundParameters $PSBoundParameters
    if(!$ContactIDs)
    {
        # If no contact groups to be added then this must be sent empty
        $allParameterValues.Add("contact_groups","")
    }

    $lower=@('Checkrate','Domain')
    $statusCakeAPIParams = $allParameterValues | Get-StatusCakeHelperAPIParameter -InvocationInfo $MyInvocation -ToLowerName $lower
    $statusCakeAPIParams = $statusCakeAPIParams | ConvertTo-StatusCakeHelperAPIParameter

    $requestParams = @{
        uri = "https://app.statuscake.com/API/SSL/Update"
        Headers = @{"Username"=$APICredential.Username;"API"=$APICredential.GetNetworkCredential().password}
        UseBasicParsing = $true
        method = "Put"
        ContentType = "application/x-www-form-urlencoded"
        body = $statusCakeAPIParams
    }

    if( $pscmdlet.ShouldProcess("StatusCake API", "New StatusCake SSL Test") )
    {
        $response = Invoke-RestMethod @requestParams
        $requestParams=@{}
        if($response.Success -ne "True")
        {
            Write-Error "$($response.Message) [$($response.Issues)]"
            Return $null
        }
        $response = Get-StatusCakeHelperSSLTest -APICredential $APICredential -id $response.Message
        Return $response
    }

}