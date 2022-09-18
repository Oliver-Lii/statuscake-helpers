
<#
.SYNOPSIS
    Remove a StatusCake PageSpeed Test
.DESCRIPTION
    Deletes a StatusCake PageSpeed Test using the supplied ID or name.
.PARAMETER APICredential
    Credentials to access StatusCake API
.PARAMETER ID
    ID of the PageSpeed Test to remove
.PARAMETER Name
    Name for PageSpeed test
.EXAMPLE
    C:\PS>Remove-StatusCakeHelperPageSpeedTest -ID 123456
    Remove page speed test with id 123456
.EXAMPLE
    C:\PS>Remove-StatusCakeHelperPageSpeedTest -Name "Example PageSpeed Test"
    Remove page speed test with name "Example PageSpeed Test"
.LINK
    https://github.com/Oliver-Lii/statuscake-helpers/blob/master/Documentation/PageSpeed/Remove-StatusCakeHelperPageSpeedTest.md
.LINK
    https://www.statuscake.com/api/v1/#tag/pagespeed/operation/delete-pagespeed-test
#>
function Remove-StatusCakeHelperPageSpeedTest
{
    [CmdletBinding(PositionalBinding=$false,SupportsShouldProcess=$true)]
    Param(
        [ValidateNotNullOrEmpty()]
        [System.Management.Automation.PSCredential] $APICredential = (Get-StatusCakeHelperAPIAuth),

        [Parameter(ParameterSetName = "ID")]
        [int]$ID,

        [Parameter(ParameterSetName = "Name")]
        [string]$Name
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
           Write-Error "Multiple PageSpeed Tests found with name [$Name]. Please delete the PageSpeed test by ID"
           Return $null
       }
       $ID = $statusCakeItem.id
    }

    if( $pscmdlet.ShouldProcess("$ID", "Delete StatusCake Pagespeed Test") )
    {
        Return (Remove-StatusCakeHelperItem -APICredential $APICredential -Type PageSpeed -ID $ID)
    }
}