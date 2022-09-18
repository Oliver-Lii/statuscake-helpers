
<#
.SYNOPSIS
    Copies the settings of a StatusCake SSL Test
.DESCRIPTION
    Creates a copy of a SSL Test.
.PARAMETER APICredential
    Credentials to access StatusCake API
.PARAMETER Id
    ID of the SSL Test to be copied
.PARAMETER WebsiteURL
    Website URL of the SSL Test to be copied
.PARAMETER NewWebsiteURL
    Website URL of the new SSL Test
.EXAMPLE
    C:\PS>Copy-StatusCakeHelperSSLTest -WebsiteURL "https://www.example.com" -NewWebsiteURL "https://www.example.org"
    Create a copy of the SSL test with URL "https://www.example.com" for URL "https://www.example.org"
.LINK
    https://github.com/Oliver-Lii/statuscake-helpers/blob/master/Documentation/SSL/Copy-StatusCakeHelperSSLTest.md
#>
function Copy-StatusCakeHelperSSLTest
{
    [CmdletBinding(PositionalBinding=$false,SupportsShouldProcess=$true)]
    Param(
        [Parameter(ParameterSetName='CopyByName')]
        [Parameter(ParameterSetName='CopyById')]
        [ValidateNotNullOrEmpty()]
        [System.Management.Automation.PSCredential] $APICredential = (Get-StatusCakeHelperAPIAuth),

        [Parameter(ParameterSetName='CopyById',Mandatory=$true)]
        [int]$ID,

        [Parameter(ParameterSetName='CopyByName',Mandatory=$true)]
        [ValidatePattern('^((http|https):\/\/)?([a-zA-Z0-9\-]+(\.[a-zA-Z]+)+.*)$|^(?!^.*,$)((([0-9]|[1-9][0-9]|1[0-9]{2}|2[0-4][0-9]|25[0-5])\.){3}([0-9]|[1-9][0-9]|1[0-9]{2}|2[0-4][0-9]|25[0-5]))*$')]
        [string]$WebsiteURL,

        [Parameter(ParameterSetName='CopyByName',Mandatory=$true)]
        [Parameter(ParameterSetName='CopyById',Mandatory=$true)]
        [ValidatePattern('^((http|https):\/\/)?([a-zA-Z0-9\-]+(\.[a-zA-Z]+)+.*)$|^(?!^.*,$)((([0-9]|[1-9][0-9]|1[0-9]{2}|2[0-4][0-9]|25[0-5])\.){3}([0-9]|[1-9][0-9]|1[0-9]{2}|2[0-4][0-9]|25[0-5]))*$')]
        [string]$NewWebsiteURL
    )

    if($WebsiteURL)
    {   #If copying by URL check if resource with that URL exists
        if( $pscmdlet.ShouldProcess("StatusCake API", "Retrieve StatusCake SSL Tests"))
        {
            $statusCakeItem = Get-StatusCakeHelperSSLTest -APICredential $APICredential -WebsiteURL $WebsiteURL
            if(!$statusCakeItem)
            {
                Write-Error "No SSL Test with Specified Name Exists [$Name]"
                Return $null
            }
            elseif($statusCakeItem.GetType().Name -eq 'Object[]')
            {
                Write-Error "Multiple SSL Tests with the same name [$Name] [$($statusCakeItem.ID)]"
                Return $null
            }
        }
    }
    elseif($ID)
    {   #If copying by ID verify that a resource with the Id already exists
        if( $pscmdlet.ShouldProcess("StatusCake API", "Retrieve StatusCake SSL Tests"))
        {
            $statusCakeItem = Get-StatusCakeHelperSSLTest -APICredential $APICredential -id $ID
            if(!$statusCakeItem)
            {
                Write-Error "No SSL Test with Specified ID Exists [$ID]"
                Return $null
            }
        }
    }

    $psParams = @{}
    $psParams = $statusCakeItem | Get-StatusCakeHelperCopyParameter -FunctionName "New-StatusCakeHelperSSLTest"

    $psParams["website_url"] = $NewWebsiteURL

    if( $pscmdlet.ShouldProcess("StatusCake API", "Create StatusCake SSL Test"))
    {
        $result = New-StatusCakeHelperSSLTest -APICredential $APICredential @psParams
    }
    Return $result
}