<#
.Synopsis
   Converts a hashtable of parameters to the format expected by the StatusCake API
.PARAMETER InputHashTable
   Hashtable containing the values to pass to the StatusCake API
.EXAMPLE
   ConvertTo-StatusCakeHelperAPIParameter -InputHashTable [hashtable]

.FUNCTIONALITY
   Converts a hashtable of parameters to the format expected by the StatusCake API
#>
function ConvertTo-StatusCakeHelperAPIParameter
{
    [CmdletBinding()]
    [OutputType([hashtable])]
    Param(
        [Parameter(Mandatory=$True,ValueFromPipeline=$True)]
        [hashtable] $InputHashTable
    )

    $workingHashtable = $PSBoundParameters["InputHashTable"]
    $outputHashTable =@{}

    foreach ($var in $workingHashtable.GetEnumerator())
    {
        $name = $var.name

        switch($var.value.GetType().Name)
        {
            'Boolean'{ # Boolean should be converted to integers
                $value = 0
                If($var.value -eq $true){
                    $value=1
                }
                $outputHashTable[$name] = $value
                Break
            }
            'DateTime'{ #Dates need to be converted to Unix Epoch time
                $date = Get-Date -Date "01/01/1970"
                $value = $var.value
                $outputHashTable[$name] = [Math]::Round($((New-TimeSpan -Start $date -End $value).TotalSeconds))
                Break
            }
            'Hashtable'{ # Hash table should be converted to JSON (CustomHeader)
                $outputHashTable[$name] = $var.value  | ConvertTo-Json
                Break
            }
            'Int32[]'{ #Arrays need to be converted to comma separated lists
                $outputHashTable[$name] = $var.value -join ","
                Break
            }
            'Object[]'{ #Arrays need to be converted to comma separated lists
                $outputHashTable[$name] = $var.value -join ","
                Break
            }
            'SecureString'{ #SecureString needs to be converted to plaintext
                $Credentials = New-Object System.Management.Automation.PSCredential -ArgumentList "UserName", $var.value
                $outputHashTable[$name] = $Credentials.GetNetworkCredential().Password
                Write-Verbose "[$($var.name)] [$($var.value.GetType().Name)] will be added with value [$("*".PadRight($Credentials.Password.Length, "*"))]"
                Break
            }
            'String[]'{ #Arrays need to be converted to comma separated lists
                $outputHashTable[$name] = $var.value -join ","
                Break
            }
            'String'{ # API is case sensitive for True/False strings
                $outputHashTable[$name] = $var.value
                if($outputHashTable[$name] -ceq "True" -or $outputHashTable[$name] -ceq "False")
                {
                    $outputHashTable[$name] = $outputHashTable[$name].ToLower()
                }
                Break
            }
            default {
                $outputHashTable[$name] = $var.value
            }
        }
        if($var.value.GetType().Name -ne 'SecureString')
        {
            Write-Verbose "[$($var.name)] [$($var.value.GetType().Name)] will be added with value [$($outputHashTable[$name])]"
        }
    }
    Return $outputHashTable
}