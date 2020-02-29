
<#
.Synopsis
   Copies the settings of a StatusCake SSL Test
.PARAMETER APICredential
   Credentials to access StatusCake API
.PARAMETER Id
    ID of the SSL Test to be copied
.PARAMETER Domain
    Domain of the SSL Test to be copied
.PARAMETER NewDomain
    Domain of the new SSL Test
.PARAMETER Checkrate
    Checkrate in seconds. Default is one day.
.EXAMPLE
   Copy-StatusCakeHelperSSLTest -Name "Example" -NewName "Example - Copy"
.FUNCTIONALITY
   Creates a copy of a SSL Test. The check rate is not returned when retrieving a test and a copy defaults to check the SSL test once a day.
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
        [ValidatePattern('^\d{1,}$')]
        [int]$id,

        [Parameter(ParameterSetName='CopyByName',Mandatory=$true)]
        [ValidatePattern('^((http|https):\/\/)?([a-zA-Z0-9\-]+(\.[a-zA-Z]+)+.*)$|^(?!^.*,$)((([0-9]|[1-9][0-9]|1[0-9]{2}|2[0-4][0-9]|25[0-5])\.){3}([0-9]|[1-9][0-9]|1[0-9]{2}|2[0-4][0-9]|25[0-5]))*$')]
        [string]$Domain,

        [Parameter(ParameterSetName='CopyByName',Mandatory=$true)]
        [Parameter(ParameterSetName='CopyById',Mandatory=$true)]
        [ValidatePattern('^((http|https):\/\/)?([a-zA-Z0-9\-]+(\.[a-zA-Z]+)+.*)$|^(?!^.*,$)((([0-9]|[1-9][0-9]|1[0-9]{2}|2[0-4][0-9]|25[0-5])\.){3}([0-9]|[1-9][0-9]|1[0-9]{2}|2[0-4][0-9]|25[0-5]))*$')]
        [string]$NewDomain,

        [Parameter(ParameterSetName='CopyByName')]
        [Parameter(ParameterSetName='CopyById')]
        [ValidateSet("300","600","1800","3600","86400","2073600")]
        [int]$checkrate="86400"
    )

    if($Name)
    {   #If copying by name check if resource with that name exists
        if( $pscmdlet.ShouldProcess("StatusCake API", "Retrieve StatusCake SSL Tests"))
        {
            $statusCakeItem = Get-StatusCakeHelperSSLTest -APICredential $APICredential -Name $Name
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

    # Convert the string back to array expected by cmdlet
    $psParams.alert_at = @($psParams.alert_at -split ",")
    $psParams.Domain = $NewDomain

    if( $pscmdlet.ShouldProcess("StatusCake API", "Create StatusCake SSL Test"))
    {
        $result = New-StatusCakeHelperSSLTest -APICredential $APICredential @psParams
    }
    Return $result
}