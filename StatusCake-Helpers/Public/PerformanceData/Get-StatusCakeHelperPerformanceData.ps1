
<#
.SYNOPSIS
    Retrieves the tests that have been carried out on a given check
.DESCRIPTION
    Retrieves the performance details of a test that have been carried out for a uptime test. At any one time this will return a days worth of results and you are able to cycle through each of the results using the start parameter. The latest tests are shown first.
.PARAMETER APICredential
   Credentials to access StatusCake API
.PARAMETER TestID
    ID of the Test to retrieve the performance data for
.PARAMETER TestName
    Name of the Test to retrieve the performance data for
.PARAMETER Fields
    Array of additional fields, these additional fields will give you more data about each check
.PARAMETER Start
    Supply to include results only since the specified date
.PARAMETER Limit
    Limits to a subset of results - maximum of 1000
.EXAMPLE
    C:\PS>Get-StatusCakeHelperPerformanceData -TestID 123456 -Start "2018-01-07 10:14:00"
    Retrieve test performance data for test id 123456 from the 7th January 2018 10:14:00
.OUTPUTS
    Returns an object with the details on the tests that have been carried out on a given check
#>
function Get-StatusCakeHelperPerformanceData
{
    [CmdletBinding(PositionalBinding=$false,SupportsShouldProcess=$true)]
    [OutputType([System.Collections.Generic.List[PSObject]])]
    Param(
        [ValidateNotNullOrEmpty()]
        [System.Management.Automation.PSCredential] $APICredential = (Get-StatusCakeHelperAPIAuth),

        [int]$TestID,

        [ValidateNotNullOrEmpty()]
        [string]$TestName,

        [datetime]$Start,

        [ValidateScript({ $_ -in @("status","location","human","time","headers","performance")})]
        [string[]]$Fields=@("status","location","human","time","headers","performance"),

        [ValidateRange(0,1000)]
        [int]$Limit

    )

    if($TestName)
    {
        if( $pscmdlet.ShouldProcess("StatusCake API", "Retrieve StatusCake Tests") )
        {
            $testCheck = Get-StatusCakeHelperTest -APICredential $APICredential -TestName $TestName
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

    $allParameterValues = $MyInvocation | Get-StatusCakeHelperParameterValue -BoundParameters $PSBoundParameters
    $statusCakeAPIParams = $allParameterValues | Get-StatusCakeHelperAPIParameter -InvocationInfo $MyInvocation
    $statusCakeAPIParams = $statusCakeAPIParams | ConvertTo-StatusCakeHelperAPIParameter

    $requestParams = @{
        uri = "https://app.statuscake.com/API/Tests/Checks"
        Headers = @{"Username"=$APICredential.Username;"API"=$APICredential.GetNetworkCredential().password}
        UseBasicParsing = $true
        method = "Get"
        ContentType = "application/x-www-form-urlencoded"
        body = $statusCakeAPIParams
    }

    if( $pscmdlet.ShouldProcess("StatusCake API", "Retrieve StatusCake Performance Data") )
    {
        $response = Invoke-RestMethod @requestParams
        $requestParams=@{}

        if($Start)
        {
            Return $response
        }

        #Restructure response into a list if start parameter not supplied
        $times = $response | Get-Member -MemberType NoteProperty | Select-Object -ExpandProperty Name
        $perfDataList = [System.Collections.Generic.List[PSObject]]::new()
        foreach($time in $times)
        {
            $value = $response | Select-Object -ExpandProperty $time
            $element = [PSCustomObject]@{
                Time = $value.Time
                Status = $value.Status
                Location = $value.Location
                Performance = $value.Performance
                Headers = $value.Headers
                Human = $value.Human
            }
            $perfDataList.Add($element)
        }
        Return $perfDataList
    }
}

