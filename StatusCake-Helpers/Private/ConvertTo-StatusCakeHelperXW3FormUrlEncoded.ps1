<#
.SYNOPSIS
   Converts a hashtable of parameters to the request body type for the StatusCake API
.DESCRIPTION
   Converts a hashtable of parameters to the request body type for the StatusCake API
.PARAMETER InputHashTable
   Hashtable containing the parameters to be converted
.EXAMPLE
   C:\PS>$inputHashtable | ConvertTo-StatusCakeHelperXW3FormUrlEncoded
   Convert a hashtable to application/x-www-form-urlencoded content body type
#>
function ConvertTo-StatusCakeHelperXW3FormUrlEncoded
{
    [CmdletBinding()]
    [OutputType([string])]
    Param(
        [Parameter(Mandatory=$True,ValueFromPipeline=$True)]
        [hashtable] $InputHashTable
    )

    Process
    {
        $workingHashtable = $PSBoundParameters["InputHashTable"]
        $parameterArray = [System.Collections.Generic.List[PSObject]]::new()
        $outputString = ""

        foreach ($var in $workingHashtable.GetEnumerator())
        {
            $name = $var.name

            switch($var.value.GetType().BaseType.Name)
            {
                'Array'{ # Prefix key with "[]" and add copy of key for each value
                    $name = $([uri]::EscapeDataString("$name[]"))
                    $var.value | ForEach-Object{$parameterArray.Add("$name=$([uri]::EscapeDataString(($_)))")}
                    Break
                }
                default {
                    $name = [uri]::EscapeDataString($name)
                    $value = [uri]::EscapeDataString(($var.value))
                    $parameterArray.Add("$name=$value")
                }
            }
            $outputString = $parameterArray -join "&"
        }

        Return $outputString
    }
}