
<#
.Synopsis
   Converts a hashtable of parameters to the format expected by the StatusCake API
.EXAMPLE
   ConvertTo-StatusCakeHelperAPIParams -InputHashTable [hashtable]
.INPUTS
    InputHashTable - Hashtable containing the values to pass to the StatusCake API

.FUNCTIONALITY
   Converts a hashtable of parameters to the format expected by the StatusCake API
#>
function ConvertTo-StatusCakeHelperAPIParams
{
    [CmdletBinding()]
    Param(
        [Parameter(Mandatory=$True,
        ValueFromPipeline=$True)]        
        [hashtable] $InputHashTable
    )   

    $outputHashTable =@{}
    foreach ($var in $InputHashTable.GetEnumerator())
    {
        if($var.value -or $var.value -eq 0)
        {
            switch($var.value.GetType().Name)
            {
                'Boolean'{ # Boolean should be converted to integers
                    $value = 0
                    If($var.value -eq $true){
                        $value=1  
                    }
                    $var.value = $value
                }
                'DateTime'{ #Dates need to be converted to Unix Epoch time
                    $date = Get-Date -Date "01/01/1970"
                    $value = $var.value
                    $value = [Math]::Round($((New-TimeSpan -Start $date -End $value).TotalSeconds)) 
                }
                'Hashtable'{ # Hash table should be converted to JSON (CustomHeader)
                    $value = $var.value  | ConvertTo-Json
                }
                'Object[]'{ #Arrays need to be converted to comma separated lists
                    $value = $var.value -join ","  
                }
                'String'{ # API is case sensitive for True/False strings
                    $value = $var.value
                    if($value -ceq "True" -or $value -ceq "False") 
                    {
                        $value = $value.ToLower()
                    }
                }                                                
                default {
                    $value = $var.value   
                }
            }

            switch($var.name)
            {                              
                "BasicPass"{ # Prevent write-verbose from displaying password
                    $outputHashTable.Add($var.name,$value) 
                    $value = $value -replace '.?','*'
                }
                "Tests_or_Tags"{ # Test or tags are separated by "|"
                    $value = $var.value -join "|"
                    $outputHashTable.Add($var.name,$value) 
                }                
                "End_date"{ # Api parameter is end_unix
                    $outputHashTable.Add("end_unix",$value)                                                   
                }                                                                                
                "Start_date"{ # Api parameter is start_unix                 
                    $outputHashTable.Add("start_unix",$value)                                                   
                }                                                   
                "TestName"{                   
                    $outputHashTable.Add("WebsiteName",$value)
                }
                "TestURL"{                      
                    $outputHashTable.Add("WebsiteURL",$value)                  
                }                
                default {                    
                    $outputHashTable.Add($var.name,$value)
                }
            }
            Write-Verbose "[$($var.name)] [$($var.value.GetType().Name)] will be added with value [$value]"                             
        }
    }
    Return $outputHashTable    
}