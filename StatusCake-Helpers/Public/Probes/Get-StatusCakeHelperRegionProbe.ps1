
<#
.SYNOPSIS
    Retrieve the StatusCake Probe by AWS region
.DESCRIPTION
    Retrieves the details of StatusCake probes nearest to a specific AWS region. If no object for StatusCake probe data is supplied the probe data is retrieved from StatusCake's RSS feed.
    Probes can be filtered to probes which are up, down or either
.PARAMETER AWSRegion
    AWSRegion to retrieve probes for
.PARAMETER StatusCakeProbeData
    Supply StatusCakeProbeData if you wish to limit the probe data which should be searched
.PARAMETER Status
    Filter the probe status include probes which are up or down. Default will return both.
.EXAMPLE
    C:\PS>Get-StatusCakeHelperRegionProbe -AWSRegion "eu-west-1"
    Retrieve StatusCake probes nearest to AWS Region eu-west-1
#>
function Get-StatusCakeHelperRegionProbe
{
    Param(
        [Parameter(Mandatory=$true)]
        [ValidatePattern('\w{2}-\w{4,9}-\d')]
        $AWSRegion,
        [ValidateSet("*","up","down")]
        $Status = '*',
        $StatusCakeProbeData=(Get-StatusCakeHelperProbe)
    )

    $awsRegionMap = @{
        'ap-northeast-1' = 'JPN'
        'ap-southeast-1' = 'SGP'
        'ap-southeast-2' = 'AUS'
        'ap-south-1' = 'IND'
        'ca-central-1' = 'CAN'
        'eu-west-1' = 'IRL'
        'eu-west-2' = 'GBR'
        'eu-central-1' = 'DEU'
        'us-west-1' = 'USA'
        'us-west-2' = 'USA'
        'us-east-1' = 'USA'
        'us-east-2' = 'USA'
        'sa-east-1' = 'BRA'
    }

    #For United States regions these can be further broken down by locations as below
    $cityAWSRegionMap = @{
        'us-west-1' = @('San Francisco','California','Silicon Valley','Los Angeles')
        'us-west-2' = @('San Francisco','California','Silicon Valley','Los Angeles')
        'us-east-1' = 'New York'
        'us-east-2' = @('Chicago','Illinois')
    }

    $countryiso = $awsRegionMap[$awsregion]
    $cities = $cityAWSRegionMap[$awsregion]
    $StatusCakeRegionProbes = $StatusCakeProbeData | Where-Object{$_.CountryIso -eq $countryiso -and $_.Status -like $Status}
    if($cities)
    {
        $StatusCakeProbes = $StatusCakeRegionProbes | Where-Object{Compare-Object -ReferenceObject $_.City -DifferenceObject $cities -ExcludeDifferent -IncludeEqual}
    }
    else
    {
        $StatusCakeProbes = $StatusCakeRegionProbes
    }

    Return $StatusCakeProbes
}