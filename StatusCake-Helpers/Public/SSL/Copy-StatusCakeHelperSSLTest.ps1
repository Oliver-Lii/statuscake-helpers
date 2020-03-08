
<#
.Synopsis
   Copies the settings of a StatusCake SSL Test
.EXAMPLE
   Copy-StatusCakeHelperSSLTest -Name "Example" -NewName "Example - Copy"
.INPUTS
    Username - Username associated with the API key
    ApiKey - APIKey to access the StatusCake API

    Name - Name of the SSL Test to be copied
    ID - ID of the SSL Test to be copied
    NewDomain - Name of the new SSL Test domain
    Checkrate - Checkrate in seconds. Default is one day.
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
        $Username = (Get-StatusCakeHelperAPIAuth).Username,

        [Parameter(ParameterSetName='CopyByName')]
        [Parameter(ParameterSetName='CopyById')]
        [ValidateNotNullOrEmpty()]
        $ApiKey = (Get-StatusCakeHelperAPIAuth).GetNetworkCredential().password,

        [Parameter(ParameterSetName='CopyById',Mandatory=$true)]
        [ValidatePattern('^\d{1,}$')]
        $id,

        [Parameter(ParameterSetName='CopyByName',Mandatory=$true)]
        [ValidatePattern('^((http|https):\/\/)?([a-zA-Z0-9\-]+(\.[a-zA-Z]+)+.*)$|^(?!^.*,$)((([0-9]|[1-9][0-9]|1[0-9]{2}|2[0-4][0-9]|25[0-5])\.){3}([0-9]|[1-9][0-9]|1[0-9]{2}|2[0-4][0-9]|25[0-5]))*$')]
        $Domain,

        [Parameter(ParameterSetName='CopyByName',Mandatory=$true)]
        [Parameter(ParameterSetName='CopyById',Mandatory=$true)]
        [ValidatePattern('^((http|https):\/\/)?([a-zA-Z0-9\-]+(\.[a-zA-Z]+)+.*)$|^(?!^.*,$)((([0-9]|[1-9][0-9]|1[0-9]{2}|2[0-4][0-9]|25[0-5])\.){3}([0-9]|[1-9][0-9]|1[0-9]{2}|2[0-4][0-9]|25[0-5]))*$')]
        $NewDomain,

        [Parameter(ParameterSetName='CopyByName')]
        [Parameter(ParameterSetName='CopyById')]
        [ValidateSet("300","600","1800","3600","86400","2073600")]
        $checkrate="86400"
    )
    $statusCakeFunctionAuth = @{"Username"=$Username;"Apikey"=$ApiKey}
    Write-Warning -Message "The output from this function will be changed in the next release"
    if($Name)
    {   #If copying by name check if resource with that name exists
        if( $pscmdlet.ShouldProcess("StatusCake API", "Retrieve StatusCake SSL Tests"))
        {
            $exists = Get-StatusCakeHelperSSLTest @statusCakeFunctionAuth -Name $Name
            if(!$exists)
            {
                Write-Error "No SSL Test with Specified Name Exists [$Name]"
                Return $null
            }
            elseif($exists.GetType().Name -eq 'Object[]')
            {
                Write-Error "Multiple SSL Tests with the same name [$Name] [$($exists.ID)]"
                Return $null
            }
        }
    }
    elseif($ID)
    {   #If copying by ID verify that a resource with the Id already exists
        if( $pscmdlet.ShouldProcess("StatusCake API", "Retrieve StatusCake SSL Tests"))
        {
            $exists = Get-StatusCakeHelperSSLTest @statusCakeFunctionAuth -id $ID
            if(!$exists)
            {
                Write-Error "No SSL Test with Specified ID Exists [$ID]"
                Return $null
            }
        }
    }

    $psParams = @{}
    $ParameterList = (Get-Command -Name New-StatusCakeHelperSSLTest).Parameters

    $paramsToUse = $exists | Get-Member | Select-Object Name
    $paramsToUse = Compare-Object $paramsToUse.Name @($ParameterList.keys) -IncludeEqual -ExcludeDifferent
    $paramsToUse = $paramsToUse | Select-Object -ExpandProperty InputObject

    foreach ($key in $paramsToUse)
    {
        $value = $exists | Select-Object -ExpandProperty $key
        if($value -or $value -eq 0)
        {
            $psParams.Add($key,$value)
        }
    }

    # Convert the string back to array expected by cmdlet
    $psParams.alert_at = @($psParams.alert_at -split ",")
    $psParams.Domain = $NewDomain

    if( $pscmdlet.ShouldProcess("StatusCake API", "Create StatusCake SSL Test"))
    {
        $result = New-StatusCakeHelperSSLTest @statusCakeFunctionAuth @psParams
    }
    Return $result
}