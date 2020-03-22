
<#
.SYNOPSIS
   Set the configuration of a StatusCake test
.DESCRIPTION
    Sets the test based on the supplied values.
.PARAMETER APICredential
    Credentials to access StatusCake API
.PARAMETER TestID
    ID of the Test
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
.PARAMETER TestTags
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
    C:\PS>Set-StatusCakeHelperTest -TestID "123456" -TestName "http://www.example.com"
    Change the name of test ID 123456 to "http://www.example.com"
#>
function Set-StatusCakeHelperTest
{
    [CmdletBinding(PositionalBinding=$false,SupportsShouldProcess=$true)]
    Param(
        [Parameter(ParameterSetName='SetByTestName')]
        [Parameter(ParameterSetName='SetByTestID')]
        [Parameter(ParameterSetName='SetNewTest')]
        [ValidateNotNullOrEmpty()]
        [System.Management.Automation.PSCredential] $APICredential = (Get-StatusCakeHelperAPIAuth),

        [Parameter(ParameterSetName='SetByTestID',Mandatory=$true)]
        [int]$TestID,

        [Parameter(ParameterSetName='SetByTestName',Mandatory=$true)]
        [switch]$SetByTestName,

        [Alias('WebsiteName')]
        [Parameter(ParameterSetName='SetByTestName',Mandatory=$true)]
        [Parameter(ParameterSetName='SetByTestID')]
        [Parameter(ParameterSetName='SetNewTest',Mandatory=$true)]
        [ValidateNotNullOrEmpty()]
        [string]$TestName,

        [Alias('WebsiteURL')]
        [Parameter(ParameterSetName='SetByTestName')]
        [Parameter(ParameterSetName='SetByTestID')]
        [Parameter(ParameterSetName='SetNewTest',Mandatory=$true)]
        [ValidatePattern('^((http|https):\/\/)?([a-zA-Z0-9\-]+(\.[a-zA-Z]+)+.*)$|^(?!^.*,$)((([0-9]|[1-9][0-9]|1[0-9]{2}|2[0-4][0-9]|25[0-5])\.){3}([0-9]|[1-9][0-9]|1[0-9]{2}|2[0-4][0-9]|25[0-5]))*$')]
        [string]$TestURL,

        [Parameter(ParameterSetName='SetByTestName')]
        [Parameter(ParameterSetName='SetByTestID')]
        [Parameter(ParameterSetName='SetNewTest',Mandatory=$true)]
        [ValidateRange(0,24000)]
        [int]$CheckRate,

        [Parameter(ParameterSetName='SetByTestName')]
        [Parameter(ParameterSetName='SetByTestID')]
        [Parameter(ParameterSetName='SetNewTest',Mandatory=$true)]
        [ValidateSet("HTTP","TCP","PING","DNS")]
        [String]$TestType,

        [Parameter(ParameterSetName='SetByTestName')]
        [Parameter(ParameterSetName='SetByTestID')]
        [Parameter(ParameterSetName='SetNewTest')]
        [securestring]$BasicPass,

        [Parameter(ParameterSetName='SetByTestName')]
        [Parameter(ParameterSetName='SetByTestID')]
        [Parameter(ParameterSetName='SetNewTest')]
        [string]$BasicUser,

        [Parameter(ParameterSetName='SetByTestName')]
        [Parameter(ParameterSetName='SetByTestID')]
        [Parameter(ParameterSetName='SetNewTest')]
        [boolean]$Branding,

        [Parameter(ParameterSetName='SetByTestName')]
        [Parameter(ParameterSetName='SetByTestID')]
        [Parameter(ParameterSetName='SetNewTest')]
        [ValidateRange(0,10)]
        [int]$Confirmation,

        [Parameter(ParameterSetName='SetByTestName')]
        [Parameter(ParameterSetName='SetByTestID')]
        [Parameter(ParameterSetName='SetNewTest')]
        [int[]]$ContactGroup,

        [Parameter(ParameterSetName='SetByTestName')]
        [Parameter(ParameterSetName='SetByTestID')]
        [Parameter(ParameterSetName='SetNewTest')]
        [hashtable]$CustomHeader,

        [Parameter(ParameterSetName='SetByTestName')]
        [Parameter(ParameterSetName='SetByTestID')]
        [Parameter(ParameterSetName='SetNewTest')]
        [ValidatePattern('^(?!^.*,$)((([0-9]|[1-9][0-9]|1[0-9]{2}|2[0-4][0-9]|25[0-5])\.){3}([0-9]|[1-9][0-9]|1[0-9]{2}|2[0-4][0-9]|25[0-5]))*$')]
        [string]$DNSIP,

        [Parameter(ParameterSetName='SetByTestName')]
        [Parameter(ParameterSetName='SetByTestID')]
        [Parameter(ParameterSetName='SetNewTest')]
        [ValidatePattern('^([a-zA-Z0-9]{2,}\.[a-zA-Z]{2,})(\.[a-zA-Z]{2,})?|^(?!^.*,$)((([0-9]|[1-9][0-9]|1[0-9]{2}|2[0-4][0-9]|25[0-5])\.){3}([0-9]|[1-9][0-9]|1[0-9]{2}|2[0-4][0-9]|25[0-5]))*$')]
        [string]$DNSServer,

        [Parameter(ParameterSetName='SetByTestName')]
        [Parameter(ParameterSetName='SetByTestID')]
        [Parameter(ParameterSetName='SetNewTest')]
        [boolean]$DoNotFind,

        [Parameter(ParameterSetName='SetByTestName')]
        [Parameter(ParameterSetName='SetByTestID')]
        [Parameter(ParameterSetName='SetNewTest')]
        [boolean]$EnableSSLWarning,

        [Parameter(ParameterSetName='SetByTestName')]
        [Parameter(ParameterSetName='SetByTestID')]
        [Parameter(ParameterSetName='SetNewTest')]
        [ValidatePattern('^((http|https):\/\/)([a-zA-Z0-9\-]+(\.[a-zA-Z]+)+.*)$|^(?!^.*,$)')]
        [string]$FinalEndpoint,

        [Parameter(ParameterSetName='SetByTestName')]
        [Parameter(ParameterSetName='SetByTestID')]
        [Parameter(ParameterSetName='SetNewTest')]
        [string]$FindString,

        [Parameter(ParameterSetName='SetByTestName')]
        [Parameter(ParameterSetName='SetByTestID')]
        [Parameter(ParameterSetName='SetNewTest')]
        [boolean]$FollowRedirect,

        [Parameter(ParameterSetName='SetByTestName')]
        [Parameter(ParameterSetName='SetByTestID')]
        [Parameter(ParameterSetName='SetNewTest')]
        [ValidatePattern('^((http|https):\/\/)([a-zA-Z0-9\-]+(\.[a-zA-Z]+)+.*)$|^(?!^.*,$)')]
        [string]$LogoImage,

        [Parameter(ParameterSetName='SetByTestName')]
        [Parameter(ParameterSetName='SetByTestID')]
        [Parameter(ParameterSetName='SetNewTest')]
        [ValidateScript({
            if(!($_ | Test-StatusCakeHelperNodeLocation)){
                Throw "Node Location Server code invalid [$_]"
            }
            else{$true}
        })]
        [string[]]$NodeLocations,

        [Parameter(ParameterSetName='SetByTestName')]
        [Parameter(ParameterSetName='SetByTestID')]
        [Parameter(ParameterSetName='SetNewTest')]
        [boolean]$Paused,

        [Parameter(ParameterSetName='SetByTestName')]
        [Parameter(ParameterSetName='SetByTestID')]
        [Parameter(ParameterSetName='SetNewTest')]
        [ValidatePattern('^((http|https):\/\/)([a-zA-Z0-9\-]+(\.[a-zA-Z]+)+.*)$|^(?!^.*,$)')]
        [string]$PingURL,

        [Parameter(ParameterSetName='SetByTestName')]
        [Parameter(ParameterSetName='SetByTestID')]
        [Parameter(ParameterSetName='SetNewTest')]
        [ValidateRange(1,65535)]
        [int]$Port,

        [Parameter(ParameterSetName='SetByTestName')]
        [Parameter(ParameterSetName='SetByTestID')]
        [Parameter(ParameterSetName='SetNewTest')]
        [string]$PostRaw,

        [Parameter(ParameterSetName='SetByTestName')]
        [Parameter(ParameterSetName='SetByTestID')]
        [Parameter(ParameterSetName='SetNewTest')]
        [boolean]$Public,

        [Parameter(ParameterSetName='SetByTestName')]
        [Parameter(ParameterSetName='SetByTestID')]
        [Parameter(ParameterSetName='SetNewTest')]
        [boolean]$RealBrowser,

        [Parameter(ParameterSetName='SetByTestName')]
        [Parameter(ParameterSetName='SetByTestID')]
        [Parameter(ParameterSetName='SetNewTest')]
        [ValidateScript({
            if(!($_ | Test-StatusCakeHelperStatusCode)){
                Throw "HTTP Status Code invalid [$_]"
            }
            else{$true}
        })]
        [string[]]$StatusCodes,

        [Parameter(ParameterSetName='SetByTestName')]
        [Parameter(ParameterSetName='SetByTestID')]
        [Parameter(ParameterSetName='SetNewTest')]
        [Alias('TestTags')]
        [string[]]$Tags,

        [Parameter(ParameterSetName='SetByTestName')]
        [Parameter(ParameterSetName='SetByTestID')]
        [Parameter(ParameterSetName='SetNewTest')]
        [ValidateRange(5,100)]
        [int]$Timeout,

        [Parameter(ParameterSetName='SetByTestName')]
        [Parameter(ParameterSetName='SetByTestID')]
        [Parameter(ParameterSetName='SetNewTest')]
        [ValidateRange(0,60)]
        [int]$TriggerRate,

        [Parameter(ParameterSetName='SetByTestName')]
        [Parameter(ParameterSetName='SetByTestID')]
        [Parameter(ParameterSetName='SetNewTest')]
        [boolean]$UseJar,

        [Parameter(ParameterSetName='SetByTestName')]
        [Parameter(ParameterSetName='SetByTestID')]
        [Parameter(ParameterSetName='SetNewTest')]
        [string]$UserAgent,

        [Parameter(ParameterSetName='SetByTestName')]
        [Parameter(ParameterSetName='SetByTestID')]
        [Parameter(ParameterSetName='SetNewTest')]
        [boolean]$Virus,

        [Parameter(ParameterSetName='SetByTestName')]
        [Parameter(ParameterSetName='SetByTestID')]
        [Parameter(ParameterSetName='SetNewTest')]
        [string]$WebsiteHost
    )
    if($SetByTestName -and $TestName)
    {   #If setting test by name check if a test or tests with that name exists
        if( $pscmdlet.ShouldProcess("StatusCake API", "Retrieve StatusCake Tests"))
        {
            $testCheck = Get-StatusCakeHelperTest -APICredential $APICredential -TestName $TestName
            if(!$testCheck)
            {
                Write-Error "No Test with Specified Name Exists [$TestName]"
                Return $null
            }
            elseif($testCheck.GetType().Name -eq 'Object[]')
            {
                Write-Error "Multiple Tests with the same name [$TestName] [$($testCheck.TestID)]"
                Return $null
            }
            $TestID = $testCheck.TestID
        }
    }
    elseif($TestID)
    {   #If setting by TestID verify that TestID already exists
        if( $pscmdlet.ShouldProcess("StatusCake API", "Retrieve StatusCake Tests"))
        {
            $testCheck = Get-StatusCakeHelperTestDetail -APICredential $APICredential -TestID $TestID -ErrorAction SilentlyContinue
            if(!$testCheck)
            {
                Write-Error "No Test with Specified ID Exists [$TestID]"
                Return $null
            }
            $TestID = $testCheck.TestID
        }
    }
    else
    {   #Setup a test with the supplied details
        if( $pscmdlet.ShouldProcess("StatusCake API", "Retrieve StatusCake Tests") )
        {
            $testCheck = Get-StatusCakeHelperTest -APICredential $APICredential -TestName $TestName
            if($testCheck)
            {
                Write-Error "Test with specified name already exists [$TestName] [$($testCheck.TestID)]"
                Return $null
            }
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

    $requestParams = @{
        uri = "https://app.statuscake.com/API/Tests/Update"
        Headers = @{"Username"=$APICredential.Username;"API"=$APICredential.GetNetworkCredential().password}
        UseBasicParsing = $true
        method = "Put"
        ContentType = "application/x-www-form-urlencoded"
        body = $statusCakeAPIParams
    }

    if( $pscmdlet.ShouldProcess("StatusCake API", "Set StatusCake Test") )
    {
        $response = Invoke-RestMethod @requestParams
        $requestParams=@{}
        $statusCakeAPIParams=@{}
        if($response.Success -ne "True")
        {
            Write-Error "$($response.Message) [$($response.Issues)]"
            Return $null
        }
        if($response.InsertID)
        {
            $TestID = $response.InsertID
        }
        $statusCakeTestDetail = Get-StatusCakeHelperTestDetail -APICredential $APICredential -TestID $TestID
        Return $statusCakeTestDetail
    }
}