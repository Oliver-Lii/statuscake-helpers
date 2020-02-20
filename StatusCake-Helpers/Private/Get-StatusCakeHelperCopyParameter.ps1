
<#
.Synopsis
    Returns the parameters which can be copied from an object
.PARAMETER InputObject
    StatusCake Object to be copied
.PARAMETER FunctionName
    Credentials to access StatusCake API
.EXAMPLE
    $statusCakeObject | Get-StatusCakeHelperCopyParameter -FunctionName "Get-StatusCakeHelperTest"
.FUNCTIONALITY
    Returns the properties and values of a StatusCake object which be set via the API. Not all parameters returned by StatusCake can by set via the API.
#>
function Get-StatusCakeHelperCopyParameter
{
    [CmdletBinding(PositionalBinding=$false)]
    [OutputType([hashtable])]
    Param(
        [Parameter(Mandatory=$True,ValueFromPipeline=$True)]
        [ValidateNotNullOrEmpty()]
        $InputObject,

        [Parameter(Mandatory=$True)]
        [ValidateNotNullOrEmpty()]
        [string] $FunctionName
    )

    $psParams = @{}
    $functionInfo = (Get-Command -Name $FunctionName)
    $parameterList = $functionInfo.Parameters
    $sourceItemHash = $InputObject | ConvertTo-StatusCakeHelperHashtableFromPSCustomObject

    $parameterMetadata = $FunctionInfo.Parameters.Values
    $aliases = $parameterMetadata | Select-Object -Property Name, Aliases | Where-Object {$_.Name -in $sourceItemHash.Key -and $_.Aliases}
    foreach($item in $aliases)
    {   # Add renamed parameter using first alias
        $parameterList[$item.name] = $item.aliases[0]
    }

    $paramsToUse = Compare-Object @($sourceItemHash.Keys) @($parameterList.keys) -IncludeEqual -ExcludeDifferent
    $paramsToUse = $paramsToUse | Select-Object -ExpandProperty InputObject

    foreach($key in $paramsToUse)
    {
        $psParams[$key]=$sourceItemHash[$key]
    }

    Return $psParams
}