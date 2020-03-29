
<#
.SYNOPSIS
    Converts a PSCustomObject to a hashtable
.DESCRIPTION
    Converts a PSCustomObject to a hashtable.
.PARAMETER PSCustomObject
    PSCustomObject to be converted
.PARAMETER IncludeNull
    Flag to include properties with null values in returned hashtable
.EXAMPLE
    C:\PS>$PSCustomObject | ConvertTo-StatusCakeHelperHashtableFromPSCustomObject
    Convert a PSCustomObject into a hashtable
#>
function ConvertTo-StatusCakeHelperHashtableFromPSCustomObject
{
    [CmdletBinding()]
    [OutputType([hashtable])]
    Param(
        [Parameter(Mandatory=$True,ValueFromPipeline=$True)]
        [Object] $PSCustomObject,

        [switch] $IncludeNull
    )

    $hashtable = @{}
    $properties = $PSCustomObject | Get-Member -MemberType *Property

    foreach($property in $properties)
    {
        $value = $PSCustomObject | Select-Object -ExpandProperty ($property.name)
        if($null -ne $value -and !([string]::IsNullOrEmpty($value)) -or $IncludeNull)
        {
            $hashtable[$property.name] = $value
        }
    }
    return  $hashtable
}