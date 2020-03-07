<#
.Synopsis
   Retrieves the StatusCake API parameters modifying specified parameters
.PARAMETER InputHashTable
   Hashtable containing the values to pass to the StatusCake API
.PARAMETER InvocationInfo
   InvocationInfo object from the calling function
.PARAMETER Clear
   Array of values which should be sent empty to StatusCake API
.PARAMETER Join
   Hashtable containing values which need to be joined by specific separator
.PARAMETER Rename
   Hashtable containing values which need to be renamed to the expected values by StatusCake API
.PARAMETER ToLowerName
   Parameter names not aliased which need to be lower case
#>
Function Get-StatusCakeHelperAPIParameter
{
    [CmdletBinding()]
    [OutputType([hashtable])]
    Param(
        [Parameter(Mandatory=$True,ValueFromPipeline=$True)]
        [hashtable] $InputHashTable,

        [System.Management.Automation.InvocationInfo]$InvocationInfo,

        [string[]] $Clear=@(),

        [hashtable] $Join=@{},

        [string[]] $Exclude=@(),

        [string[]] $ToLowerName=@()
    )

    $parameterAction = $InputHashTable
    $parameterAction.Remove("InputHashTable")
    $parameterAction.Remove("InvocationInfo")

    $outputHashtable = @{}

    # Avoiding sending any common parameters
    $Exclude += [System.Management.Automation.PSCmdlet]::CommonParameters
    $Exclude += [System.Management.Automation.PSCmdlet]::OptionalCommonParameters
    # APICredential is sent as part of the request header
    $Exclude += "APICredential"

    #Remove excluded variables
    $workingHash = $InputHashTable.GetEnumerator() | Where-Object {$_.Key -notin $Exclude}

    #Ignore common parameters and find aliases of parameters which need to be renamed
    $FunctionInfo = (Get-Command -Name $InvocationInfo.InvocationName)
    $parameterMetadata = $FunctionInfo.Parameters.Values
    $aliases = $parameterMetadata | Select-Object -Property Name, Aliases | Where-Object {$_.Name -in $workingHash.Key -and $_.Aliases}
    $rename = @{}
    foreach($item in $aliases)
    {   # Rename parameter using first alias
        $rename[$item.name] = $item.aliases[0]
    }

    foreach($item in $workingHash)
    {
        $itemName = $item.Name
        if($ToLowerName.Contains($itemName))
        {
            $itemName = $itemName.ToLower()
        }
        Switch($itemName)
        {
            {$rename.ContainsKey($_)}{
                $outputHashtable[$rename[$_]] = $InputHashTable[$_]
            }
            {$Clear.Contains($_)}{
                $outputHashtable[$_] = "";Break
            }
            {$Join.ContainsKey($_)}{
                $outputHashtable[$_] = $InputHashTable[$_] -join $Join[$_]
            }
            Default {
                $outputHashtable[$_] = $InputHashTable[$_]
            }
        }
    }
    Return $outputHashtable
}