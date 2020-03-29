<#
.SYNOPSIS
   Retrieve the details of the StatusCake Probes from StatusCake's RSS feed
.DESCRIPTION
   Retrieves details of StatusCake probes from StatusCake's RSS feed sorted by Title
.EXAMPLE
   C:\PS>Get-StatusCakeHelperProbe
   Retrieve all StatusCake probes
.OUTPUTS
   StatusCakeProbes - Object containing details of the Status Cake probes
#>
function Get-StatusCakeHelperProbe
{
    $StatusCakeXMLURL = 'https://app.statuscake.com/Workfloor/Locations.php?format=xml'
    $StatusCakeProbesXML = ([xml](Invoke-WebRequest -uri $StatusCakeXMLURL -UseBasicParsing).Content).rss.channel

    $probeList = [System.Collections.Generic.List[PSObject]]::new()
    ForEach ($msg in $StatusCakeProbesXML.Item)
    {
        $msg.title -match '(?<country>\w{2,}\s?\w{0,})\,?\s?(?<city>\w{2,}\s?\w{0,})?\s?\-?\s?(?<number>\d{1,2})?' | Out-Null
        $Country = $Matches.Country
        $City = $Matches.City
        if(!$Country){$Country = $msg.title}
        if(!$City){$City = $Country}
        $statusCakeProbe=[PSCustomObject]@{
            'Title' = $msg.title
            'GUID' = $msg.guid.'#text'
            'ip' = "$($msg.ip)/32"
            'servercode' = $msg.servercode
            'Country' = $Country.trim()
            'CountryISO' = $msg.countryiso
            'City' = $City.trim()
            'Status' = $msg.status
        }
        $Matches = ""
        $probeList.Add($statusCakeProbe)
    }
    Return $probeList | Sort-Object Title
}