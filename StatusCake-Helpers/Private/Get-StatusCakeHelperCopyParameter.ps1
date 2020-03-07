
<#
.Synopsis
    Returns the parameters which can be copied from an object
.PARAMETER InputObject
    StatusCake Object to be copied
.PARAMETER FunctionName
    Name of the function for which the parameters need to be copied
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
    $copyProperties = $parameterMetadata | Select-Object -Property Name, Aliases | Where-Object {$_.Name -in $sourceItemHash.Keys -or $_.Aliases -in $sourceItemHash.Keys}
    $parameterList = [System.Collections.Generic.List[PSObject]]::new()
    foreach($item in $copyProperties)
    {   # Add renamed parameter using first alias
        If($item.aliases[0])
        {
            $parameterList.Add($item.aliases[0])
        }
        else
        {
            $parameterList.Add($item.Name)
        }

    }

    $paramsToUse = Compare-Object @($sourceItemHash.Keys) @($parameterList) -IncludeEqual -ExcludeDifferent
    $paramsToUse = $paramsToUse | Select-Object -ExpandProperty InputObject

    foreach($key in $paramsToUse)
    {
        $psParams[$key]=$sourceItemHash[$key]
    }

    Return $psParams
}