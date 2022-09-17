
<#
.SYNOPSIS
    Updates a StatusCake PageSpeed Test
.DESCRIPTION
    Updates a new StatusCake PageSpeed Test by either its name or ID.
.PARAMETER APICredential
    Credentials to access StatusCake API
.PARAMETER ID
    ID of PageSpeed test to update
.PARAMETER Name
    Name of PageSpeed test to update
.PARAMETER WebsiteURL
    URL that should be checked
.PARAMETER Checkrate
    Number of seconds between checks
.PARAMETER AlertBigger
    An alert will be sent if the size of the page is larger than this value (kb). A value of 0 prevents alerts being sent.
.PARAMETER AlertSlower
    Time in ms, will alert to Contact Groups if actual time is slower. A value of 0 prevents alerts being sent.
.PARAMETER AlertSmaller
    Size in kb, will alert to Contact Groups if actual size is smaller. A value of 0 prevents alerts being sent.
.PARAMETER ContactID
    IDs of selected Contact Groups to alert
.PARAMETER Region
    Statuscake region from which to run the checks. Valid values: AU, CA, DE, FR, IN, JP, NL, SG, UK, US, USW
.PARAMETER Paused
    Whether the test should be run.
.EXAMPLE
    C:\PS>Update-StatusCakeHelperPageSpeedTest -WebsiteURL "https://www.example.com" -Checkrate 60 -Region UK -AlertSlower 10000
    Create a page speed test to check site "https://www.example.com" every 60 minutes from a UK test server and alert when page speed load time is slower than 10000ms
.EXAMPLE
    C:\PS>Update-StatusCakeHelperPageSpeedTest -WebsiteURL "https://www.example.com" -Checkrate 60 -Region UK -AlertSmaller 500
    Create a page speed test to check site "https://www.example.com" every 60 minutes from a UK test server and alert when page load is less than 500kb
.LINK
    https://github.com/Oliver-Lii/statuscake-helpers/blob/master/Documentation/PageSpeed/Update-StatusCakeHelperPageSpeedTest.md
.LINK
    https://www.statuscake.com/api/v1/#tag/pagespeed/operation/update-pagespeed-test
#>
function Update-StatusCakeHelperPageSpeedTest
{
    [CmdletBinding(PositionalBinding=$false,SupportsShouldProcess=$true)]
    Param(
        [ValidateNotNullOrEmpty()]
        [System.Management.Automation.PSCredential] $APICredential = (Get-StatusCakeHelperAPIAuth),

        [Parameter(ParameterSetName = "ID")]
        [int]$ID,

        [Parameter(ParameterSetName = "Name")]
        [ValidateNotNullOrEmpty()]
        [string]$Name,

        [ValidatePattern('^((http|https):\/\/)([a-zA-Z0-9\-]+(\.[a-zA-Z]+)+.*)$|^(?!^.*,$)')]
        [Alias('website_url')]
        [string]$WebsiteURL,

        [ValidateSet("60","300","600","900","1800","3600","86400")]
        [Alias('check_rate')]
        [int]$Checkrate,

        [Alias('alert_bigger')]
        [ValidateNotNullOrEmpty()]
        [int]$AlertBigger,

        [Alias('alert_slower')]
        [ValidateNotNullOrEmpty()]
        [int]$AlertSlower,

        [Alias('alert_smaller')]
        [ValidateNotNullOrEmpty()]
        [int]$AlertSmaller,

        [Alias('contact_groups')]
        [ValidateNotNullOrEmpty()]
        [int[]]$ContactID,

        [ValidateSet("AU","CA","DE","FR","IN","JP","NL","SG","UK","US","USW")]
        [string]$Region,

        [boolean]$Paused
    )

    if($Name)
    {
       $statusCakeItem = Get-StatusCakeHelperPageSpeedTest -APICredential $APICredential -Name $Name
       if(!$statusCakeItem)
       {
            Write-Error "No PageSpeed test(s) found with name [$Name]"
            Return $null
       }
       elseif($statusCakeItem.GetType().Name -eq 'Object[]')
       {
           Write-Error "Multiple PageSpeed Tests found with name [$Name]. Please update the PageSpeed test by ID"
           Return $null
       }
       $ID = $statusCakeItem.id
    }

    $allParameterValues = $MyInvocation | Get-StatusCakeHelperParameterValue -BoundParameters $PSBoundParameters
    $statusCakeAPIParams = $allParameterValues | Get-StatusCakeHelperAPIParameter -InvocationInfo $MyInvocation -Exclude @("Force","Name")  | ConvertTo-StatusCakeHelperAPIValue

    if( $pscmdlet.ShouldProcess("$ID", "Update StatusCake Pagespeed Test") )
    {
        Return (Update-StatusCakeHelperItem -APICredential $APICredential -Type PageSpeed -ID $ID -Parameter $statusCakeAPIParams)
    }
}