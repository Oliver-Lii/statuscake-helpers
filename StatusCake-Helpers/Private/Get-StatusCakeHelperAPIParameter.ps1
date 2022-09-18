<#
.SYNOPSIS
    Retrieves the StatusCake API parameters
.DESCRIPTION
    Retrieves the StatusCake API parameter names from the parameter aliases defined in the function and modifies them to meet the StatusCake API requirements.
.PARAMETER InputHashTable
    Hashtable containing the values to pass to the StatusCake API
.PARAMETER InvocationInfo
    InvocationInfo object from the calling function
.PARAMETER Clear
    Array of key names for which the values should be sent empty to StatusCake API
.PARAMETER Join
    Hashtable containing values which need to be joined by specific separator
.PARAMETER Exclude
    Array of parameter names which should be excluded from the output hashtable
.EXAMPLE
    C:\PS>$allParameterValues | Get-StatusCakeHelperAPIParameter -InvocationInfo $MyInvocation
    Retrieve the StatusCake API parameter names from the supplied invocation object
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

        [string[]] $Exclude=@()
    )

    Process
    {
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

        foreach($cItem in $Clear)
        {
            If($InputHashTable.ContainsKey($cItem))
            {
                $InputHashTable[$cItem] = "`"`""
            }
            else
            {
                $outputHashtable[$cItem] = "`"`""
            }
        }

        foreach($item in $workingHash)
        {
            #API parameter names should be lower cased
            $itemName = ($item.Name).ToLower()

            Switch($itemName)
            {
                {$rename.ContainsKey($_)}{
                    $outputHashtable[$rename[$_]] = $InputHashTable[$_]
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
}