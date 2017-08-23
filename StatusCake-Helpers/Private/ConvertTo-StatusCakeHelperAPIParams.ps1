
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
            switch($var.name)
            {
                "BasicPass"{
                    $outputHashTable.Add($var.name,$var.value)
                    $value = $var.value -replace '.?','*'
                }
                "CustomHeader"{ #Custom Header must be supplied as JSON                
                    $value = $var.value  | ConvertTo-Json
                    $outputHashTable.Add($var.name,$value)                                                                             
                }
                "Email"{ #Email addresses need to be supplied as a comma separated list
                    $value = $var.value -join ","
                    $outputHashTable.Add($var.name,$value)                                                   
                } 
                "Mobile"{ #Mopbile numbers need to be supplied as a comma separated list
                    $value = $var.value -join ","
                    $outputHashTable.Add($var.name,$value)                                        
                }                                  
                "NodeLocations"{ #Node Location IDs need to be supplied as a comma separated list
                    $value = $var.value -join ","
                    $outputHashTable.Add($var.name,$value)                                        
                }
                "StatusCodes"{ #Status Codes need to be supplied as a comma separated list
                    $value = $var.value -join ","
                    $outputHashTable.Add($var.name,$value)                                                   
                }                                   
                "TestName"{
                    $value = $var.value                     
                    $outputHashTable.Add("WebsiteName",$value)
                }
                "TestURL"{
                    $value = $var.value                       
                    $outputHashTable.Add("WebsiteURL",$value)                  
                }
                "TestTags"{  #Test Tags need to be supplied as a comma separated list
                    $value = $var.value -join ","
                    $outputHashTable.Add($var.name,$value)                    
                }
                default {
                    $value = $var.value                     
                    $outputHashTable.Add($var.name,$value)
                }
            }
            write-verbose "[$($var.name)] will be added to StatusCake Test with value [$value]"            
        }
    }
    Return $outputHashTable    
}