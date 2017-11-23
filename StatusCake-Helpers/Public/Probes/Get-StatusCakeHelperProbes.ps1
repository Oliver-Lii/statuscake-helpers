<#
.Synopsis
   Retrieve the details of the StatusCake Probes from StatusCake's RSS feed
.EXAMPLE
   Get-StatusCakeHelperProbes
.INPUTS
   $StatusCakeXMLURL - URL of RSS feed page containing StatusCake probes
.OUTPUTS
   StatusCakeProbes - Object containing details of the Status probe
.FUNCTIONALITY
   Retrieves details of StatusCake probes from StatusCake's RSS feed sorted by Title
#>
function Get-StatusCakeHelperProbes
{
    Param(  
        $StatusCakeXMLURL = 'https://app.statuscake.com/Workfloor/Locations.php?format=xml'
    )
    $StatusCakeProbesXML = ([xml](Invoke-WebRequest -uri $StatusCakeXMLURL -UseBasicParsing).Content).rss.channel

    $StatusCakeProbes = @()
    ForEach ($msg in $StatusCakeProbesXML.Item)
    {
        $msg.title -match '(?<country>\w{2,}\s?\w{0,})\,?\s?(?<city>\w{2,}\s?\w{0,})?\s?\-?\s?(?<number>\d{1,2})?' | Out-Null
        $Country = $Matches.Country
        $City = $Matches.City
        if(!$Country){$Country = $msg.title}
        if(!$City){$City = $Country}
        $StatusCakeProbes+=[PSCustomObject]@{
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
    }
    Return $StatusCakeProbes | Sort-Object Title
}