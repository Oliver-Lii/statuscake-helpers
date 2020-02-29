
<#
.Synopsis
   Create a StatusCake SSL Test
.EXAMPLE
   New-StatusCakeHelperSSLTest -Username "Username" -ApiKey "APIKEY" -Domain "https://www.example.com" -checkrate 3600
.PARAMETER APICredential
    Credentials to access StatusCake API
.PARAMETER Domain
    Name of the test to retrieve
.PARAMETER ID
    Test ID to retrieve
.PARAMETER CheckRate
    Checkrate in seconds
.PARAMETER Contact_Groups
    Array containing contact IDs to alert.
.PARAMETER Alert_At
    Number of days before expiration when reminders will be sent. Defaults to reminders at 60, 30 and 7 days. Must be 3 numeric values.
.PARAMETER Alert_expiry
    Set to true to enable expiration alerts. False to disable
.PARAMETER Alert_reminder
    Set to true to enable reminder alerts. False to disable
.PARAMETER Alert_broken
    Set to true to enable broken alerts. False to disable
.PARAMETER Alert_mixed
    Set to true to enable mixed content alerts. False to disable
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
        $domain,

        #Contact_Groups must be supplied
        [int[]]$contact_groups,

        [Parameter(Mandatory=$true)]
        [ValidateSet("300","600","1800","3600","86400","2073600")]
        $checkrate,

        [int[]]$alert_at=@("7","14","30"),

        [boolean]$alert_expiry=$true,

        [boolean]$alert_reminder=$true,

        [boolean]$alert_broken=$true,

        [boolean]$alert_mixed=$true

    )

    if($Alert_At -and $Alert_At.count -ne 3)
    {
        Write-Error "Only three values must be specified for Alert_At parameter"
        Return
    }

    if( $pscmdlet.ShouldProcess("StatusCake API", "Retrieve StatusCake SSL Checks") )
    {
        $sslTest = Get-StatusCakeHelperSSLTest -APICredential $APICredential -domain $domain
        if($sslTest)
        {
            Write-Error "SSL Check with specified domain already exists [$domain] [$($sslTest.id)]"
            Return $null
        }
    }

    $allParameterValues = $MyInvocation | Get-StatusCakeHelperParameterValue -BoundParameters $PSBoundParameters
    if(!$contact_groups)
    {
        # If no contact groups to be added then this must be sent empty
        $allParameterValues.Add("contact_groups","")
    }

    $statusCakeAPIParams = $allParameterValues | Get-StatusCakeHelperAPIParameter -InvocationInfo $MyInvocation
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