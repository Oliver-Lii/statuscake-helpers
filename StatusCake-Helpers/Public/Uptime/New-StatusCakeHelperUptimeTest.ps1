<#
.SYNOPSIS
    Create a StatusCake uptime tes
.DESCRIPTION
    Creates a new StatusCake Uptime Test using the supplied parameters. Only parameters which have been supplied values are set
    and the defaults for a particular test type are used otherwise.
.PARAMETER APICredential
    Credentials to access StatusCake API
.PARAMETER Name
    Name of the Test to be displayed in StatusCake
.PARAMETER Type
    The type of test to create. Valid options are "DNS", "HEAD", "HTTP", "PING", "SMTP", "SSH", "TCP"
.PARAMETER WebsiteURL
    Test location, either an IP (for TCP and Ping) or a fully qualified URL for other TestTypes
.PARAMETER CheckRate
    The interval in seconds between checks. Default is 300 seconds.
.PARAMETER BasicUsername
    A Basic Auth Username to use to login for a HTTP check
.PARAMETER BasicPassword
    If BasicUser is set then this should be the password for the BasicUser for a HTTP check
.PARAMETER Confirmation
    Number of confirmation servers to use must be between 0 and 3
.PARAMETER ContactID
    An array of contact group IDs to be assigned to the check
.PARAMETER CustomHeader
    Custom HTTP header for the test, must be supplied as as hashtable
.PARAMETER DNSIP
    DNS Tests only. Array of IP addresses to compare against returned DNS records.
.PARAMETER DNSServer
    DNS Tests only. FQDN or IP address of the nameserver to query.
.PARAMETER DoNotFind
    If the value for the FindString parameter should be found to trigger a alert. 1 = will trigger if FindString found
.PARAMETER EnableSSLAlert
    HTTP Tests only. If enabled, tests will send warnings if the SSL certificate is about to expire.
.PARAMETER FinalEndpoint
    Use to specify the expected Final URL in the testing process
.PARAMETER FindString
    A string that should either be found or not found.
.PARAMETER FollowRedirect
    HTTP Tests only. Whether to follow redirects when testing.
.PARAMETER HostingProvider
    Name of the hosting provider
.PARAMETER IncludeHeader
    Include header content in string match search
.PARAMETER Region
    Array of region codes which should be used for the test.
.PARAMETER Paused
    The state of the test should be after it is created. 0 for unpaused, 1 for paused
.PARAMETER PingURL
    A URL to ping if a site goes down
.PARAMETER Port
    The port to use on a TCP/SMTP/SSH test
.PARAMETER PostBody
    Use to populate the POST data field on the test
.PARAMETER PostRaw
    Use to populate the RAW POST data field on the test
.PARAMETER Public
    Set 1 to enable public reporting, 0 to disable
.PARAMETER StatusCode
    Array of StatusCodes that trigger an alert
.PARAMETER Tag
    Array of tags to assign to a test
.PARAMETER Timeout
    Time in seconds before a test times out. Valid values are between 5 and 100 seconds
.PARAMETER TriggerRate
    How many minutes to wait before sending an alert. Valid values are between 0 and 60 minutes
.PARAMETER UseJar
    Set to 1 to enable the Cookie Jar. Required for some redirects.
.PARAMETER UserAgent
    Use to populate the test with a custom user agent
.PARAMETER Force
    Create an uptime test even if one with the same website URL already exists
.PARAMETER Passthru
    Return the uptime test details instead of the uptime test id
.EXAMPLE
    C:\PS>New-StatusCakeHelperUptimeTest -tName "Example" -WebsiteURL "http://www.example.com" -TestType HTTP -CheckRate 300
    Create a HTTP test called "Example" with URL http://www.example.com checking every 300 seconds
.LINK
    https://github.com/Oliver-Lii/statuscake-helpers/blob/master/Documentation/Uptime/New-StatusCakeHelperUptimeTest.md
.LINK
    https://www.statuscake.com/api/v1/#tag/uptime/operation/create-uptime-test
#>
function New-StatusCakeHelperUptimeTest
{
    [CmdletBinding(PositionalBinding=$false,SupportsShouldProcess=$true)]
    Param(
        [ValidateNotNullOrEmpty()]
        [System.Management.Automation.PSCredential] $APICredential = (Get-StatusCakeHelperAPIAuth),

        [Parameter(Mandatory=$true)]
        [ValidateNotNullOrEmpty()]
        [string]$Name,

        [Parameter(Mandatory=$true)]
        [ValidateSet("DNS","HEAD","HTTP","PING","SMTP","SSH","TCP")]
        [Alias('test_type',"TestType")]
        [String]$Type,

        [Parameter(Mandatory=$true)]
        [ValidatePattern('^((http|https):\/\/)?([a-zA-Z0-9\-]+(\.[a-zA-Z]+)+.*)$|^(?!^.*,$)((([0-9]|[1-9][0-9]|1[0-9]{2}|2[0-4][0-9]|25[0-5])\.){3}([0-9]|[1-9][0-9]|1[0-9]{2}|2[0-4][0-9]|25[0-5]))*$')]
        [Alias('website_url','Endpoint','Domain','IP','HostName')]
        [string]$WebsiteURL,

        [Parameter(Mandatory=$true)]
        [ValidateSet("0","30","60","300","900","1800","3600","86400")]
        [Alias('check_rate')]
        [int]$CheckRate,

        #Optional parameters

        [Alias('basic_username')]
        [string]$BasicUsername,

        [Alias('basic_password')]
        [securestring]$BasicPassword,

        [ValidateRange(0,3)]
        [int]$Confirmation,

        [Alias('contact_groups','ContactGroup')]
        [int[]]$ContactID,

        [Alias('custom_header')]
        [hashtable]$CustomHeader,

        [Alias('do_not_find')]
        [boolean]$DoNotFind,

        [Alias("enable_ssl_alert","EnableSSLWarning")]
        [boolean]$EnableSSLAlert,

        [ValidatePattern('^((http|https):\/\/)([a-zA-Z0-9\-]+(\.[a-zA-Z]+)+.*)$|^(?!^.*,$)')]
        [Alias('final_endpoint')]
        [string]$FinalEndpoint,

        [Alias('find_string')]
        [string]$FindString,

        [Alias('follow_redirects')]
        [boolean]$FollowRedirect,

        [Alias('host')]
        [string]$HostingProvider,

        [Alias('include_header')]
        [boolean]$IncludeHeader,

        [boolean]$Paused,

        [Alias('post_body')]
        [object]$PostBody,

        [Alias('post_raw')]
        [string]$PostRaw,

        [ValidateScript({
            if(!($_ | Test-StatusCakeHelperRegionCode)){
                Throw "Supplied region code is invalid [$_]"
            }
            else{$true}
        })]
        [Alias('regions')]
        [String[]]$Region,

        [ValidateScript({
            if(!($_ | Test-StatusCakeHelperHTTPStatusCode)){
                Throw "HTTP Status Code invalid [$_]"
            }
            else{$true}
        })]
        [Alias('status_codes_csv')]
        [int[]]$StatusCode,

        [Alias('tags')]
        [string[]]$Tag,

        [ValidateRange(5,75)]
        [int]$Timeout,

        [ValidateRange(0,60)]
        [Alias('trigger_rate')]
        [int]$TriggerRate,

        [Alias('use_jar')]
        [boolean]$UseJar,

        [Alias('user_agent')]
        [string]$UserAgent,

        [switch]$Force,

        [switch]$PassThru
    )

    DynamicParam
    {
        $paramDictionary = [System.Management.Automation.RuntimeDefinedParameterDictionary]::new()

        if($Type -eq "TCP" -or $Type -eq "SMTP" -or $Type -eq "SSH")
        {
            $portParameter = New-StatusCakeHelperDynamicParameter -Name "Port" -Type "int" -Mandatory $true -ValidateRange @(1,65535)
            $paramDictionary.Add("Port",$portParameter)
        }
        elseif($Type -eq "DNS")
        {
            $dnsIPsParameter = New-StatusCakeHelperDynamicParameter -Name "DNSIPs" -Type "string[]" -Mandatory $true -Alias @("dns_ips") `
                                                -ValidateScript {
                                                    if(!($_ | Test-StatusCakeHelperIPAddress)){
                                                        Throw "Supplied IP Address is invalid [$_]"
                                                    }
                                                    else{$true}
                                                }
            $paramDictionary.Add("DNSIPs",$dnsIPsParameter)

            $dnsServerParameter = New-StatusCakeHelperDynamicParameter -Name "DNSServer" -Type "string" -Mandatory $true -Alias ("dns_server") `
                                                -ValidatePattern '([a-zA-Z0-9\-]{2,}\.[a-zA-Z\-]{2,})(\.[a-zA-Z\-]{2,})?(\.[a-zA-Z\-]{2,})?|^(?!^.*,$)((([0-9]|[1-9][0-9]|1[0-9]{2}|2[0-4][0-9]|25[0-5])\.){3}([0-9]|[1-9][0-9]|1[0-9]{2}|2[0-4][0-9]|25[0-5]))*$'
            $paramDictionary.Add("DNSServer",$dnsServerParameter)
        }
        return $paramDictionary
    }

    Process
    {
        #If force flag not set then check if an existing test with the same name already exists
        if(!$Force)
        {
        $statusCakeItem = Get-StatusCakeHelperUptimeTest -APICredential $APICredential -Name $Name
            if($statusCakeItem)
            {
                    Write-Error "Existing uptime test(s) found with name [$Name]. Please use a different name for the check or use the -Force argument"
                    Return $null
            }
        }

        $allParameterValues = $MyInvocation | Get-StatusCakeHelperParameterValue -BoundParameters $PSBoundParameters
        $statusCakeAPIParams = $allParameterValues | Get-StatusCakeHelperAPIParameter -InvocationInfo $MyInvocation -Exclude "Force" | ConvertTo-StatusCakeHelperAPIValue -CsvString @("status_codes_csv")

        if( $pscmdlet.ShouldProcess("StatusCake API", "Create StatusCake Uptime Check") )
        {
            Return (New-StatusCakeHelperItem -APICredential $APICredential -Type Uptime -Parameter $statusCakeAPIParams -PassThru:$PassThru)
        }
    }
}