
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
        {   #Validate Range accepts $true or $false values as 0 or 1 so explictly convert to int
            If($var.value -eq $true){
                $value=1
                $var.value = $value   
            }
            elseif($var.value -eq $false){
                $value=0
                $var.value = $value
            }

            switch($var.value.GetType().Name)
            {
                'Object[]'{ #Arrays need to be converted to comma separated lists
                    $value = $var.value -join ","  
                }
                'DateTime'{ #Dates need to be converted to Unix Epoch time
                    $date = Get-Date -Date "01/01/1970"
                    $value = $var.value
                    $value = [Math]::Round($((New-TimeSpan -Start $date -End $value).TotalSeconds)) 
                }
                'Hashtable'{ # Hash table should be converted to JSON (CustomHeader)
                    $value = $var.value  | ConvertTo-Json
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