
<#
.Synopsis
   Remove a StatusCake SSL Test
.EXAMPLE
   Remove-StatusCakeHelperSSLTest -Username "Username" -ApiKey "APIKEY" -ID 123456
.INPUTS
    baseSSLTestURL - Base URL endpoint of the statuscake ContactGroup API
    Username - Username associated with the API key
    ApiKey - APIKey to access the StatusCake API
    
    ID - ID of the SSL Test to remove

.FUNCTIONALITY
   Deletes a StatusCake SSL Test using the supplied ID.
#>
function Remove-StatusCakeHelperSSLTest
{
    [CmdletBinding(PositionalBinding=$false,SupportsShouldProcess=$true)]    
    Param(
        $baseSSLTestURL = "https://app.statuscake.com/API/SSL/Update",

		[ValidateNotNullOrEmpty()]
        $Username = (Get-StatusCakeHelperAPIAuth).Username,       

        [ValidateNotNullOrEmpty()]        
        $ApiKey = (Get-StatusCakeHelperAPIAuth).GetNetworkCredential().password,

        [Parameter(ParameterSetName = "ID")]             
        [int]$id,

        [Parameter(ParameterSetName = "title")]
        [ValidatePattern('^((https):\/\/)([a-zA-Z0-9\-]+(\.[a-zA-Z]+)+.*)$|^(?!^.*,$)')]                 
        [string]$title,        

        [switch]$PassThru        
    )
    $authenticationHeader = @{"Username"="$Username";"API"="$ApiKey"}
    $statusCakeFunctionAuth = @{"Username"=$Username;"Apikey"=$ApiKey}    
 
    if($title)
    {
        $sslTest = Get-StatusCakeHelperSSLTest @statusCakeFunctionAuth -title $title
        if($sslTest)
        {
            if($sslTest.GetType().Name -eq 'Object[]')
            {
                Write-Error "Multiple SSL Tests found with domain [$domain]. Please remove the SSL test by ID"
                Return $null            
            }
            $id = $sslTest.id
        }
        else 
        {
            Write-Error "Unable to find SSL Test with name [$domain]"
            Return $null
        }
    }

    $psParams = @{}
    $ParameterList = (Get-Command -Name $MyInvocation.InvocationName).Parameters
    $ParamsToIgnore = @("baseSSLTestURL","Username","ApiKey","domain")
    foreach ($key in $ParameterList.keys)
    {
        $var = Get-Variable -Name $key -ErrorAction SilentlyContinue;
        if($ParamsToIgnore -contains $var.Name)
        {
            continue
        }
        elseif($var.value -or $var.value -eq 0)
        {   #Contact_Groups can be empty string but must be supplied
            $psParams.Add($var.name,$var.value)                  
        }
    }

    $statusCakeAPIParams = $psParams | ConvertTo-StatusCakeHelperAPIParams

    $putRequestParams = @{
        uri = $baseSSLTestURL
        Headers = $authenticationHeader
        UseBasicParsing = $true
        method = "Delete"
        ContentType = "application/x-www-form-urlencoded"
        body = $statusCakeAPIParams 
    }

    if( $pscmdlet.ShouldProcess("StatusCake API", "Remove StatusCake SSL Test") )
    {
        $jsonResponse = Invoke-WebRequest @putRequestParams
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