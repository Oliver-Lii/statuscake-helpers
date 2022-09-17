
<#
.SYNOPSIS
    Gets a StatusCake SSL Test
.DESCRIPTION
    Retrieves a StatusCake SSL Test. If no domain or id is supplied all tests are returned.
.PARAMETER APICredential
    Credentials to access StatusCake API
.PARAMETER WebsiteURL
    Name of the test to retrieve
.PARAMETER ID
    Test ID to retrieve
.EXAMPLE
    C:\PS>Get-StatusCakeHelperSSLTest
    Retrieve all SSL tests
.EXAMPLE
    C:\PS>Get-StatusCakeHelperSSLTest -ID 123456
    Retrieve SSL test with ID 123456
.OUTPUTS
    Returns a StatusCake SSL Tests as an object
.LINK
    https://github.com/Oliver-Lii/statuscake-helpers/blob/master/Documentation/SSL/Get-StatusCakeHelperSSLTest.md
.LINK
    https://www.statuscake.com/api/v1/#tag/ssl/operation/list-ssl-tests
.LINK
    https://www.statuscake.com/api/v1/#tag/ssl/operation/get-ssl-test
#>
function Get-StatusCakeHelperSSLTest
{
    [CmdletBinding(PositionalBinding=$false,DefaultParameterSetName='All')]
    Param(
        [ValidateNotNullOrEmpty()]
        [System.Management.Automation.PSCredential] $APICredential = (Get-StatusCakeHelperAPIAuth),

        [Parameter(ParameterSetName = "Domain")]
        [ValidatePattern('^((https):\/\/)([a-zA-Z0-9\-]+(\.[a-zA-Z]+)+.*)$|^(?!^.*,$)')]
        [Alias('website_url','Domain')]
        [string]$WebsiteURL,

        [Parameter(ParameterSetName = "ID")]
        [ValidateNotNullOrEmpty()]
        [int]$ID
    )

    if($WebsiteURL)
    {
        $statusCakeItem = Get-StatusCakeHelperItem -APICredential $APICredential -Type "SSL" | Where-Object{$_.website_url -eq $WebsiteURL}
    }
    elseif($ID)
    {
        $statusCakeItem = Get-StatusCakeHelperItem -APICredential $APICredential -Type "SSL" -ID $ID
    }
    else
    {
        $statusCakeItem = Get-StatusCakeHelperItem -APICredential $APICredential -Type "SSL"
    }
    Return $statusCakeItem
}

