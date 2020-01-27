
<#
.Synopsis
   Converts a string parameter to a domain name
.EXAMPLE
   ConvertTo-StatusCakeHelperDomainName -InputString [string]
.INPUTS
    InputString - String containing the value to convert to a domain name
.FUNCTIONALITY
   Converts a string parameters to a domain name.
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