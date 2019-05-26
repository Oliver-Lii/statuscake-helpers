
<#
.Synopsis
   Create a StatusCake SSL Test
.EXAMPLE
   New-StatusCakeHelperSSLTest -Username "Username" -ApiKey "APIKEY" -Domain "https://www.example.com" -checkrate 3600
.INPUTS
    baseSSLTestURL - Base URL endpoint of the statuscake ContactGroup API
    Username - Username associated with the API key
    ApiKey - APIKey to access the StatusCake API
    
    Domain - URL to check SSL certificate, must begin with https://
    CheckRate - Checkrate in seconds.
    Contact_Groups - Array containing contact IDs to alert.
    Alert_At - Number of days before expiration when reminders will be sent. Defaults to reminders at 60, 30 and 7 days. Must be 3 numeric values.
    Alert_expiry - 	Set to true to enable expiration alerts. False to disable
    Alert_reminder - Set to true to enable reminder alerts. False to disable
    Alert_broken - Set to true to enable broken alerts. False to disable
    Alert_mixed - Set to true to enable mixed content alerts. False to disable

.FUNCTIONALITY
   Creates a new StatusCake SSL Test using the supplied parameters.
#>
function New-StatusCakeHelperSSLTest
{
    [CmdletBinding(PositionalBinding=$false,SupportsShouldProcess=$true)]
    Param(
        $baseSSLTestURL = "https://app.statuscake.com/API/SSL/Update",

		[ValidateNotNullOrEmpty()]
        $Username = (Get-StatusCakeHelperAPIAuth).Username,
        [ValidateNotNullOrEmpty()]
        $ApiKey = (Get-StatusCakeHelperAPIAuth).GetNetworkCredential().password,

        [Parameter(Mandatory=$true)] 
        [ValidatePattern('^((https):\/\/)([a-zA-Z0-9\-]+(\.[a-zA-Z]+)+.*)$|^(?!^.*,$)')]
        $domain,

        #Contact_Groups must be supplied
        [ValidateScript({$_ -match '^[\d]+$'})] 
        [object]$contact_groups="0",

        [Parameter(Mandatory=$true)] 
        [ValidateSet("300","600","1800","3600","86400","2073600")]
        $checkrate,

        [ValidateScript({$_ -match '^[\d]+$'})]
        [object]$alert_at=@("7","30","60"),

        [ValidateRange(0,1)]
        $alert_expiry=1,

        [ValidateRange(0,1)]
        $alert_reminder=1,

        [ValidateRange(0,1)]
        $alert_broken=1,

        [ValidateRange(0,1)]
        $alert_mixed=1

    )
    $authenticationHeader = @{"Username"="$Username";"API"="$ApiKey"}
    $statusCakeFunctionAuth = @{"Username"=$Username;"Apikey"=$ApiKey}
 
    if($Alert_At.count -ne 3)
    {
        Write-Error "Only three values must be specified for Alert_At parameter"
        Return
    }

    if( $pscmdlet.ShouldProcess("StatusCake API", "Retrieve StatusCake SSL Checks") )
    {
        $sslTest = Get-StatusCakeHelperSSLTest @statusCakeFunctionAuth -domain $domain
        if($sslTest)
        {
            Write-Error "SSL Check with specified domain already exists [$domain] [$($sslTest.id)]"
            Return $null 
        }
    }    

    $psParams = @{}
    $ParameterList = (Get-Command -Name $MyInvocation.InvocationName).Parameters
    $ParamsToIgnore = @("baseSSLTestURL","Username","ApiKey")
    foreach ($key in $ParameterList.keys)
    {
        $var = Get-Variable -Name $key -ErrorAction SilentlyContinue;
        
        if($ParamsToIgnore -contains $var.Name)
        {
            continue
        }
        elseif($var.value -or $var.value -eq 0)
        {   
            $psParams.Add($var.name,$var.value)                  
        }
    }

    $statusCakeAPIParams = $psParams | ConvertTo-StatusCakeHelperAPIParams

    $putRequestParams = @{
        uri = $baseSSLTestURL
        Headers = $authenticationHeader
        UseBasicParsing = $true
        method = "Put"
        ContentType = "application/x-www-form-urlencoded"
        body = $statusCakeAPIParams 
    }

    if( $pscmdlet.ShouldProcess("StatusCake API", "Add StatusCake SSL Test") )
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