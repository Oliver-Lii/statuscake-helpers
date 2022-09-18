
<#
.SYNOPSIS
    Copies the settings of a StatusCake test check
.DESCRIPTION
    Creates a copy of a test. Supply the TestURL or Paused parameter to override the original values in the source test.
.PARAMETER APICredential
    Credentials to access StatusCake API
.PARAMETER ID
    The uptime test ID to modify the details for
.PARAMETER Name
    Name of the uptime Test
.PARAMETER WebsiteURL
    Website URL to be used in the copied test
.PARAMETER NewName
    Name of the new copied uptime test
.PARAMETER Paused
    If supplied sets the state of the test should be after it is copied.
.EXAMPLE
    C:\PS>Copy-StatusCakeHelperUptimeTest -Name "Example" -NewName "Example - Copy"
    Create a copy of test "Example" with name "Example - Copy"
.LINK
    https://github.com/Oliver-Lii/statuscake-helpers/blob/master/Documentation/Uptime/Copy-StatusCakeHelperUptimeTest.md
#>
function Copy-StatusCakeHelperUptimeTest
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
        [String]$Name,

        [Parameter(ParameterSetName='CopyByName')]
        [Parameter(ParameterSetName='CopyById')]
        [ValidatePattern('^((http|https):\/\/)?([a-zA-Z0-9\-]+(\.[a-zA-Z]+)+.*)$|^(?!^.*,$)((([0-9]|[1-9][0-9]|1[0-9]{2}|2[0-4][0-9]|25[0-5])\.){3}([0-9]|[1-9][0-9]|1[0-9]{2}|2[0-4][0-9]|25[0-5]))*$')]
        [String]$WebsiteURL,

        [Parameter(ParameterSetName='CopyByName',Mandatory=$true)]
        [Parameter(ParameterSetName='CopyById',Mandatory=$true)]
        [ValidateNotNullOrEmpty()]
        [String]$NewName,

        [Parameter(ParameterSetName='CopyByName')]
        [Parameter(ParameterSetName='CopyById')]
        [Boolean]$Paused
    )

    if($Name)
    {   #If copying by name check if resource with that name exists
        if( $pscmdlet.ShouldProcess("StatusCake API", "Retrieve StatusCake Tests"))
        {
            $statusCakeItem = Get-StatusCakeHelperUptimeTest -APICredential $APICredential -Name $Name
            if(!$statusCakeItem)
            {
                Write-Error "No Uptime test with Specified Name Exists [$Name]"
                Return $null
            }
            elseif($statusCakeItem.GetType().Name -eq 'Object[]')
            {
                Write-Error "Multiple Uptime tests with the same name [$Name] [$($statusCakeItem.ID)]"
                Return $null
            }
            $ID = $statusCakeItem.ID
        }
    }
    elseif($ID)
    {   #If copying by ID verify that a resource with the Id already exists
        if( $pscmdlet.ShouldProcess("StatusCake API", "Retrieve StatusCake Tests"))
        {
            $statusCakeItem = Get-StatusCakeHelperUptimeTest -APICredential $APICredential -ID $ID
            if(!$statusCakeItem)
            {
                Write-Error "No Test with Specified ID Exists [$ID]"
                Return $null
            }
            $ID = $statusCakeItem.ID
        }
    }

    $psParams = @{}
    $psParams = $statusCakeItem | Get-StatusCakeHelperCopyParameter -FunctionName "New-StatusCakeHelperUptimeTest"

    Write-Verbose "$($psParams.Keys -join ",")"

    $psParams.Name = $NewName
    if($WebsiteURL)
    {
        $psParams.WebsiteURL = $WebsiteURL
    }
    if($Paused)
    {
        $psParams.Paused = $Paused
    }

    if( $pscmdlet.ShouldProcess("StatusCake API", "Create StatusCake Uptime Test"))
    {
        $result = New-StatusCakeHelperUptimeTest -APICredential $APICredential @psParams
    }
    Return $result

}