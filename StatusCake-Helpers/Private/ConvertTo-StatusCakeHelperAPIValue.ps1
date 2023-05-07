<#
.SYNOPSIS
    Converts a hashtable of parameter values to the format expected by the StatusCake API
.DESCRIPTION
    Converts a hashtable of parameter values to the format expected by the StatusCake API
.PARAMETER InputHashTable
    Hashtable containing the parameters and values to be converted
.PARAMETER DateUnix
    Keys with values which should be converted to Unix timestamp instead of RFC3339 format
.PARAMETER CsvString
    Key with values which should be converted to a CSV string instead of as an array
.EXAMPLE
   C:\PS>$inputHashtable | ConvertTo-StatusCakeHelperAPIValue
   Convert values of a hashtable into values to the format expected by StatusCake API
#>
function ConvertTo-StatusCakeHelperAPIValue
{
    [CmdletBinding()]
    [OutputType([hashtable])]
    Param(
        [Parameter(Mandatory=$True,ValueFromPipeline=$True)]
        [hashtable] $InputHashTable,

        [string[]]$DateUnix,

        [string[]]$CsvString
    )

    Process
    {
        $workingHashtable = $PSBoundParameters["InputHashTable"]
        $outputHashtable = @{}

        foreach ($var in $workingHashtable.GetEnumerator())
        {
            $name = $var.name

            switch($var.value.GetType().Name)
            {
                'Boolean'{ # Boolean should be converted to lower case "true/false"
                    $value = "false"
                    If($var.value -eq $true){
                        $value = "true"
                    }
                    $outputHashtable.Add($name,$value)
                    Break
                }
                'DateTime'{ #Dates needs to be in RFC3339 unless Unix timestamp has been specified for the parameter
                    if($name -in $DateUnix)
                    {
                        [int64]$value = ($var.value).ToUniversalTime() | Get-Date -UFormat %s
                    }
                    else
                    {
                        $value = ($var.value).ToUniversalTime() | Get-Date -Format s
                        $value = "$value`Z"
                    }
                    $outputHashtable.Add($name,$value)
                    Break
                }
                'Hashtable'{ # Hash table should be converted to JSON (CustomHeader)
                    $value = $var.value  | ConvertTo-Json
                    $outputHashtable.Add($name,$value)
                    Break
                }
                'IPAddress[]'{ # IP Address string should be used
                    $ipAddresses = [System.Collections.Generic.List[PSObject]]::new()
                    $value = $var.value | ForEach-Object{$ipAddresses.Add($_.IPAddressToString)}
                    $outputHashtable.Add($name,$value)
                    Break
                }
                'Object'{ # Hash table should be converted to JSON (CustomHeader)
                    $value = $var.value  | ConvertTo-Json
                    $outputHashtable.Add($name,$value)
                    Break
                }
                'Object[]'{ #Convert arrays to CSV if specified
                    $value = $var.value
                    if($name -in $CsvString)
                    {
                        $value = $var.value -join ","
                    }
                    $outputHashtable.Add($name,$value)
                    Break
                }
                'SecureString'{ #SecureString needs to be converted to plaintext
                    $Credentials = New-Object System.Management.Automation.PSCredential -ArgumentList "UserName", $var.value
                    $value = $Credentials.GetNetworkCredential().Password
                    Write-Verbose "[$($var.name)] [$($var.value.GetType().Name)] will be added with value [$("*".PadRight(8, "*"))]"
                    $outputHashtable.Add($name,$value)
                    Break
                }
                'String[]'{ #Convert arrays to CSV if specified
                    $value = $var.value
                    if($name -in $CsvString)
                    {
                        $value = $var.value -join ","
                    }
                    $outputHashtable.Add($name,$value)
                    Break
                }
                'Uri'{ # Original string of URI should be used
                    $value = $($var.value).OriginalString
                    $outputHashtable.Add($name,$value)
                    Break
                }
                default {
                    $value = $var.value
                    $outputHashtable.Add($name,$value)
                }
            }

            if($var.value.GetType().Name -ne 'SecureString')
            {
                Write-Verbose "[$($var.name)] [$($var.value.GetType().Name)] will be added with value [$value]"
            }
        }
        Return $outputHashtable
    }
}