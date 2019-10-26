
<#
.Synopsis
   Gets a StatusCake PageSpeed Test
.PARAMETER basePageSpeedTestURL
    Base URL endpoint of the statuscake PageSpeed Test API
.PARAMETER Username
    Username associated with the API key
.PARAMETER ApiKey
    APIKey to access the StatusCake API
.PARAMETER Name
    Name of the PageSpeed test
.PARAMETER Id
    ID of the PageSpeed Test
.EXAMPLE
   Get-StatusCakeHelperPageSpeedTest -Username "Username" -ApiKey "APIKEY" -id 123456
.OUTPUTS
    Returns a StatusCake PageSpeed Tests as an object
.FUNCTIONALITY
    Retrieves a specific StatusCake PageSpeed Test

#>
function Get-StatusCakeHelperPageSpeedTest
{
    [CmdletBinding(PositionalBinding=$false,SupportsShouldProcess=$true)]
    Param(
        $basePageSpeedTestURL = "https://app.statuscake.com/API/Pagespeed/",

		[ValidateNotNullOrEmpty()]
        $Username = (Get-StatusCakeHelperAPIAuth).Username,
        [ValidateNotNullOrEmpty()]
        $ApiKey = (Get-StatusCakeHelperAPIAuth).GetNetworkCredential().password,

        [Parameter(ParameterSetName = "name")]
        [ValidatePattern('^((https):\/\/)([a-zA-Z0-9\-]+(\.[a-zA-Z]+)+.*)$|^(?!^.*,$)')]
        [string]$name,

        [Parameter(ParameterSetName = "ID")]
        [ValidateNotNullOrEmpty()]
        [int]$id
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
                Return $null
            }
            #Retrieving PageSpeed tests without an ID number returns data with different field names
            #Recursively call the function itself to ensure data is returned in the same format
            $pageSpeedTestData=@()
            foreach($match in $matchingTest)
            {
                $pageSpeedTestData+=Get-StatusCakeHelperPageSpeedTest -Username $username -apikey $ApiKey -id $match.id
            }
            Return $pageSpeedTestData
        }

    }

    $psParams = @{}
    $ParameterList = (Get-Command -Name $MyInvocation.InvocationName).Parameters
    $ParamsToIgnore = @("basePageSpeedTestURL","Username","ApiKey","name")
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

    $putRequestParams = @{
        uri = $basePageSpeedTestURL
        Headers = $authenticationHeader
        UseBasicParsing = $true
        method = "Get"
        ContentType = "application/x-www-form-urlencoded"
        body = $statusCakeAPIParams
    }

    if( $pscmdlet.ShouldProcess("StatusCake API", "Retrieve StatusCake PageSpeed Tests") )
    {
        $jsonResponse = Invoke-WebRequest @putRequestParams
        $response = $jsonResponse | ConvertFrom-Json
        if($response.Success -ne "True")
        {
            Write-Verbose $response
            Write-Error "$($response.Message) [$($response.Issues)]"
        }

        Return $response.data
    }

}

