
<#
.Synopsis
   Gets the history of a StatusCake PageSpeed Test
.PARAMETER APICredential
   Credentials to access StatusCake API
.PARAMETER Name
    Name of the PageSpeed test
.PARAMETER ID
    ID of the PageSpeed Test
.PARAMETER Days
    Amount of days to look up
.EXAMPLE
   Get-StatusCakeHelperPageSpeedTestHistory -id 123456
.OUTPUTS
    Returns a StatusCake PageSpeed Tests History as an object
.FUNCTIONALITY
    Retrieves the history for a StatusCake PageSpeed Test

#>
function Get-StatusCakeHelperPageSpeedTestHistory
{
    [CmdletBinding(PositionalBinding=$false,SupportsShouldProcess=$true)]
    Param(
        [ValidateNotNullOrEmpty()]
        [System.Management.Automation.PSCredential] $APICredential = (Get-StatusCakeHelperAPIAuth),

        [Parameter(ParameterSetName = "name")]
        [ValidatePattern('^((https):\/\/)([a-zA-Z0-9\-]+(\.[a-zA-Z]+)+.*)$|^(?!^.*,$)')]
        [string]$Name,

        [Parameter(ParameterSetName = "ID")]
        [ValidateNotNullOrEmpty()]
        [int]$ID,

        [Parameter(ParameterSetName = "name")]
        [Parameter(ParameterSetName = "ID")]
        [ValidateRange(1,30)]
        [int]$Days
    )

    if($Name)
    {
        if( $pscmdlet.ShouldProcess("StatusCake API", "Retrieve StatusCake PageSpeed Tests") )
        {
            $matchingTest = Get-StatusCakeHelperPageSpeedTest -APICredential $APICredential -name $Name
            if(!$matchingTest)
            {
                Write-Error "No PageSpeed Check with specified name exists [$Name]"
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

    $lower =@('ID','Days')
    $allParameterValues = $MyInvocation | Get-StatusCakeHelperParameterValue -BoundParameters $PSBoundParameters
    $statusCakeAPIParams = $allParameterValues | Get-StatusCakeHelperAPIParameter -InvocationInfo $MyInvocation -ToLowerName $lower
    $statusCakeAPIParams = $statusCakeAPIParams | ConvertTo-StatusCakeHelperAPIParameter

    $requestParams = @{
        uri = "https://app.statuscake.com/API/Pagespeed/History/"
        Headers = @{"Username"=$APICredential.Username;"API"=$APICredential.GetNetworkCredential().password}
        UseBasicParsing = $true
        method = "Get"
        ContentType = "application/x-www-form-urlencoded"
        body = $statusCakeAPIParams
    }

    if( $pscmdlet.ShouldProcess("StatusCake API", "Retrieve StatusCake PageSpeed Tests") )
    {
        $response = Invoke-RestMethod @requestParams
        $requestParams = @{}
        if($response.Success -ne "True")
        {
            Write-Verbose $response
            Write-Error "$($response.Message) [$($response.Issues)]"
        }

        Return $response.data
    }

}

