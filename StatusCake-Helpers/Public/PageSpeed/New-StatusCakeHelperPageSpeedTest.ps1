
<#
.Synopsis
   Create a StatusCake PageSpeed Test
.PARAMETER APICredential
   Credentials to access StatusCake API
.PARAMETER Name
    Name for PageSpeed test
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
   New-StatusCakeHelperPageSpeedTest -Username "Username" -ApiKey "APIKEY" -website_url "https://www.example.com" -checkrate 3600 -location_iso UK
.FUNCTIONALITY
   Creates a new StatusCake PageSpeed Test using the supplied parameters.
#>
function New-StatusCakeHelperPageSpeedTest
{
    [CmdletBinding(PositionalBinding=$false,SupportsShouldProcess=$true)]
    Param(
        [ValidateNotNullOrEmpty()]
        [System.Management.Automation.PSCredential] $APICredential = (Get-StatusCakeHelperAPIAuth),

        [Parameter(Mandatory=$true)]
        [ValidateNotNullOrEmpty()]
        [string]$name,

        [Parameter(Mandatory=$true)]
        [ValidatePattern('^((http|https):\/\/)([a-zA-Z0-9\-]+(\.[a-zA-Z]+)+.*)$|^(?!^.*,$)')]
        [string]$website_url,

        [Parameter(Mandatory=$true)]
        [ValidateSet("AU","CA","DE","IN","NL","SG","UK","US","PRIVATE")]
        [string]$location_iso,

        [Parameter(Mandatory=$true)]
        [ValidateSet("1","5","10","15","30","60","1440")]
        [int]$checkrate,

        [ValidateScript({$_ -match '^[\d]+$'})]
        [int]$alert_bigger=0,

        [ValidateScript({$_ -match '^[\d]+$'})]
        [int]$alert_slower=0,

        [ValidateScript({$_ -match '^[\d]+$'})]
        [int]$alert_smaller=0,

        [ValidateScript({$_ -match '^[\d]+$'})]
        [object]$contact_groups,

        [ValidateNotNullOrEmpty()]
        [string]$private_name
    )

    if( $pscmdlet.ShouldProcess("StatusCake API", "Retrieve StatusCake PageSpeed tests") )
    {
        $pageSpeedTest = Get-StatusCakeHelperPageSpeedTest -APICredential $APICredential -name $name
        if($pageSpeedTest)
        {
            Write-Error "PageSpeed test with specified name already exists [$name] [$($pageSpeedTest.id)]"
            Return $null
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