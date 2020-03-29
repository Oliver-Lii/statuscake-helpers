
<#
.SYNOPSIS
    Converts a string parameter to a domain name
.DESCRIPTION
    Converts a string parameters to a domain name.
.PARAMETER InputString
    String containing the URL to convert to a domain name
.EXAMPLE
    C:\PS>"https://www.example.com" | ConvertTo-StatusCakeHelperDomainName
    Convert the URL https://www.example.com into domain www.example.com
#>
function ConvertTo-StatusCakeHelperDomainName
{
    [CmdletBinding()]
    Param(
        [Parameter(Mandatory=$True,
        ValueFromPipeline=$True)]
        [string] $InputString
    )

    if($InputString -match '^((http|https):\/\/)([a-zA-Z0-9\-]+(\.[a-zA-Z]+)+.*)$')
    {
        $InputString -match '(?<DomainName>([a-zA-Z0-9\-]{2,}\.[a-zA-Z\-]{2,})(\.[a-zA-Z\-]{2,})?(\.[a-zA-Z\-]{2,})?)' | Out-Null
        $InputString = $matches.DomainName
    }

    Return $InputString
}