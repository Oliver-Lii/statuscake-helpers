

<#
.Synopsis
   Removes the specified StatusCake ContactGroup
.EXAMPLE
   Remove-StatusCakeHelperContactGroup -Username "Username" -ApiKey "APIKEY" -contactID 123456
.INPUTS
    baseContactGroupURL - Base URL endpoint of the statuscake ContactGroup API
    Username - Username associated with the API key
    ApiKey - APIKey to access the StatusCake API
    ContactID - ID of the ContactGroup to be removed
    GroupName - Name of the Contact Group to be removed
.OUTPUTS    
    Returns the result of the ContactGroup removal as an object
.FUNCTIONALITY
    Removes the StatusCake ContactGroup via it's ContactID or GroupName
   
#>
function Remove-StatusCakeHelperContactGroup
{
    [CmdletBinding(PositionalBinding=$false,SupportsShouldProcess=$true)]
    Param(
        $baseContactGroupURL = "https://app.statuscake.com/API/ContactGroups/Update/?ContactID=",

		[ValidateNotNullOrEmpty()]
        $Username = (Get-StatusCakeHelperAPIAuth).Username,
        [ValidateNotNullOrEmpty()]        
        $ApiKey = (Get-StatusCakeHelperAPIAuth).GetNetworkCredential().password,

        [Parameter(ParameterSetName = "ContactID")]
        [ValidateNotNullOrEmpty()]
        [int]$ContactID,
        [Parameter(ParameterSetName = "GroupName")]
        [ValidateNotNullOrEmpty()]
        [string]$GroupName,
        [switch]$Force,        
        [switch]$PassThru
    )
    $authenticationHeader = @{"Username"="$Username";"API"="$ApiKey"}
    $statusCakeFunctionAuth = @{"Username"=$Username;"Apikey"=$ApiKey}

    if($GroupName)
    {
        if( $pscmdlet.ShouldProcess("StatusCake API", "Retrieve StatusCake Contact Groups") )
        {        
            $ContactGroupCheck = Get-StatusCakeHelperContactGroup @statusCakeFunctionAuth -GroupName $GroupName
            if($ContactGroupCheck)
            {
                if($ContactGroupCheck.GetType().Name -eq 'Object[]')
                {
                    Write-Error "Multiple ContactGroups found with name [$GroupName]. Please remove the ContactGroup by ContactID"
                    Return $null            
                }                  
                $ContactID = $ContactGroupCheck.ContactID
            }
            else 
            {
                Write-Error "Unable to find ContactGroup with name [$GroupName]"
                Return $null
            }
        }
    }

    if( $pscmdlet.ShouldProcess("StatusCake API", "Retrieve StatusCake Tests") )
    { 
        $StatusCakeTests = Get-StatusCakeHelperAllTests @statusCakeFunctionAuth
        $StatusCakeTestsWithContact = $StatusCakeTests | Where-Object {$_.ContactGroup -Contains $ContactID}
        if($StatusCakeTestsWithContact -and !$Force)
        {
            Write-Error "ContactGroup in use by tests [$($StatusCakeTestsWithContact.TestID)]. Please use -Force switch to remove this ContactGroup"
            Return $null            
        }
    }  

    $requestParams = @{
        uri = "$baseContactGroupURL$ContactID"
        Headers = $authenticationHeader
        UseBasicParsing = $true
        Method = "Delete"
    }

    if( $pscmdlet.ShouldProcess("ContactID - $ContactID", "Remove StatusCake ContactGroup") )
    {
        $jsonResponse = Invoke-WebRequest @requestParams
        $response = $jsonResponse | ConvertFrom-Json
        if($response.Success -ne "True")
        {
            Write-Verbose $response
            Write-Error "$($response.Message) [$($response.Issues)]"
        }
        if(!$PassThru)
        {
            Return
        }
        Return $response        
    }
}

