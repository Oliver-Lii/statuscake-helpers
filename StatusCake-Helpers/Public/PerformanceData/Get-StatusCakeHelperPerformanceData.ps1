
<#
.Synopsis
   Retrieves the tests that have been carried out on a given check
.EXAMPLE
   Get-StatusCakeHelperPerformanceData -TestID 123456 -start "2018-01-07 10:14:00"
.INPUTS
    basePerfDataURL - Base URL endpoint of the statuscake alert API
    Username - Username associated with the API key
    ApiKey - APIKey to access the StatusCake API
    TestID - ID of the Test to retrieve the performance data for
    TestName - Name of the Test to retrieve the performance data for
    Fields - Array of additional fields, these additional fields will give you more data about each check.
    Start - Supply to include results only since the specified date
    Limit - Limits to a subset of results - maximum of 1000.
.OUTPUTS
    Returns an object with the details on the tests that have been carried out on a given check
.FUNCTIONALITY
    Retrieves the tests that have been carried out on a given check

#>
function Get-StatusCakeHelperPerformanceData
{
    [CmdletBinding(PositionalBinding=$false,SupportsShouldProcess=$true)]
    Param(
        $basePerfDataURL = "https://app.statuscake.com/API/Tests/Checks",

		[ValidateNotNullOrEmpty()]
        $Username = (Get-StatusCakeHelperAPIAuth).Username,

        [ValidateNotNullOrEmpty()]
        $ApiKey = (Get-StatusCakeHelperAPIAuth).GetNetworkCredential().password,

        [int]$TestID,

        [ValidateNotNullOrEmpty()]
        [string]$TestName,

        [datetime]$Start,

        [ValidateScript({ @("status","location","human","time","headers","performance") -contains $_ })]
        [object]$Fields,

        [ValidateRange(0,1000)]
        $Limit

    )
    $authenticationHeader = @{"Username"="$Username";"API"="$ApiKey"}
    $statusCakeFunctionAuth = @{"Username"=$Username;"Apikey"=$ApiKey}
    Write-Warning -Message "The output from this function will be changed in the next release when the Start parameter is not supplied"
    if($TestName)
    {
        if( $pscmdlet.ShouldProcess("StatusCake API", "Retrieve StatusCake Tests") )
        {
            $testCheck = Get-StatusCakeHelperTest @statusCakeFunctionAuth -TestName $TestName
            if($testCheck.GetType().Name -eq 'Object[]')
            {
                Write-Error "Multiple Tests found with name [$TestName] [$($testCheck.TestID)]. Please retrieve performance data via TestID"
                Return $null
            }
            $TestID = $testCheck.TestID
            else
            {
                Write-Error "Unable to find Test with name [$TestName]"
                Return $null
            }
        }
    }

    $psParams = @{}
    $ParameterList = (Get-Command -Name $MyInvocation.InvocationName).Parameters
    $ParamsToIgnore = @("basePerfDataURL","Username","ApiKey")
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

    $requestParams = @{
        uri = $basePerfDataURL
        Headers = $authenticationHeader
        UseBasicParsing = $true
        method = "Get"
        ContentType = "application/x-www-form-urlencoded"
        body = $statusCakeAPIParams
    }

    if( $pscmdlet.ShouldProcess("StatusCake API", "Retrieve StatusCake Performance Data") )
    {
        $jsonResponse = Invoke-WebRequest @requestParams
        $response = $jsonResponse | ConvertFrom-Json
        Return $response
    }
}

