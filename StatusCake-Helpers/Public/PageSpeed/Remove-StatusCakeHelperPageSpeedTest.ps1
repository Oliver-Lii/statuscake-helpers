
<#
.Synopsis
   Remove a StatusCake PageSpeed Test
.EXAMPLE
   Remove-StatusCakeHelperPageSpeedTest -Username "Username" -ApiKey "APIKEY" -ID 123456
.INPUTS
    basePageSpeedTestURL - Base URL endpoint of the statuscake ContactGroup API
    Username - Username associated with the API key
    ApiKey - APIKey to access the StatusCake API
    Name - The name of the PageSpeed Test to remove
    ID - ID of the PageSpeed Test to remove

.FUNCTIONALITY
   Deletes a StatusCake PageSpeed Test using the supplied ID.
#>
function Remove-StatusCakeHelperPageSpeedTest
{
    [CmdletBinding(PositionalBinding=$false,SupportsShouldProcess=$true)]    
    Param(
        $basePageSpeedTestURL = "https://app.statuscake.com/API/Pagespeed/Update/?id=",

        [Parameter(Mandatory=$true)]        
        $Username,        

        [Parameter(Mandatory=$true)]        
        $ApiKey,

        [Parameter(ParameterSetName = "ID")]             
        [int]$id,

        [Parameter(ParameterSetName = "name")]            
        [string]$name,        

        [switch]$PassThru        
    )
    $authenticationHeader = @{"Username"="$username";"API"="$ApiKey"}
 
    if($name)
    {
        $pageSpeedTest = Get-StatusCakeHelperPageSpeedTest -Username $username -apikey $ApiKey -name $name
        if($pageSpeedTest)
        {
            if($pageSpeedTest.GetType().Name -eq 'Object[]')
            {
                Write-Error "Multiple PageSpeed Tests found with name [$name]. Please remove the PageSpeed test by ID"
                Return $null            
            }
            $id = $pageSpeedTest.id
        }
        else 
        {
            Write-Error "Unable to find PageSpeed Test with name [$name]"
            Return $null
        }
    }

    $webRequestParams = @{
        uri = "$basePageSpeedTestURL$id"
        Headers = $authenticationHeader
        UseBasicParsing = $true
        method = "Delete"
    }

    if( $pscmdlet.ShouldProcess("StatusCake API", "Remove StatusCake PageSpeed Test") )
    {
        $jsonResponse = Invoke-WebRequest @webRequestParams
        $response = $jsonResponse | ConvertFrom-Json
        if($response.Success -ne "True")
        {
            Write-Error "$($response.Message) [$($response.Issues)]"
        }         
        if(!$PassThru)
        {
            Return
        }
        Return $response     
    }

}