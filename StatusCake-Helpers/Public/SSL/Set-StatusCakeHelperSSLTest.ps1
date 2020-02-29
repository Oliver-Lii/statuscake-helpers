
<#
.Synopsis
   Updates a StatusCake SSL Test
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
.EXAMPLE
   Set-StatusCakeHelperSSLTest -id 123456 -checkrate 3600
.FUNCTIONALITY
   Creates a new StatusCake SSL Test using the supplied parameters.
#>
function Set-StatusCakeHelperSSLTest
{
    [CmdletBinding(PositionalBinding=$false,SupportsShouldProcess=$true)]
    Param(
        [Parameter(ParameterSetName='SetByID')]
        [Parameter(ParameterSetName='SetByDomain')]
        [Parameter(ParameterSetName='NewSSLTest')]
        [ValidateNotNullOrEmpty()]
        [System.Management.Automation.PSCredential] $APICredential = (Get-StatusCakeHelperAPIAuth),

        [Parameter(ParameterSetName='SetByID',Mandatory=$true)]
        [int]$id,

        [Parameter(ParameterSetName='SetByDomain',Mandatory=$true)]
        [switch]$SetByDomain,

        [Parameter(ParameterSetName='NewSSLTest',Mandatory=$true)]
        [Parameter(ParameterSetName='SetByDomain')]
        [ValidatePattern('^((https):\/\/)([a-zA-Z0-9\-]+(\.[a-zA-Z]+)+.*)$|^(?!^.*,$)')]
        [string]$domain,

        [Parameter(ParameterSetName='SetByID')]
        [Parameter(ParameterSetName='SetByDomain')]
        [Parameter(ParameterSetName='NewSSLTest',Mandatory=$true)]
        [Int[]]$contact_groups,

        [Parameter(ParameterSetName='SetByID')]
        [Parameter(ParameterSetName='SetByDomain')]
        [Parameter(ParameterSetName='NewSSLTest',Mandatory=$true)]
        [ValidateSet("300","600","1800","3600","86400","2073600")]
        [int]$checkrate,

        [Parameter(ParameterSetName='SetByID')]
        [Parameter(ParameterSetName='SetByDomain')]
        [Parameter(ParameterSetName='NewSSLTest',Mandatory=$true)]
        [Int[]]$alert_at,

        [Parameter(ParameterSetName='SetByID')]
        [Parameter(ParameterSetName='SetByDomain')]
        [Parameter(ParameterSetName='NewSSLTest',Mandatory=$true)]
        [boolean]$alert_expiry,

        [Parameter(ParameterSetName='SetByID')]
        [Parameter(ParameterSetName='SetByDomain')]
        [Parameter(ParameterSetName='NewSSLTest',Mandatory=$true)]
        [boolean]$alert_reminder,

        [Parameter(ParameterSetName='SetByID')]
        [Parameter(ParameterSetName='SetByDomain')]
        [Parameter(ParameterSetName='NewSSLTest',Mandatory=$true)]
        [boolean]$alert_broken,

        [Parameter(ParameterSetName='SetByID')]
        [Parameter(ParameterSetName='SetByDomain')]
        [Parameter(ParameterSetName='NewSSLTest',Mandatory=$true)]
        [boolean]$alert_mixed

    )

    if($Alert_At -and $Alert_At.count -ne 3)
    {
        Write-Error "Only three values must be specified for Alert_At parameter"
        Return
    }

    if($SetByDomain -and $Domain)
    {   #If setting test by domain verify if a test or tests with that name exists
        if( $pscmdlet.ShouldProcess("StatusCake API", "Retrieve StatusCake SSL tests"))
        {
            $sslTest = Get-StatusCakeHelperSSLTest -APICredential $APICredential -Domain $Domain
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
            $sslTest = Get-StatusCakeHelperSSLTest -APICredential $APICredential -id $id
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
            $sslTest = Get-StatusCakeHelperSSLTest -APICredential $APICredential -Domain $Domain
            if($sslTest)
            {
                Write-Error "SSL test with specified name already exists [$Domain] [$($sslTest.id)]"
                Return $null
            }
        }
    }

    $allParameterValues = $MyInvocation | Get-StatusCakeHelperParameterValue -BoundParameters $PSBoundParameters
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

    if( $pscmdlet.ShouldProcess("StatusCake API", "Set StatusCake SSL Test") )
    {
        $response = Invoke-RestMethod @requestParams
        $requestParams=@{}
        if($response.Success -ne "True")
        {
            Write-Error "$($response.Message) [$($response.Issues)]"
            Return $null
        }

        $responseId = $response.Message
        if($id)
        {   #Updating a test does not return an id
            $responseId = $id
        }

        $response = Get-StatusCakeHelperSSLTest -APICredential $APICredential -id $responseId
        Return $response
    }

}