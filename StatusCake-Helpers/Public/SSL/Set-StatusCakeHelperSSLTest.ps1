
<#
.Synopsis
   Updates a StatusCake SSL Test
.EXAMPLE
   Set-StatusCakeHelperSSLTest -Username "Username" -ApiKey "APIKEY" -id 123456 -checkrate 3600
.INPUTS
    baseSSLTestURL - Base URL endpoint of the statuscake ContactGroup API
    Username - Username associated with the API key
    ApiKey - APIKey to access the StatusCake API

    Domain - URL to check SSL certificate, must begin with https://
    CheckRate - Checkrate in seconds.
    Contact_Groups - Array containing contact IDs to alert.
    Alert_At - Number of days before expiration when reminders will be sent. Must be 3 numeric values.
    Alert_Expiry - 	Set to true to enable expiration alerts.
    Alert_Reminder - Set to true to enable reminder alerts.
    Alert_Broken - Set to true to enable broken alerts

.FUNCTIONALITY
   Creates a new StatusCake SSL Test using the supplied parameters.
#>
function Set-StatusCakeHelperSSLTest
{
    [CmdletBinding(PositionalBinding=$false,SupportsShouldProcess=$true)]
    Param(
        #[Parameter(ParameterSetName='SetByDomain',Mandatory=$true)]
        [Parameter(ParameterSetName='SetByID')]
        [Parameter(ParameterSetName='SetByDomain')]
        [Parameter(ParameterSetName='NewSSLTest')]
        $baseSSLTestURL = "https://app.statuscake.com/API/SSL/Update",

        [Parameter(ParameterSetName='SetByID')]
        [Parameter(ParameterSetName='SetByDomain')]
        [Parameter(ParameterSetName='NewSSLTest')]
		[ValidateNotNullOrEmpty()]
        $Username = (Get-StatusCakeHelperAPIAuth).Username,

        [Parameter(ParameterSetName='SetByID')]
        [Parameter(ParameterSetName='SetByDomain')]
        [Parameter(ParameterSetName='NewSSLTest')]
        [ValidateNotNullOrEmpty()]
        $ApiKey = (Get-StatusCakeHelperAPIAuth).GetNetworkCredential().password,

        [Parameter(ParameterSetName='SetByID',Mandatory=$true)]
        $id,

        [Parameter(ParameterSetName='SetByDomain',Mandatory=$true)]
        [switch]$SetByDomain,

        [Parameter(ParameterSetName='NewSSLTest',Mandatory=$true)]
        [Parameter(ParameterSetName='SetByDomain')]
        [ValidatePattern('^((https):\/\/)([a-zA-Z0-9\-]+(\.[a-zA-Z]+)+.*)$|^(?!^.*,$)')]
        $domain,

        [Parameter(ParameterSetName='SetByID')]
        [Parameter(ParameterSetName='SetByDomain')]
        [Parameter(ParameterSetName='NewSSLTest',Mandatory=$true)]
        [ValidateScript({$_ -match '^[\d]+$'})]
        [object]$contact_groups,

        [Parameter(ParameterSetName='SetByID')]
        [Parameter(ParameterSetName='SetByDomain')]
        [Parameter(ParameterSetName='NewSSLTest',Mandatory=$true)]
        [ValidateSet("300","600","1800","3600","86400","2073600")]
        $checkrate,

        [Parameter(ParameterSetName='SetByID')]
        [Parameter(ParameterSetName='SetByDomain')]
        [Parameter(ParameterSetName='NewSSLTest',Mandatory=$true)]
        [ValidateScript({$_ -match '^[\d]+$'})]
        [object]$alert_at,

        [Parameter(ParameterSetName='SetByID')]
        [Parameter(ParameterSetName='SetByDomain')]
        [Parameter(ParameterSetName='NewSSLTest',Mandatory=$true)]
        [ValidateRange(0,1)]
        $alert_expiry,

        [Parameter(ParameterSetName='SetByID')]
        [Parameter(ParameterSetName='SetByDomain')]
        [Parameter(ParameterSetName='NewSSLTest',Mandatory=$true)]
        [ValidateRange(0,1)]
        $alert_reminder,

        [Parameter(ParameterSetName='SetByID')]
        [Parameter(ParameterSetName='SetByDomain')]
        [Parameter(ParameterSetName='NewSSLTest',Mandatory=$true)]
        [ValidateRange(0,1)]
        $alert_broken,

        [Parameter(ParameterSetName='SetByID')]
        [Parameter(ParameterSetName='SetByDomain')]
        [Parameter(ParameterSetName='NewSSLTest',Mandatory=$true)]
        [ValidateRange(0,1)]
        $alert_mixed

    )
    $authenticationHeader = @{"Username"="$Username";"API"="$ApiKey"}
    $statusCakeFunctionAuth = @{"Username"=$Username;"Apikey"=$ApiKey}
    Write-Warning -Message "The output from this function will be changed in the next release"
    if($Alert_At -and $Alert_At.count -ne 3)
    {
        Write-Error "Only three values must be specified for Alert_At parameter"
        Return
    }

    if($SetByDomain -and $Domain)
    {   #If setting test by domain verify if a test or tests with that name exists
        if( $pscmdlet.ShouldProcess("StatusCake API", "Retrieve StatusCake SSL tests"))
        {
            $sslTest = Get-StatusCakeHelperSSLTest @statusCakeFunctionAuth -Domain $Domain
            if(!$sslTest)
            {
                Write-Error "No SSL test with Specified Domain Exists [$Domain]"
                Return $null
            }
            elseif($sslTest.GetType().Name -eq 'Object[]')
            {
                Write-Error "Multiple SSL tests with the same name [$Domain] [$($sslTest.id)]"
                Return $null
            }
            $id = $sslTest.id
        }
    }
    elseif($id)
    {   #If setting by id verify that id already exists
        if( $pscmdlet.ShouldProcess("StatusCake API", "Retrieve StatusCake SSL tests"))
        {
            $sslTest = Get-StatusCakeHelperSSLTest @statusCakeFunctionAuth -id $id
            if(!$sslTest)
            {
                Write-Error "No SSL test with Specified ID Exists [$id]"
                Return $null
            }
            $id = $sslTest.id
        }
    }
    else
    {   #Setup a test with the supplied detiails
        if( $pscmdlet.ShouldProcess("StatusCake API", "Retrieve StatusCake SSL tests") )
        {
            $sslTest = Get-StatusCakeHelperSSLTest @statusCakeFunctionAuth -Domain $Domain
            if($sslTest)
            {
                Write-Error "SSL test with specified name already exists [$Domain] [$($sslTest.id)]"
                Return $null
            }
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
        {   #Contact_Groups can be empty string but must be supplied
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

    if( $pscmdlet.ShouldProcess("StatusCake API", "Set StatusCake SSL Test") )
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