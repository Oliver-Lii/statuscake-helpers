<#
.SYNOPSIS
    Tests to confirm that a supplied HTTP Status Code is valid
.DESCRIPTION
    Tests to confirm that a supplied HTTP Status Code is valid. The URL is tested using the URI class with the uri well formed method and verifying scheme is http and/or https.
.PARAMETER URL
    URL to test is valid
.EXAMPLE
    C:\PS>"https://www.example.com" | Test-StatusCakeHelperURL
    Test if the value https://www.example.com is a valid URL
.OUTPUTS
    Returns true if the supplied string is a URL
#>
function Test-StatusCakeHelperURL
{
    [CmdletBinding(PositionalBinding=$false)]
    [OutputType([System.Boolean])]
    Param(
        [Parameter(Mandatory=$True,
        ValueFromPipeline=$True)]
        [string] $URL
    )
    Process{
        Return [uri]::IsWellFormedUriString($URL, 'Absolute') -and ([uri] $uri).Scheme -in 'http', 'https'
    }
}
