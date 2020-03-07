
<#
.Synopsis
   Updates a StatusCake PageSpeed Test
.PARAMETER APICredential
   Credentials to access StatusCake API
.PARAMETER Name
    Name for Page Speed test
.PARAMETER Id
    ID of the PageSpeed Test
.PARAMETER SetByName
    Flag to set to use Page Speed Test name instead of id
.PARAMETER WebsiteURL
    URL that should be checked
.PARAMETER LocationISO
    2-letter ISO code of the location. Valid values: AU, CA, DE, IN, NL, SG, UK, US, PRIVATE
.PARAMETER PrivateName
    Must select PRIVATE in location_iso. Name of private server [NOT YET IMPLEMENTED]
.PARAMETER Checkrate
    Frequency in minutes with which the page speed test should be run
.PARAMETER ContactIDs
    IDs of selected Contact Groups to alert
.PARAMETER AlertSmaller
    Size in kb, will alert to Contact Groups if actual size is smaller
.PARAMETER AlertBigger
    Size in kb, will alert to Contact Groups if actual size is bigger
.PARAMETER AlertSlower
    Time in ms, will alert to Contact Groups if actual time is slower
.EXAMPLE
   Set-StatusCakeHelperPageSpeedTest -ID 123456 -Checkrate 3600
.FUNCTIONALITY
   Set the details of a StatusCake PageSpeed Test using the supplied parameters.
#>
function Set-StatusCakeHelperPageSpeedTest
{
    [CmdletBinding(PositionalBinding=$false,SupportsShouldProcess=$true)]
    Param(
        [Parameter(ParameterSetName='SetByID')]
        [Parameter(ParameterSetName='SetByName')]
        [Parameter(ParameterSetName='NewPageSpeedTest')]
        [ValidateNotNullOrEmpty()]
        [System.Management.Automation.PSCredential] $APICredential = (Get-StatusCakeHelperAPIAuth),

        [Parameter(ParameterSetName='SetByID',Mandatory=$true)]
        [int]$ID,

        [Parameter(ParameterSetName='SetByName',Mandatory=$true)]
        [switch]$SetByName,

        [Parameter(ParameterSetName='NewPageSpeedTest',Mandatory=$true)]
        [Parameter(ParameterSetName='SetByID')]
        [Parameter(ParameterSetName='SetByName')]
        [string]$Name,

        [Parameter(ParameterSetName='SetByID')]
        [Parameter(ParameterSetName='SetByName')]
        [Parameter(ParameterSetName='NewPageSpeedTest',Mandatory=$true)]
        [ValidateSet("1","5","10","15","30","60","1440")]
        [int]$Checkrate,

        [Parameter(ParameterSetName='SetByID')]
        [Parameter(ParameterSetName='SetByName')]
        [Parameter(ParameterSetName='NewPageSpeedTest',Mandatory=$true)]
        [ValidateSet("AU","CA","DE","IN","NL","SG","UK","US","PRIVATE")]
        [Alias('location_iso')]
        [string]$LocationISO,

        [Parameter(ParameterSetName='SetByID')]
        [Parameter(ParameterSetName='SetByName')]
        [Parameter(ParameterSetName='NewPageSpeedTest',Mandatory=$true)]
        [ValidatePattern('^((http|https):\/\/)([a-zA-Z0-9\-]+(\.[a-zA-Z]+)+.*)$|^(?!^.*,$)')]
        [Alias('website_url')]
        [string]$WebsiteURL,

        [Parameter(ParameterSetName='SetByID')]
        [Parameter(ParameterSetName='SetByName')]
        [Parameter(ParameterSetName='NewPageSpeedTest')]
        [Alias('alert_bigger')]
        [int]$AlertBigger=0,

        [Parameter(ParameterSetName='SetByID')]
        [Parameter(ParameterSetName='SetByName')]
        [Parameter(ParameterSetName='NewPageSpeedTest')]
        [Alias('alert_slower')]
        [int]$AlertSlower=0,

        [Parameter(ParameterSetName='SetByID')]
        [Parameter(ParameterSetName='SetByName')]
        [Parameter(ParameterSetName='NewPageSpeedTest')]
        [Alias('alert_smaller')]
        [int]$AlertSmaller=0,

        [Parameter(ParameterSetName='SetByID')]
        [Parameter(ParameterSetName='SetByName')]
        [Parameter(ParameterSetName='NewPageSpeedTest')]
        [Alias('contact_groups')]
        [int[]]$ContactIDs,

        [Parameter(ParameterSetName='SetByID')]
        [Parameter(ParameterSetName='SetByName')]
        [Parameter(ParameterSetName='NewPageSpeedTest')]
        [ValidateNotNullOrEmpty()]
        [Alias('private_name')]
        [string]$PrivateName

    )

    if($SetByName -and $Name)
    {   #If setting test by name verify if a test or tests with that name exists
        if( $pscmdlet.ShouldProcess("StatusCake API", "Retrieve StatusCake PageSpeed tests"))
        {
            $pageSpeedTest = Get-StatusCakeHelperPageSpeedTest -APICredential $APICredential -Name $Name
            if(!$pageSpeedTest)
            {
                Write-Error "No PageSpeed test with Specified name Exists [$Name]"
                Return $null
            }
            elseif($pageSpeedTest.GetType().Name -eq 'Object[]')
            {
                Write-Error "Multiple PageSpeed tests with the same name [$Name] [$($pageSpeedTest.id)]"
                Return $null
            }
            $ID = $pageSpeedTest.id
        }
    }
    elseif($ID)
    {   #If setting by id verify that id already exists
        if( $pscmdlet.ShouldProcess("StatusCake API", "Retrieve StatusCake PageSpeed tests"))
        {
            $pageSpeedTest = Get-StatusCakeHelperPageSpeedTest -APICredential $APICredential -ID $ID
            if(!$pageSpeedTest)
            {
                Write-Error "No PageSpeed test with Specified ID Exists [$ID]"
                Return $null
            }
            $ID = $pageSpeedTest.id
        }
    }
    else
    {   #Setup a test with the supplied detiails
        if( $pscmdlet.ShouldProcess("StatusCake API", "Retrieve StatusCake PageSpeed tests") )
        {
            $pageSpeedTest = Get-StatusCakeHelperPageSpeedTest -APICredential $APICredential -Name $Name
            if($pageSpeedTest)
            {
                Write-Error "PageSpeed test with specified name already exists [$Name] [$($pageSpeedTest.id)]"
                Return $null
            }
        }
    }

    $lower =@('ID','Name','Checkrate')
    $allParameterValues = $MyInvocation | Get-StatusCakeHelperParameterValue -BoundParameters $PSBoundParameters
    $statusCakeAPIParams = $allParameterValues | Get-StatusCakeHelperAPIParameter -InvocationInfo $MyInvocation -ToLowerName $lower
    $statusCakeAPIParams = $statusCakeAPIParams | ConvertTo-StatusCakeHelperAPIParameter

    $requestParams = @{
        uri = "https://app.statuscake.com/API/Pagespeed/Update/"
        Headers = @{"Username"=$APICredential.Username;"API"=$APICredential.GetNetworkCredential().password}
        UseBasicParsing = $true
        method = "Post"
        ContentType = "application/x-www-form-urlencoded"
        body = $statusCakeAPIParams
    }

    if( $pscmdlet.ShouldProcess("StatusCake API", "Set StatusCake PageSpeed Test") )
    {
        $response = Invoke-RestMethod @requestParams
        $requestParams = @{}
        if($response.Success -ne "True")
        {
            Write-Error "$($response.Message) [$($response.Issues)]"
            Return $null
        }
        else
        {   # If there are no changes no id is returned
            if($response.data.new_id)
            {
                $ID = $response.data.new_id
            }
            $result = Get-StatusCakeHelperPageSpeedTestDetail -APICredential $APICredential -ID $ID
        }
        Return $result
    }

}