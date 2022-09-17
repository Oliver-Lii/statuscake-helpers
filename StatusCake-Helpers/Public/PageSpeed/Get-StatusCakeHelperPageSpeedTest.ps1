
<#
.SYNOPSIS
    Gets a StatusCake PageSpeed Test
.DESCRIPTION
    Retrieves a StatusCake PageSpeed Test. If no name or id is supplied all tests are returned.
.PARAMETER APICredential
    Credentials to access StatusCake API
.PARAMETER ID
    ID of the PageSpeed Test
.PARAMETER Name
    Name of the PageSpeed test
.EXAMPLE
    C:\PS>Get-StatusCakeHelperPageSpeedTest
    Retrieve all page speed tests
.EXAMPLE
    C:\PS>Get-StatusCakeHelperPageSpeedTest -Name "Example Page Speed Test"
    Retrieve page speed test information for a test called "Example Page Speed Test"
.LINK
    https://github.com/Oliver-Lii/statuscake-helpers/blob/master/Documentation/PageSpeed/Get-StatusCakeHelperPageSpeedTest.md
.LINK
    https://www.statuscake.com/api/v1/#tag/pagespeed/operation/get-pagespeed-test
.LINK
    https://www.statuscake.com/api/v1/#operation/get-maintenance-window
#>
function Get-StatusCakeHelperPageSpeedTest
{
    [CmdletBinding(PositionalBinding=$false,DefaultParameterSetName='All')]
    Param(
        [ValidateNotNullOrEmpty()]
        [System.Management.Automation.PSCredential] $APICredential = (Get-StatusCakeHelperAPIAuth),

        [Parameter(ParameterSetName = "ID")]
        [ValidateNotNullOrEmpty()]
        [int]$ID,

        [Parameter(ParameterSetName = "Name")]
        [ValidateNotNullOrEmpty()]
        [string]$Name
    )

    if($Name)
    {
        $statusCakeItem = Get-StatusCakeHelperItem -APICredential $APICredential -Type "PageSpeed" | Where-Object{$_.name -eq $Name}
    }
    elseif($ID)
    {
        $statusCakeItem = Get-StatusCakeHelperItem -APICredential $APICredential -Type "PageSpeed" -ID $ID
    }
    else
    {
        $statusCakeItem = Get-StatusCakeHelperItem -APICredential $APICredential -Type "PageSpeed"
    }
    Return $statusCakeItem
}

