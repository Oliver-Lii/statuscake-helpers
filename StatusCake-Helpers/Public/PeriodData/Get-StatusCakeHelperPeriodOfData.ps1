
<#
.SYNOPSIS
    Retrieves a list of each period of data.
.DESCRIPTION
    Retrieves a list of each period of data. A period of data is two time stamps in which status has remained the same, such as a period of downtime or uptime.
.PARAMETER APICredential
    Credentials to access StatusCake API
.PARAMETER TestID
    ID of the Test to retrieve the period of data for
.PARAMETER TestName
    Name of the Test to retrieve the period of data for
.PARAMETER Additional
    Flag to set to return information about the downtime. NOTE: This will slow down the query considerably.
.EXAMPLE
    C:\PS>Get-StatusCakeHelperPeriodOfData -TestID 123456
    Retrieve period of data for uptime test 123456
.OUTPUTS
    Returns an object with the details the periods of data
#>
function Get-StatusCakeHelperPeriodOfData
{
    [CmdletBinding(PositionalBinding=$false,SupportsShouldProcess=$true)]
    Param(
        [ValidateNotNullOrEmpty()]
        [System.Management.Automation.PSCredential] $APICredential = (Get-StatusCakeHelperAPIAuth),

        [Parameter(ParameterSetName = "Test ID")]
        [int]$TestID,

        [Parameter(ParameterSetName = "Test Name")]
        [ValidateNotNullOrEmpty()]
        [string]$TestName,

        [Parameter(ParameterSetName = "Test Name")]
        [Parameter(ParameterSetName = "Test ID")]
        [switch]$Additional
    )

    if($TestName)
    {
        $testCheck = Get-StatusCakeHelperTest -APICredential $APICredential -TestName $TestName
        if($testCheck.GetType().Name -eq 'Object[]')
        {
            Write-Error "Multiple Tests found with name [$TestName] [$($testCheck.TestID)]. Please retrieve the periods of data via TestID"
            Return $null
        }
        $TestID = $testCheck.TestID
        else
        {
            Write-Error "Unable to find Test with name [$TestName]"
            Return $null
        }
    }

    #Additional parameter needs to be set to 1 to prevent additional field from being returned in response
    $Addition = 1
    if($Additional){$Addition = 0}

    $statusCakeAPIParams = @{}
    $statusCakeAPIParams.Add("Additional",$Addition)
    $statusCakeAPIParams.Add("TestID",$TestID)
    $statusCakeAPIParams = $statusCakeAPIParams | ConvertTo-StatusCakeHelperAPIParameter

    $requestParams = @{
        uri = "https://app.statuscake.com/API/Tests/Periods/"
        Headers = @{"Username"=$APICredential.Username;"API"=$APICredential.GetNetworkCredential().password}
        UseBasicParsing = $true
        method = "Get"
        ContentType = "application/x-www-form-urlencoded"
        body = $statusCakeAPIParams
    }

    if( $pscmdlet.ShouldProcess("StatusCake API", "Retrieve StatusCake Period of Data") )
    {
        $response = Invoke-RestMethod @requestParams
        $requestParams = @{}
        if(!$response)
        {
            Write-Warning "No checks have been carried out for the specified test [$TestID]"
            Return $null
        }
    }
    Return $response
}

