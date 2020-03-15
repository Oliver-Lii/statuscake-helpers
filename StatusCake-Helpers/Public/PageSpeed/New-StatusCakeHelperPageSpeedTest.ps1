
<#
.SYNOPSIS
    Create a StatusCake PageSpeed Test
.DESCRIPTION
    Creates a new StatusCake PageSpeed Test using the supplied parameters.
.PARAMETER APICredential
    Credentials to access StatusCake API
.PARAMETER Name
    Name for PageSpeed test
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
    C:\PS>New-StatusCakeHelperPageSpeedTest -WebsiteURL "https://www.example.com" -Checkrate 60 -LocationISO UK -AlertSlower 10000
    Create a page speed test to check site "https://www.example.com" every 60 minutes from a UK test server and alert when page speed load time is slower than 10000ms
.EXAMPLE
    C:\PS>New-StatusCakeHelperPageSpeedTest -WebsiteURL "https://www.example.com" -Checkrate 60 -LocationISO UK -AlertSmaller 500
    Create a page speed test to check site "https://www.example.com" every 60 minutes from a UK test server and alert when page load is less than 500kb
#>
function New-StatusCakeHelperPageSpeedTest
{
    [CmdletBinding(PositionalBinding=$false,SupportsShouldProcess=$true)]
    Param(
        [ValidateNotNullOrEmpty()]
        [System.Management.Automation.PSCredential] $APICredential = (Get-StatusCakeHelperAPIAuth),

        [Parameter(Mandatory=$true)]
        [ValidateNotNullOrEmpty()]
        [string]$Name,

        [Parameter(Mandatory=$true)]
        [ValidatePattern('^((http|https):\/\/)([a-zA-Z0-9\-]+(\.[a-zA-Z]+)+.*)$|^(?!^.*,$)')]
        [Alias('website_url')]
        [string]$WebsiteURL,

        [Parameter(Mandatory=$true)]
        [ValidateSet("AU","CA","DE","IN","NL","SG","UK","US","PRIVATE")]
        [Alias('location_iso')]
        [string]$LocationISO,

        [Parameter(Mandatory=$true)]
        [ValidateSet("1","5","10","15","30","60","1440")]
        [int]$Checkrate,

        [Alias('alert_bigger')]
        [int]$AlertBigger=0,

        [Alias('alert_slower')]
        [int]$AlertSlower=0,

        [Alias('alert_smaller')]
        [int]$AlertSmaller=0,

        [Alias('contact_groups')]
        [int[]]$ContactIDs,

        [ValidateNotNullOrEmpty()]
        [Alias('private_name')]
        [string]$PrivateName
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

    $lower =@('Name','Checkrate')
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
                $id = $response.data.new_id
            }
            $result = Get-StatusCakeHelperPageSpeedTestDetail -APICredential $APICredential -id $id
        }
        Return $result
    }


}