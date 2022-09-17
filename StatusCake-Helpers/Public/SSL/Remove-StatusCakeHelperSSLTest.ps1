
<#
.SYNOPSIS
    Remove a StatusCake SSL Test
.DESCRIPTION
    Deletes a StatusCake SSL Test using the supplied ID.
.PARAMETER APICredential
    Credentials to access StatusCake API
.PARAMETER ID
    Test ID to delete
.PARAMETER WebsiteURL
    WebsiteURL SSL test to remove
.EXAMPLE
    C:\PS>Remove-StatusCakeHelperSSLTest -ID 123456
    Remove the SSL Test with ID 123456
.LINK
    https://github.com/Oliver-Lii/statuscake-helpers/blob/master/Documentation/SSL/Remove-StatusCakeHelperSSLTest.md
.LINK
    https://www.statuscake.com/api/v1/#tag/ssl/operation/delete-ssl-test
#>
function Remove-StatusCakeHelperSSLTest
{
    [CmdletBinding(PositionalBinding=$false,SupportsShouldProcess=$true)]
    Param(
        [ValidateNotNullOrEmpty()]
        [System.Management.Automation.PSCredential] $APICredential = (Get-StatusCakeHelperAPIAuth),

        [Parameter(ParameterSetName = "ID")]
        [int]$ID,

        [Parameter(ParameterSetName = "Domain")]
        [ValidatePattern('^((https):\/\/)([a-zA-Z0-9\-]+(\.[a-zA-Z]+)+.*)$|^(?!^.*,$)')]
        [Alias('website_url','Domain')]
        [string]$WebsiteURL
    )

    if($WebsiteURL)
    {
        $statusCakeItem = Get-StatusCakeHelperSSLTest -APICredential $APICredential -WebsiteURL $WebsiteURL
        if(!$statusCakeItem)
        {
                Write-Error "No SSL test(s) found with name [$Name]"
                Return $null
        }
        elseif($statusCakeItem.GetType().Name -eq 'Object[]')
        {
            Write-Error "Multiple SSL Tests found with name [$Name]. Please delete the SSL test by ID"
            Return $null
        }
        $ID = $statusCakeItem.id
    }

    if( $pscmdlet.ShouldProcess("$ID", "Remove StatusCake SSL Test") )
    {
        Return (Remove-StatusCakeHelperItem -APICredential $APICredential -Type SSL -ID $ID)
    }
}