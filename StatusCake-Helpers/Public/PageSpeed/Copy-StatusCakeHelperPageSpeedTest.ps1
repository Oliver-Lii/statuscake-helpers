
<#
.Synopsis
   Copies the settings of a StatusCake Page Speed Test
.PARAMETER APICredential
   Credentials to access StatusCake API
.PARAMETER Name
    Name of the Page Speed Test to be copied
.PARAMETER Id
    ID of the Page Speed Test to be copied
.PARAMETER NewName
    Name of the Page Speed Test copy
.EXAMPLE
   Copy-StatusCakeHelperPageSpeedTest -Name "Example" -NewName "Example - Copy"
.FUNCTIONALITY
   Creates a copy of a Page Speed Test. Supply a value for the website_url parameter to override the source URL.
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
        [int]$id,

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
        [string]$website_url
    )

    if($Name)
    {   #If copying by name check if resource with that name exists
        if( $pscmdlet.ShouldProcess("StatusCake API", "Retrieve StatusCake Page Speed Tests"))
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
        if( $pscmdlet.ShouldProcess("StatusCake API", "Retrieve StatusCake Page Speed Tests"))
        {
            $statusCakeItem = Get-StatusCakeHelperPageSpeedTest -APICredential $APICredential -id $ID
            if(!$statusCakeItem)
            {
                Write-Error "No Page Speed Test with Specified ID Exists [$ID]"
                Return $null
            }
        }
    }

    if( $pscmdlet.ShouldProcess("StatusCake API", "Retrieve Detailed StatusCake Test Data"))
    {
        $statusCakeItem = Get-StatusCakeHelperPageSpeedTestDetail -APICredential $APICredential -Id $statusCakeItem.Id
    }

    $psParams = @{}
    $psParams = $statusCakeItem | Get-StatusCakeHelperCopyParameter -FunctionName "New-StatusCakeHelperPageSpeedTest"

    $psParams.Name = $NewName
    if($website_url)
    {
        $psParams.website_url = $website_url
    }

    if( $pscmdlet.ShouldProcess("StatusCake API", "Create StatusCake Page Speed Test"))
    {
        $result = New-StatusCakeHelperPageSpeedTest -APICredential $APICredential @psParams
    }
    Return $result
}