
<#
.Synopsis
   Create a StatusCake test check
.EXAMPLE
   New-StatusCakeHelperTest -Username "Username" -ApiKey "APIKEY" -TestName "Example" -TestURL "http://www.example.com" -TestType HTTP -CheckRate 300
.INPUTS
    baseTestURL - Base URL endpoint of the statuscake test API
    Username - Username associated with the API key
    ApiKey - APIKey to access the StatusCake API
    TestName - Name of the Test to be displayed in StatusCake
    TestURL - Test location, either an IP (for TCP and Ping) or a fully qualified URL for other TestTypes
    CheckRate - The interval in seconds between checks
    TestType - The type of test to create

 <optional parameters>
    BasicPass - If BasicUser is set then this should be the password for the BasicUser for a HTTP check    
    BasicUser - A Basic Auth User account to use to login for a HTTP check
    Branding - Set to 0 to use branding (default) or 1 to disable public reporting branding) 
    Confirmation - Number of confirmation servers to use must be between 0 and 10
    ContactGroup - An array of contact group IDs to be assigned to the check
    CustomHeader - Custom HTTP header for the test, must be supplied as as hashtable 
    DNSIP - DNS Tests only. IP to compare against WebsiteURL value.
    DNSServer - DNS Tests only. Hostname or IP of DNS server to use.   
    DoNotFind - If the above string should be found to trigger a alert. 1 = will trigger if FindString found     
    EnableSSLWarning - HTTP Tests only. If enabled, tests will send warnings if the SSL certificate is about to expire.
    FinalEndpoint - Use to specify the expected Final URL in the testing process
    FindString - A string that should either be found or not found.    
    FollowRedirect - HTTP Tests only. If enabled, our tests will follow redirects and logo the status of the final page.
    LogoImage - A URL to a image to use for public reporting
    NodeLocations - Test locations to use separated by commas. Test location servercodes are required
    Paused - The state of the test should be after it is created. 0 for unpaused, 1 for paused
    PingURL - A URL to ping if a site goes down    
    Port - The port to use on a TCP test
    PostRaw - Use to populate the RAW POST data field on the test
    Public - Set 1 to enable public reporting, 0 to disable
    RealBrowser - Use 1 to TURN OFF real browser testing
    StatusCodes - Comma Separated List of StatusCodes to Trigger Error on (on Update will replace, so send full list each time)
    TestTags - Tags should be seperated by a comma - no spacing between tags (this,is,a set,of,tags)    
    Timeout - Time in seconds before a test times out
    TriggerRate - How many minutes to wait before sending an alert
    UseJar - Set to 1 to enable the Cookie Jar. Required for some redirects.
    UserAgent - Use to populate the test with a custom user agent
    Virus - Enable virus checking or not. 0 to disable and 1 to enable
    WebsiteHost - Used internally by StatusCake. Company which hosts the site being tested.

.FUNCTIONALITY
   Creates a new StatusCake Test using the supplied parameters. Only parameters which have been supplied values are set
   and the defaults for a particular test type are used otherwise.
#>
function New-StatusCakeHelperTest
{
    [CmdletBinding(PositionalBinding=$false,SupportsShouldProcess=$true)]    
    Param(
        $baseTestURL = "https://app.statuscake.com/API/Tests/Update",

        [Parameter(Mandatory=$true)]        
        $Username,

        [Parameter(Mandatory=$true)]        
        $ApiKey,

        [Parameter(Mandatory=$true)]
        [ValidateNotNullOrEmpty()] 
        $TestName,

        [Parameter(Mandatory=$true)]
        [ValidatePattern('^((http|https):\/\/)?([a-zA-Z0-9\-]+(\.[a-zA-Z]+)+.*)$|^(?!^.*,$)((([0-9]|[1-9][0-9]|1[0-9]{2}|2[0-4][0-9]|25[0-5])\.){3}([0-9]|[1-9][0-9]|1[0-9]{2}|2[0-4][0-9]|25[0-5]))*$')]    
        $TestURL,

        [ValidateRange(0,24000)]       
        $CheckRate=300,

        [Parameter(Mandatory=$true)]        
        [ValidateSet("HTTP","TCP","PING","DNS")] 
        [String]$TestType="HTTP",
        
        #Optional parameters

        [securestring]$BasicPass,
        
        [string]$BasicUser,

        [ValidateRange(0,1)]         
        $Branding,
        
        [ValidateRange(0,10)]      
        $Confirmation,

        [ValidateScript({$_ -match '^[\d]+$'})] 
        [object]$ContactGroup,

        [hashtable]$CustomHeader,

        [ValidatePattern('^(?!^.*,$)((([0-9]|[1-9][0-9]|1[0-9]{2}|2[0-4][0-9]|25[0-5])\.){3}([0-9]|[1-9][0-9]|1[0-9]{2}|2[0-4][0-9]|25[0-5]))*$')]             
        [string]$DNSIP,

        [ValidatePattern('([a-zA-Z0-9\-]{2,}\.[a-zA-Z\-]{2,})(\.[a-zA-Z\-]{2,})?(\.[a-zA-Z\-]{2,})?|^(?!^.*,$)((([0-9]|[1-9][0-9]|1[0-9]{2}|2[0-4][0-9]|25[0-5])\.){3}([0-9]|[1-9][0-9]|1[0-9]{2}|2[0-4][0-9]|25[0-5]))*$')]             
        [string]$DNSServer,

        [ValidateRange(0,1)]       
        $DoNotFind,

        [ValidateRange(0,1)]         
        $EnableSSLWarning,

        [ValidatePattern('^((http|https):\/\/)([a-zA-Z0-9\-]+(\.[a-zA-Z]+)+.*)$|^(?!^.*,$)')]   
        [string]$FinalEndpoint,

        [string]$FindString,

        [ValidateRange(0,1)]        
        $FollowRedirect,

        [ValidatePattern('^((http|https):\/\/)([a-zA-Z0-9\-]+(\.[a-zA-Z]+)+.*)$|^(?!^.*,$)')]          
        $LogoImage,

        [object]$NodeLocations,

        [ValidateRange(0,1)]         
        $Paused,

        [ValidatePattern('^((http|https):\/\/)([a-zA-Z0-9\-]+(\.[a-zA-Z]+)+.*)$|^(?!^.*,$)')]                  
        $PingURL,

        [ValidatePattern('^\d{2,}$')]           
        $Port,

        [string]$PostRaw,
               
        [ValidateRange(0,1)]   
        $Public,

        [ValidateRange(0,1)]         
        $RealBrowser,

        [object]$StatusCodes,
        
        [object]$TestTags,

        [ValidateRange(5,100)] 
        $Timeout,

        [ValidateRange(0,60)]                
        $TriggerRate,
        
        [ValidateRange(0,1)]     
        $UseJar,

        [string]$UserAgent,

        [ValidateRange(0,1)]        
        $Virus,

        [string]$WebsiteHost        
    )
    $authenticationHeader = @{"Username"="$username";"API"="$ApiKey"}

    if( $pscmdlet.ShouldProcess("StatusCake API", "Retrieve StatusCake Tests") )
    {
        $testCheck = Get-StatusCakeHelperTest -Username $username -apikey $ApiKey -TestName $TestName
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
    
    if($NodeLocations)
    {
        foreach($node in $NodeLocations)
        {
            Write-Verbose "Validating node location [$node]"
            if(!$($node | Test-StatusCakeHelperNodeLocation))
            {
                Write-Error "Node Location Server code invalid [$node]"
                Return $null           
            }
        }
    }    

    $psParams = @{}
    $ParameterList = (Get-Command -Name $MyInvocation.InvocationName).Parameters
    $ParamsToIgnore = @("baseTestURL","Username","ApiKey")
    foreach ($key in $ParameterList.keys)
    {
        $var = Get-Variable -Name $key -ErrorAction SilentlyContinue;
        if($ParamsToIgnore -contains $var.Name)
        {
            continue
        }
        elseif($var.value -or $var.value -eq 0)
        {   #Validate Range accepts $true or $false values as 0 or 1 so explictly convert to int for StatusCake API        
            $psParams.Add($var.name,$var.value)                  
        }
    }

    $statusCakeAPIParams = $psParams | ConvertTo-StatusCakeHelperAPIParams

    if($statusCakeAPIParams.BasicPass)
    {
        $Credentials = New-Object System.Management.Automation.PSCredential -ArgumentList $statusCakeAPIParams.BasicUser, $statusCakeAPIParams.BasicPass      
        $statusCakeAPIParams.BasicPass = $Credentials.GetNetworkCredential().Password
    }

    $putRequestParams = @{
        uri = $baseTestURL
        Headers = $authenticationHeader
        UseBasicParsing = $true
        method = "Put"
        ContentType = "application/x-www-form-urlencoded"
        body = $statusCakeAPIParams 
    }

    if( $pscmdlet.ShouldProcess("StatusCake API", "Add StatusCake Test") )
    {
        $jsonResponse = Invoke-WebRequest @putRequestParams
        $response = $jsonResponse | ConvertFrom-Json
        if($response.Success -ne "True")
        {
            Write-Error "$($response.Message) [$($response.Issues)]"
            Return $null
        }         
        Return $response
    }

}