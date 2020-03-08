<#
.Synopsis
   Create a StatusCake test check
.PARAMETER APICredential
    Credentials to access StatusCake API
.PARAMETER TestName
    Name of the Test to be displayed in StatusCake
.PARAMETER TestURL
    Test location, either an IP (for TCP and Ping) or a fully qualified URL for other TestTypes
.PARAMETER CheckRate
    The interval in seconds between checks
.PARAMETER TestType
    The type of test to create. Valid options are "HTTP","TCP","PING","DNS"
.PARAMETER BasicUser
    A Basic Auth User account to use to login for a HTTP check
.PARAMETER BasicPass
    If BasicUser is set then this should be the password for the BasicUser for a HTTP check
.PARAMETER Branding
    Set to 0 to use branding (default) or 1 to disable public reporting branding
.PARAMETER Confirmation
    Number of confirmation servers to use must be between 0 and 10
.PARAMETER ContactGroup
    An array of contact group IDs to be assigned to the check
.PARAMETER CustomHeader
    Custom HTTP header for the test, must be supplied as as hashtable
.PARAMETER DNSIP
    DNS Tests only. IP to compare against WebsiteURL value.
.PARAMETER DNSServer
    DNS Tests only. Hostname or IP of DNS server to use.
.PARAMETER DoNotFind
    If the value for the FindString parameter should be found to trigger a alert. 1 = will trigger if FindString found
.PARAMETER EnableSSLWarning
    HTTP Tests only. If enabled, tests will send warnings if the SSL certificate is about to expire.
.PARAMETER FinalEndpoint
    Use to specify the expected Final URL in the testing process
.PARAMETER FindString
    A string that should either be found or not found.
.PARAMETER FollowRedirect
    HTTP Tests only. If enabled, our tests will follow redirects and logo the status of the final page.
.PARAMETER LogoImage
    A URL to a image to use for public reporting
.PARAMETER NodeLocations
    Test locations to use separated by commas. Test location servercodes are required
.PARAMETER Paused
    The state of the test should be after it is created. 0 for unpaused, 1 for paused
.PARAMETER PingURL
    A URL to ping if a site goes down
.PARAMETER Port
    The port to use on a TCP test
.PARAMETER PostRaw
    Use to populate the RAW POST data field on the test
.PARAMETER Public
    Set 1 to enable public reporting, 0 to disable
.PARAMETER RealBrowser
    Use 1 to TURN OFF real browser testing
.PARAMETER StatusCodes
    Comma Separated List of StatusCodes to Trigger Error on (on Update will replace, so send full list each time)
.PARAMETER Tags
    Array of tags to assign to a test
.PARAMETER Timeout
    Time in seconds before a test times out
.PARAMETER TriggerRate
    How many minutes to wait before sending an alert
.PARAMETER UseJar
    Set to 1 to enable the Cookie Jar. Required for some redirects.
.PARAMETER UserAgent
    Use to populate the test with a custom user agent
.PARAMETER Virus
    Enable virus checking or not. 0 to disable and 1 to enable
.PARAMETER WebsiteHost
    Used internally by StatusCake. Company which hosts the site being tested.
.EXAMPLE
   New-StatusCakeHelperTest -TestName "Example" -TestURL "http://www.example.com" -TestType HTTP -CheckRate 300
.FUNCTIONALITY
   Creates a new StatusCake Test using the supplied parameters. Only parameters which have been supplied values are set
   and the defaults for a particular test type are used otherwise.
#>
function New-StatusCakeHelperTest
{
    [CmdletBinding(PositionalBinding=$false,SupportsShouldProcess=$true)]
    Param(
        [ValidateNotNullOrEmpty()]
        [System.Management.Automation.PSCredential] $APICredential = (Get-StatusCakeHelperAPIAuth),

        [Parameter(Mandatory=$true)]
        [Alias('WebsiteName')]
        [ValidateNotNullOrEmpty()]
        [string]$TestName,

        [Parameter(Mandatory=$true)]
        [Alias('WebsiteURL')]
        [ValidatePattern('^((http|https):\/\/)?([a-zA-Z0-9\-]+(\.[a-zA-Z]+)+.*)$|^(?!^.*,$)((([0-9]|[1-9][0-9]|1[0-9]{2}|2[0-4][0-9]|25[0-5])\.){3}([0-9]|[1-9][0-9]|1[0-9]{2}|2[0-4][0-9]|25[0-5]))*$')]
        [string]$TestURL,

        [Parameter(Mandatory=$true)]
        [ValidateRange(0,24000)]
        [int]$CheckRate=300,

        [Parameter(Mandatory=$true)]
        [ValidateSet("HTTP","TCP","PING","DNS")]
        [String]$TestType="HTTP",

        #Optional parameters

        [string]$BasicUser,

        [securestring]$BasicPass,

        [boolean]$Branding,

        [ValidateRange(0,10)]
        [int]$Confirmation,

        [int[]]$ContactGroup,

        [hashtable]$CustomHeader,

        [ValidatePattern('^(?!^.*,$)((([0-9]|[1-9][0-9]|1[0-9]{2}|2[0-4][0-9]|25[0-5])\.){3}([0-9]|[1-9][0-9]|1[0-9]{2}|2[0-4][0-9]|25[0-5]))*$')]
        [string]$DNSIP,

        [ValidatePattern('([a-zA-Z0-9\-]{2,}\.[a-zA-Z\-]{2,})(\.[a-zA-Z\-]{2,})?(\.[a-zA-Z\-]{2,})?|^(?!^.*,$)((([0-9]|[1-9][0-9]|1[0-9]{2}|2[0-4][0-9]|25[0-5])\.){3}([0-9]|[1-9][0-9]|1[0-9]{2}|2[0-4][0-9]|25[0-5]))*$')]
        [string]$DNSServer,

        [boolean]$DoNotFind,

        [boolean]$EnableSSLWarning,

        [ValidatePattern('^((http|https):\/\/)([a-zA-Z0-9\-]+(\.[a-zA-Z]+)+.*)$|^(?!^.*,$)')]
        [string]$FinalEndpoint,

        [string]$FindString,

        [boolean]$FollowRedirect,

        [ValidatePattern('^((http|https):\/\/)([a-zA-Z0-9\-]+(\.[a-zA-Z]+)+.*)$|^(?!^.*,$)')]
        [String]$LogoImage,

        [ValidateScript({
            if(!($_ | Test-StatusCakeHelperNodeLocation)){
                Throw "Node Location Server code invalid [$_]"
            }
            else{$true}
        })]
        [string[]]$NodeLocations,

        [boolean]$Paused,

        [ValidatePattern('^((http|https):\/\/)([a-zA-Z0-9\-]+(\.[a-zA-Z]+)+.*)$|^(?!^.*,$)')]
        [string]$PingURL,

        [ValidateRange(1,65535)]
        [int]$Port,

        [string]$PostRaw,

        [boolean]$Public,

        [boolean]$RealBrowser,

        [ValidateScript({
            if(!($_ | Test-StatusCakeHelperStatusCode)){
                Throw "HTTP Status Code invalid [$_]"
            }
            else{$true}
        })]
        [int[]]$StatusCodes,

        [Alias('TestTags')]
        [string[]]$Tags,

        [ValidateRange(5,100)]
        [int]$Timeout,

        [ValidateRange(0,60)]
        [int]$TriggerRate,

        [boolean]$UseJar,

        [string]$UserAgent,

        [boolean]$Virus,

        [string]$WebsiteHost
    )

    if( $pscmdlet.ShouldProcess("StatusCake API", "Retrieve StatusCake Tests") )
    {
        $testCheck = Get-StatusCakeHelperTest -APICredential $APICredential -TestName $TestName
        if($testCheck)
        {
            Write-Error "Test with specified name already exists [$TestName] [$($testCheck.TestID)]"
            Return $null
        }
    }

    $convertTestURL = $false
    switch($TestType)
    {
        "DNS"{
            If(!$DNSIP)
            {
                Write-Error "No DNSIP supplied for DNS test type"
                Return $null
            }
            $convertTestURL = $true
        }
        "PING"{$convertTestURL = $true}
        "TCP"{
            If(!$Port)
            {
                Write-Error "No Port supplied for TCP test type"
                Return $null
            }
            $convertTestURL = $true
        }
        Default{}
    }

    #Certain test types require only the domain name so remove protocol if it is part of the TestURL
    if($convertTestURL -and $TestURL)
    {
        $TestURL = $TestURL | ConvertTo-StatusCakeHelperDomainName
    }

    $allParameterValues = $MyInvocation | Get-StatusCakeHelperParameterValue -BoundParameters $PSBoundParameters
    $statusCakeAPIParams = $allParameterValues | Get-StatusCakeHelperAPIParameter -InvocationInfo $MyInvocation
    $statusCakeAPIParams = $statusCakeAPIParams | ConvertTo-StatusCakeHelperAPIParameter

    if($statusCakeAPIParams.ContainsKey("BasicPass"))
    {
        $Credentials = New-Object System.Management.Automation.PSCredential -ArgumentList $statusCakeAPIParams["BasicUser"], $statusCakeAPIParams["BasicPass"]
        $statusCakeAPIParams["BasicPass"] = $Credentials.GetNetworkCredential().Password
    }

    $requestParams = @{
        uri = "https://app.statuscake.com/API/Tests/Update"
        Headers = @{"Username"=$APICredential.Username;"API"=$APICredential.GetNetworkCredential().password}
        UseBasicParsing = $true
        method = "Put"
        ContentType = "application/x-www-form-urlencoded"
        body = $statusCakeAPIParams
    }

    if( $pscmdlet.ShouldProcess("StatusCake API", "Add StatusCake Test") )
    {
        $response = Invoke-RestMethod @requestParams
        $requestParams=@{}
        $statusCakeAPIParams=@{}
        if($response.Success -ne "True")
        {
            Write-Error "$($response.Message) [$($response.Issues)]"
            Return $null
        }
        $statusCakeTestDetail = Get-StatusCakeHelperTestDetail -APICredential $APICredential -TestID $response.InsertID
        Return $statusCakeTestDetail
    }
}