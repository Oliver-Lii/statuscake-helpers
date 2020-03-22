
<#
.SYNOPSIS
    Updates a StatusCake SSL Test
.DESCRIPTION
    Sets the configuration of a StatusCake SSL Test using the supplied parameters.
.PARAMETER APICredential
    Credentials to access StatusCake API
.PARAMETER Domain
    URL domain to update
.PARAMETER ID
    Test ID to retrieve
.PARAMETER SetByDomain
    Switch to update SSL test by domain name
.PARAMETER CheckRate
    Checkrate in seconds. Options are 300 (5 minutes), 600 (10 minutes), 1800 (30 minutes), 3600 (1 hour), 86400 (1 day), 2073600 (24 days)
.PARAMETER ContactIDs
    Array containing contact IDs to alert.
.PARAMETER AlertAt
    Number of days before expiration when reminders will be sent. Must be 3 numeric values.
.PARAMETER AlertExpiry
    Set to true to enable expiration alerts. False to disable
.PARAMETER AlertReminder
    Set to true to enable reminder alerts. False to disable
.PARAMETER AlertBroken
    Set to true to enable broken alerts. False to disable
.PARAMETER AlertMixed
    Set to true to enable mixed content alerts. False to disable
.EXAMPLE
    C:\PS>Set-StatusCakeHelperSSLTest -id 123456 -checkrate 3600
    Change the checkrate of test with ID 123456 to 3600 seconds
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
        [int]$ID,

        [Parameter(ParameterSetName='SetByDomain',Mandatory=$true)]
        [switch]$SetByDomain,

        [Parameter(ParameterSetName='NewSSLTest',Mandatory=$true)]
        [Parameter(ParameterSetName='SetByDomain')]
        [ValidatePattern('^((https):\/\/)([a-zA-Z0-9\-]+(\.[a-zA-Z]+)+.*)$|^(?!^.*,$)')]
        [string]$Domain,

        [Parameter(ParameterSetName='SetByID')]
        [Parameter(ParameterSetName='SetByDomain')]
        [Parameter(ParameterSetName='NewSSLTest',Mandatory=$true)]
        [Alias('contact_groups')]
        [int[]]$ContactIDs,

        [Parameter(ParameterSetName='SetByID')]
        [Parameter(ParameterSetName='SetByDomain')]
        [Parameter(ParameterSetName='NewSSLTest',Mandatory=$true)]
        [ValidateSet("300","600","1800","3600","86400","2073600")]
        [int]$Checkrate,

        [Parameter(ParameterSetName='SetByID')]
        [Parameter(ParameterSetName='SetByDomain')]
        [Parameter(ParameterSetName='NewSSLTest',Mandatory=$true)]
        [Alias('alert_at')]
        [ValidateCount(3,3)]
        [Int[]]$AlertAt,

        [Parameter(ParameterSetName='SetByID')]
        [Parameter(ParameterSetName='SetByDomain')]
        [Parameter(ParameterSetName='NewSSLTest',Mandatory=$true)]
        [Alias('alert_expiry')]
        [boolean]$AlertExpiry,

        [Parameter(ParameterSetName='SetByID')]
        [Parameter(ParameterSetName='SetByDomain')]
        [Parameter(ParameterSetName='NewSSLTest',Mandatory=$true)]
        [Alias('alert_reminder')]
        [boolean]$AlertReminder,

        [Parameter(ParameterSetName='SetByID')]
        [Parameter(ParameterSetName='SetByDomain')]
        [Parameter(ParameterSetName='NewSSLTest',Mandatory=$true)]
        [Alias('alert_broken')]
        [boolean]$AlertBroken,

        [Parameter(ParameterSetName='SetByID')]
        [Parameter(ParameterSetName='SetByDomain')]
        [Parameter(ParameterSetName='NewSSLTest',Mandatory=$true)]
        [Alias('alert_mixed')]
        [boolean]$AlertMixed

    )

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
            $ID = $sslTest.id
        }
    }
    elseif($ID)
    {   #If setting by id verify that id already exists
        if( $pscmdlet.ShouldProcess("StatusCake API", "Retrieve StatusCake SSL tests"))
        {
            $sslTest = Get-StatusCakeHelperSSLTest -APICredential $APICredential -id $ID
            if(!$sslTest)
            {
                Write-Error "No SSL test with Specified ID Exists [$ID]"
                Return $null
            }
            $ID = $sslTest.id
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

    $lower = @('ID','Checkrate','Domain')
    $allParameterValues = $MyInvocation | Get-StatusCakeHelperParameterValue -BoundParameters $PSBoundParameters
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
        if($ID)
        {   #Updating a test does not return an id
            $responseId = $ID
        }

        $response = Get-StatusCakeHelperSSLTest -APICredential $APICredential -id $responseId
        Return $response
    }

}