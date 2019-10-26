
<#
.Synopsis
   Copies the settings of a StatusCake Page Speed Test
.PARAMETER Username
    Username associated with the API key
.PARAMETER ApiKey
    APIKey to access the StatusCake API
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
        $Username = (Get-StatusCakeHelperAPIAuth).Username,

        [Parameter(ParameterSetName='CopyByName')]
        [Parameter(ParameterSetName='CopyById')]
        [ValidateNotNullOrEmpty()]
        $ApiKey = (Get-StatusCakeHelperAPIAuth).GetNetworkCredential().password,

        [Parameter(ParameterSetName='CopyById',Mandatory=$true)]
        [ValidatePattern('^\d{1,}$')]
        $id,

        [Parameter(ParameterSetName='CopyByName',Mandatory=$true)]
        [ValidateNotNullOrEmpty()]
        $Name,

        [Parameter(ParameterSetName='CopyByName',Mandatory=$true)]
        [Parameter(ParameterSetName='CopyById',Mandatory=$true)]
        [ValidateNotNullOrEmpty()]
        $NewName,

        [Parameter(ParameterSetName='CopyByName')]
        [Parameter(ParameterSetName='CopyById')]
        [ValidatePattern('^((http|https):\/\/)?([a-zA-Z0-9\-]+(\.[a-zA-Z]+)+.*)$|^(?!^.*,$)((([0-9]|[1-9][0-9]|1[0-9]{2}|2[0-4][0-9]|25[0-5])\.){3}([0-9]|[1-9][0-9]|1[0-9]{2}|2[0-4][0-9]|25[0-5]))*$')]
        $website_url
    )
    $statusCakeFunctionAuth = @{"Username"=$Username;"Apikey"=$ApiKey}

    if($Name)
    {   #If copying by name check if resource with that name exists
        if( $pscmdlet.ShouldProcess("StatusCake API", "Retrieve StatusCake Page Speed Tests"))
        {
            $exists = Get-StatusCakeHelperPageSpeedTest @statusCakeFunctionAuth -Name $Name
            if(!$exists)
            {
                Write-Error "No Page Speed Test with Specified Name Exists [$Name]"
                Return $null
            }
            elseif($exists.GetType().Name -eq 'Object[]')
            {
                Write-Error "Multiple Page Speed Tests with the same name [$Name] [$($exists.ID)]"
                Return $null
            }
        }
    }
    elseif($ID)
    {   #If copying by ID verify that a resource with the Id already exists
        if( $pscmdlet.ShouldProcess("StatusCake API", "Retrieve StatusCake Page Speed Tests"))
        {
            $exists = Get-StatusCakeHelperPageSpeedTest @statusCakeFunctionAuth -id $ID
            if(!$exists)
            {
                Write-Error "No Page Speed Test with Specified ID Exists [$ID]"
                Return $null
            }
        }
    }

    if( $pscmdlet.ShouldProcess("StatusCake API", "Retrieve Detailed StatusCake Test Data"))
    {
        $sourceItemDetails = Get-StatusCakeHelperPageSpeedTest -id $exists.id
    }

    $psParams = @{}
    $ParameterList = (Get-Command -Name New-StatusCakeHelperPageSpeedTest).Parameters

    $paramsToUse = $sourceItemDetails | Get-Member | Select-Object Name
    $paramsToUse = Compare-Object $paramsToUse.Name @($ParameterList.keys) -IncludeEqual -ExcludeDifferent
    $paramsToUse = $paramsToUse | Select-Object -ExpandProperty InputObject

    foreach ($key in $paramsToUse)
    {
        $value = $exists.$key
        if($value -or $value -eq 0)
        {
            $psParams.Add($key,$value)
        }
    }

    $psParams.Name = $NewName
    if($website_url)
    {
        $psParams.website_url = $website_url
    }

    if( $pscmdlet.ShouldProcess("StatusCake API", "Create StatusCake Page Speed Test"))
    {
        $result = New-StatusCakeHelperPageSpeedTest @statusCakeFunctionAuth @psParams
    }
    Return $result
}