
<#
.SYNOPSIS
    Copies the settings of a StatusCake Page Speed Test
.DESCRIPTION
    Creates a copy of a Page Speed Test. Supply a value for the WebsiteURL parameter to override the source URL. A region is required as StatusCake API does not return the region the tests are carried out from.
.PARAMETER APICredential
    Credentials to access StatusCake API
.PARAMETER ID
    ID of the Page Speed Test to be copied
.PARAMETER Name
    Name of the Page Speed Test to be copied
.PARAMETER NewName
    Name of the Page Speed Test copy
.PARAMETER WebsiteURL
    Name of the URL to be used in the copy of the test
.PARAMETER Region
    StatusCake region the test should carried out from.
.EXAMPLE
    C:\PS>Copy-StatusCakeHelperPageSpeedTest -Name "Example" -NewName "Example - Copy" -Region UK
    Creates a copy of a page speed test called "Example" with name "Example - Copy"
.EXAMPLE
    C:\PS>Copy-StatusCakeHelperPageSpeedTest -Name "Example" -NewName "Example - Copy" -WebsiteURL "https://www.example.org" -Region UK
    Creates a copy of a page speed test called "Example" with name "Example - Copy" using the URL "https://www.example.org"
.LINK
    https://github.com/Oliver-Lii/statuscake-helpers/blob/master/Documentation/PageSpeed/Copy-StatusCakeHelperPageSpeedTest.md
#>
function Copy-StatusCakeHelperPageSpeedTest
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
        [ValidateNotNullOrEmpty()]
        [string]$Name,

        [Parameter(ParameterSetName='CopyByName',Mandatory=$true)]
        [Parameter(ParameterSetName='CopyById',Mandatory=$true)]
        [ValidateNotNullOrEmpty()]
        [string]$NewName,

        [Parameter(ParameterSetName='CopyByName')]
        [Parameter(ParameterSetName='CopyById')]
        [ValidatePattern('^((http|https):\/\/)?([a-zA-Z0-9\-]+(\.[a-zA-Z]+)+.*)$|^(?!^.*,$)((([0-9]|[1-9][0-9]|1[0-9]{2}|2[0-4][0-9]|25[0-5])\.){3}([0-9]|[1-9][0-9]|1[0-9]{2}|2[0-4][0-9]|25[0-5]))*$')]
        [Alias('website_url')]
        [string]$WebsiteURL,

        [Parameter(Mandatory=$true)]
        [ValidateSet("AU","CA","DE","FR","IN","JP","NL","SG","UK","US","USW")]
        [string]$Region
    )

    if($Name)
    {   #If copying by name check if resource with that name exists
        if( $pscmdlet.ShouldProcess("$Name", "Retrieve StatusCake Page Speed Test Details"))
        {
            $statusCakeItem = Get-StatusCakeHelperPageSpeedTest -APICredential $APICredential -Name $Name
            if(!$statusCakeItem)
            {
                Write-Error "No Page Speed Test with Specified Name Exists [$Name]"
                Return $null
            }
            elseif($statusCakeItem.GetType().Name -eq 'Object[]')
            {
                Write-Error "Multiple Page Speed Tests with the same name [$Name] [$($statusCakeItem.ID)]"
                Return $null
            }
        }
    }
    elseif($ID)
    {   #If copying by ID verify that a resource with the Id already exists
        if( $pscmdlet.ShouldProcess("$ID", "Retrieve StatusCake Page Speed Test Details"))
        {
            $statusCakeItem = Get-StatusCakeHelperPageSpeedTest -APICredential $APICredential -id $ID
            if(!$statusCakeItem)
            {
                Write-Error "No Page Speed Test with Specified ID Exists [$ID]"
                Return $null
            }
        }
    }

    $psParams = @{}
    $psParams = $statusCakeItem | Get-StatusCakeHelperCopyParameter -FunctionName "New-StatusCakeHelperPageSpeedTest"

    Write-Verbose "$($psParams.Keys -join ",")"

    $psParams.Name = $NewName
    if($WebsiteURL)
    {
        $psParams.WebsiteURL = $WebsiteURL
    }

    if( $pscmdlet.ShouldProcess("StatusCake API", "Create StatusCake Page Speed Test"))
    {
        $result = New-StatusCakeHelperPageSpeedTest -APICredential $APICredential @psParams -Region $Region
    }
    Return $result
}