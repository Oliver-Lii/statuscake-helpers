
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
.PARAMETER Website_Url
    URL that should be checked
.PARAMETER Location_iso
    2-letter ISO code of the location. Valid values: AU, CA, DE, IN, NL, SG, UK, US, PRIVATE
.PARAMETER Private_Name
    Must select PRIVATE in location_iso. Name of private server [NOT YET IMPLEMENTED]
.PARAMETER Checkrate
    Frequency in minutes with which the page speed test should be run
.PARAMETER Contact_Groups
    IDs of selected Contact Groups to alert
.PARAMETER Alert_Smaller
    Size in kb, will alert to Contact Groups if actual size is smaller
.PARAMETER Alert_Bigger
    Size in kb, will alert to Contact Groups if actual size is bigger
.PARAMETER Alert_Slower
    Time in ms, will alert to Contact Groups if actual time is slower
.EXAMPLE
   Set-StatusCakeHelperPageSpeedTest -Username "Username" -ApiKey "APIKEY" -id 123456 -checkrate 3600
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
        [int]$id,

        [Parameter(ParameterSetName='SetByName',Mandatory=$true)]
        [switch]$SetByName,

        [Parameter(ParameterSetName='NewPageSpeedTest',Mandatory=$true)]
        [Parameter(ParameterSetName='SetByID')]
        [Parameter(ParameterSetName='SetByName')]
        [string]$name,

        [Parameter(ParameterSetName='SetByID')]
        [Parameter(ParameterSetName='SetByName')]
        [Parameter(ParameterSetName='NewPageSpeedTest',Mandatory=$true)]
        [ValidateSet("1","5","10","15","30","60","1440")]
        [int]$checkrate,

        [Parameter(ParameterSetName='SetByID')]
        [Parameter(ParameterSetName='SetByName')]
        [Parameter(ParameterSetName='NewPageSpeedTest',Mandatory=$true)]
        [ValidateSet("AU","CA","DE","IN","NL","SG","UK","US","PRIVATE")]
        [string]$location_iso,

        [Parameter(ParameterSetName='SetByID')]
        [Parameter(ParameterSetName='SetByName')]
        [Parameter(ParameterSetName='NewPageSpeedTest',Mandatory=$true)]
        [ValidatePattern('^((http|https):\/\/)([a-zA-Z0-9\-]+(\.[a-zA-Z]+)+.*)$|^(?!^.*,$)')]
        [string]$website_url,

        [Parameter(ParameterSetName='SetByID')]
        [Parameter(ParameterSetName='SetByName')]
        [Parameter(ParameterSetName='NewPageSpeedTest')]
        [ValidateScript({$_ -match '^[\d]+$'})]
        [int]$alert_bigger=0,

        [Parameter(ParameterSetName='SetByID')]
        [Parameter(ParameterSetName='SetByName')]
        [Parameter(ParameterSetName='NewPageSpeedTest')]
        [ValidateScript({$_ -match '^[\d]+$'})]
        [int]$alert_slower=0,

        [Parameter(ParameterSetName='SetByID')]
        [Parameter(ParameterSetName='SetByName')]
        [Parameter(ParameterSetName='NewPageSpeedTest')]
        [ValidateScript({$_ -match '^[\d]+$'})]
        [int]$alert_smaller=0,

        [Parameter(ParameterSetName='SetByID')]
        [Parameter(ParameterSetName='SetByName')]
        [Parameter(ParameterSetName='NewPageSpeedTest')]
        [Int32[]]$contact_groups,

        [Parameter(ParameterSetName='SetByID')]
        [Parameter(ParameterSetName='SetByName')]
        [Parameter(ParameterSetName='NewPageSpeedTest')]
        [ValidateNotNullOrEmpty()]
        [string]$private_name

    )

    if($SetByName -and $name)
    {   #If setting test by name verify if a test or tests with that name exists
        if( $pscmdlet.ShouldProcess("StatusCake API", "Retrieve StatusCake PageSpeed tests"))
        {
            $pageSpeedTest = Get-StatusCakeHelperPageSpeedTest -APICredential $APICredential -name $name
            if(!$pageSpeedTest)
            {
                Write-Error "No PageSpeed test with Specified name Exists [$name]"
                Return $null
            }
            elseif($pageSpeedTest.GetType().Name -eq 'Object[]')
            {
                Write-Error "Multiple PageSpeed tests with the same name [$name] [$($pageSpeedTest.id)]"
                Return $null
            }
            $id = $pageSpeedTest.id
        }
    }
    elseif($id)
    {   #If setting by id verify that id already exists
        if( $pscmdlet.ShouldProcess("StatusCake API", "Retrieve StatusCake PageSpeed tests"))
        {
            $pageSpeedTest = Get-StatusCakeHelperPageSpeedTest -APICredential $APICredential -id $id
            if(!$pageSpeedTest)
            {
                Write-Error "No PageSpeed test with Specified ID Exists [$id]"
                Return $null
            }
            $id = $pageSpeedTest.id
        }
    }
    else
    {   #Setup a test with the supplied detiails
        if( $pscmdlet.ShouldProcess("StatusCake API", "Retrieve StatusCake PageSpeed tests") )
        {
            $pageSpeedTest = Get-StatusCakeHelperPageSpeedTest -APICredential $APICredential -name $name
            if($pageSpeedTest)
            {
                Write-Error "PageSpeed test with specified name already exists [$name] [$($pageSpeedTest.id)]"
                Return $null
            }
        }
    }

    $allParameterValues = $MyInvocation | Get-StatusCakeHelperParameterValue -BoundParameters $PSBoundParameters
    $statusCakeAPIParams = $allParameterValues | Get-StatusCakeHelperAPIParameter -InvocationInfo $MyInvocation
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
                $id = $response.data.new_id
            }
            $result = Get-StatusCakeHelperPageSpeedTestDetail -APICredential $APICredential -id $id
        }
        Return $result
    }

}