
<#
.Synopsis
   Gets the history of a StatusCake PageSpeed Test
.EXAMPLE
   Get-StatusCakeHelperPageSpeedTestHistory -Username "Username" -ApiKey "APIKEY" -id 123456
.INPUTS
    basePageSpeedTestURL - Base URL endpoint of the statuscake auth API
    Username - Username associated with the API key
    ApiKey - APIKey to access the StatusCake API
    Name - Name of the test to retrieve
    ID - Test ID to retrieve    
.OUTPUTS    
    Returns a StatusCake PageSpeed Tests History as an object
.FUNCTIONALITY
    Retrieves the history for a StatusCake PageSpeed Test
   
#>
function Get-StatusCakeHelperPageSpeedTestHistory
{
    [CmdletBinding(PositionalBinding=$false,SupportsShouldProcess=$true)]    
    Param(
        $basePageSpeedTestURL = "https://app.statuscake.com/API/Pagespeed/History/",

		[ValidateNotNullOrEmpty()]
        $Username = (Get-StatusCakeHelperAPIAuth).Username,
        [ValidateNotNullOrEmpty()]        
        $ApiKey = (Get-StatusCakeHelperAPIAuth).GetNetworkCredential().password,

        [Parameter(ParameterSetName = "name")]
        [ValidatePattern('^((https):\/\/)([a-zA-Z0-9\-]+(\.[a-zA-Z]+)+.*)$|^(?!^.*,$)')]
        [string]$name,

        [Parameter(ParameterSetName = "ID")]
        [ValidateNotNullOrEmpty()]            
        [int]$id,

        [Parameter(ParameterSetName = "name")]
        [Parameter(ParameterSetName = "ID")]
        [ValidateRange(0,14)]            
        [int]$days        
    )
    $authenticationHeader = @{"Username"="$Username";"API"="$ApiKey"}

    if($name)
    {
        if( $pscmdlet.ShouldProcess("StatusCake API", "Retrieve StatusCake PageSpeed Tests") )
        {
            $matchingTest = Get-StatusCakeHelperAllPageSpeedTests -Username $username -apikey $ApiKey
            $matchingTest = $matchingTest | Where-Object {$_.title -eq $name}            
            if(!$matchingTest)
            {
                Write-Error "No PageSpeed Check with specified name exists [$name]"
                Return $null 
            }

            #If multiple matches for the same name return the data for all matching tests
            $pageSpeedTestData=@()
            foreach($match in $matchingTest)
            {
                $pageSpeedTestData+=Get-StatusCakeHelperPageSpeedTestHistory -Username $username -apikey $ApiKey -id $match.id
            }
            Return $pageSpeedTestData
        }  

    }

    $psParams = @{}
    $ParameterList = (Get-Command -Name $MyInvocation.InvocationName).Parameters
    $ParamsToIgnore = @("basePageSpeedTestURL","Username","ApiKey")
    foreach ($key in $ParameterList.keys)
    {
        $var = Get-Variable -Name $key -ErrorAction SilentlyContinue;
        if($ParamsToIgnore -contains $var.Name)
        {
            continue
        }
        elseif($var.value -or $var.value -eq 0)
        {
            $psParams.Add($var.name,$var.value)                  
        }
    }

    $statusCakeAPIParams = $psParams | ConvertTo-StatusCakeHelperAPIParams

    $webRequestParams = @{
        uri = $basePageSpeedTestURL
        Headers = $authenticationHeader
        UseBasicParsing = $true
        method = "Get"
        ContentType = "application/x-www-form-urlencoded"
        body = $statusCakeAPIParams 
    }

    if( $pscmdlet.ShouldProcess("StatusCake API", "Retrieve StatusCake PageSpeed Tests") )
    {
        $jsonResponse = Invoke-WebRequest @webRequestParams     
        $response = $jsonResponse | ConvertFrom-Json
        if($response.Success -ne "True")
        {
            Write-Verbose $response
            Write-Error "$($response.Message) [$($response.Issues)]"
        }         

        Return $response.data
    }

}

