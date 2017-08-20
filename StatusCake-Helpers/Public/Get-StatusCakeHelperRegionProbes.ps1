
<#
.Synopsis
   Retrieve the StatusCake Probe by AWS region
.EXAMPLE
   Get-StatusCakeHelperRegionProbes -AWSRegion "eu-west-1"
.INPUTS
   AWSRegion - AWS region for which to retrieve StatusCake probes
   StatusCakeProbeData - (optional) Object containing data about the StatusCake probes
   Status - (optional) The status of the Probes you wish to retrieve
.FUNCTIONALITY
   Retrieves the deetails of StatusCake probes for a specific region from an object containing StatusCake Probe data
   If no object for StatusCake probe data is supplied the probe data is retrieved from StatusCake's RSS feed
#>
function Get-StatusCakeHelperRegionProbes
{
    Param(
        [Parameter(Mandatory=$true)]        
        [ValidateScript({If ($_ -match '\w{2}-\w{4,9}-\d') {$true}})]
        $AWSRegion,
        [ValidateSet("*","up","down")]         
        $Status = '*',
        $StatusCakeProbeData
    )

    if(!$StatusCakeProbeData){$StatusCakeProbeData=Get-StatusCakeHelperProbes}

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

    $countryiso = $awsRegionMap.$awsregion
    $cities = $cityAWSRegionMap.$awsregion
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