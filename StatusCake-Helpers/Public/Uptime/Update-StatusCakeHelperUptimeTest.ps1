<#
.SYNOPSIS
    Create a StatusCake uptime tes
.DESCRIPTION
    Creates a new StatusCake Uptime Test using the supplied parameters. Only parameters which have been supplied values are set
    and the defaults for a particular test type are used otherwise.
.PARAMETER APICredential
    Credentials to access StatusCake API
.PARAMETER ID
    ID of the Test to be updated in StatusCake
.PARAMETER Name
    Name of the Test to be updated in StatusCake
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
    DNS Tests only. IP to compare against WebsiteURL value.
.PARAMETER DNSServer
    DNS Tests only. Hostname or IP of DNS server to use.
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
.PARAMETER Regions
    List of region codes which should be used for the test.
.PARAMETER Paused
    The state of the test should be after it is created. 0 for unpaused, 1 for paused
.PARAMETER Port
    The port to use on a TCP/SMTP/SSH test
.PARAMETER PostBody
    Use to populate the POST data field on the test
.PARAMETER PostRaw
    Use to populate the RAW POST data field on the test
.PARAMETER Public
    Set 1 to enable public reporting, 0 to disable
.PARAMETER StatusCodes
    Array of StatusCodes that trigger an alert
.PARAMETER Tags
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
.EXAMPLE
    C:\PS>Update-StatusCakeHelperUptimeTest -tName "Example" -WebsiteURL "http://www.example.com" -TestType HTTP -CheckRate 300
    Create a HTTP test called "Example" with URL http://www.example.com checking every 300 seconds
.LINK
    https://github.com/Oliver-Lii/statuscake-helpers/blob/master/Documentation/Uptime/Update-StatusCakeHelperUptimeTest.md
.LINK
    https://www.statuscake.com/api/v1/#tag/uptime/operation/create-uptime-test
#>
function Update-StatusCakeHelperUptimeTest
{
    [CmdletBinding(PositionalBinding=$false,SupportsShouldProcess=$true)]
    Param(
        [ValidateNotNullOrEmpty()]
        [System.Management.Automation.PSCredential] $APICredential = (Get-StatusCakeHelperAPIAuth),

        [Parameter(ParameterSetName = "ID")]
        [ValidateNotNullOrEmpty()]
        [int]$ID,

        [Parameter(ParameterSetName = "Name")]
        [ValidateNotNullOrEmpty()]
        [string]$Name,

        [ValidateSet("DNS","HEAD","HTTP","PING","SMTP","SSH","TCP")]
        [Alias('test_type',"TestType")]
        [String]$Type,

        [ValidatePattern('^((http|https):\/\/)?([a-zA-Z0-9\-]+(\.[a-zA-Z]+)+.*)$|^(?!^.*,$)((([0-9]|[1-9][0-9]|1[0-9]{2}|2[0-4][0-9]|25[0-5])\.){3}([0-9]|[1-9][0-9]|1[0-9]{2}|2[0-4][0-9]|25[0-5]))*$')]
        [Alias('website_url','Endpoint','Domain','IP','HostName')]
        [string]$WebsiteURL,

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

        [ValidateScript({
            if(!($_ | Test-StatusCakeHelperIPAddress)){
                Throw "Supplied IP Address is invalid [$_]"
            }
            else{$true}
        })]
        [Alias('dns_ips')]
        [string]$DNSIP,

        [ValidatePattern('^([a-zA-Z0-9]{2,}\.[a-zA-Z]{2,})(\.[a-zA-Z]{2,})?|^(?!^.*,$)((([0-9]|[1-9][0-9]|1[0-9]{2}|2[0-4][0-9]|25[0-5])\.){3}([0-9]|[1-9][0-9]|1[0-9]{2}|2[0-4][0-9]|25[0-5]))*$')]
        [Alias('dns_server')]
        [string]$DNSServer,

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

        [ValidateRange(1,65535)]
        [int]$Port,

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
        [String[]]$Regions,

        [ValidateScript({
            if(!($_ | Test-StatusCakeHelperHTTPStatusCode)){
                Throw "HTTP Status Code invalid [$_]"
            }
            else{$true}
        })]
        [Alias('status_codes_csv')]
        [int[]]$StatusCodes,

        [string[]]$Tags,

        [ValidateRange(5,75)]
        [int]$Timeout,

        [ValidateRange(0,60)]
        [Alias('trigger_rate')]
        [int]$TriggerRate,

        [Alias('use_jar')]
        [boolean]$UseJar,

        [Alias('user_agent')]
        [string]$UserAgent
    )

    if($Name)
    {
       $statusCakeItem = Get-StatusCakeHelperUptimeTest -APICredential $APICredential -Name $Name
       if(!$statusCakeItem)
       {
            Write-Error "No Uptime test(s) found with name [$Name]"
            Return $null
       }
       elseif($statusCakeItem.GetType().Name -eq 'Object[]')
       {
           Write-Error "Multiple Uptime Tests found with name [$Name]. Please update the Uptime test by ID"
           Return $null
       }
       $ID = $statusCakeItem.id
    }

    $allParameterValues = $MyInvocation | Get-StatusCakeHelperParameterValue -BoundParameters $PSBoundParameters
    $statusCakeAPIParams = $allParameterValues | Get-StatusCakeHelperAPIParameter -InvocationInfo $MyInvocation -Exclude "Force" | ConvertTo-StatusCakeHelperAPIValue -CsvString @("status_codes_csv")

    if( $pscmdlet.ShouldProcess("$ID", "Update StatusCake Uptime Test") )
    {
        Return (Update-StatusCakeHelperItem -APICredential $APICredential -Type Uptime -ID $ID -Parameter $statusCakeAPIParams)
    }
}