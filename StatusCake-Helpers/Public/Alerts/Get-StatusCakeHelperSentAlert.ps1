
<#
.SYNOPSIS
    Retrieves alerts that have been sent in relation to tests setup on the account
.DESCRIPTION
    Returns alerts that have been sent for tests. The return order is newest alerts are shown first.
    Alerts to be returned can be filtered by test using the TestID or TestName parameter and filtered by date using the Since parameter.
.PARAMETER APICredential
    Credentials to access StatusCake API
.PARAMETER TestID
    ID of the Test to retrieve the sent alerts for
.PARAMETER TestName
    Name of the Test to retrieve the sent alerts for
.PARAMETER Since
    Supply to include results only since the specified date
.OUTPUTS
    Returns an object with the details on the Alerts Sent
.EXAMPLE
   C:\PS> Get-StatusCakeHelperSentAlert
   Return all the alerts sent for any test
.EXAMPLE
   C:\PS> Get-StatusCakeHelperSentAlert -TestID 123456 -since "2017-08-19 13:29:49"
   Return all the alerts sent for test ID 123456 since the 19th August 2017 13:29:49
#>
function Get-StatusCakeHelperSentAlert
{
    [CmdletBinding(PositionalBinding=$false,SupportsShouldProcess=$true)]
    Param(
        [ValidateNotNullOrEmpty()]
        [System.Management.Automation.PSCredential] $APICredential = (Get-StatusCakeHelperAPIAuth),

        [int]$TestID,

        [ValidateNotNullOrEmpty()]
        [string]$TestName,

        [datetime]$Since
    )

    if($TestName)
    {
        if( $pscmdlet.ShouldProcess("StatusCake API", "Retrieve StatusCake Tests") )
        {
            $testCheck = Get-StatusCakeHelperTest -APICredential $APICredential -TestName $TestName
            if($testCheck.GetType().Name -eq 'Object[]')
            {
                Write-Error "Multiple Tests found with name [$TestName] [$($testCheck.TestID)]. Please retrieve sent alerts via TestID"
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

    $exclude=@("TestName")
    $allParameterValues = $MyInvocation | Get-StatusCakeHelperParameterValue -BoundParameters $PSBoundParameters
    $statusCakeAPIParams = $allParameterValues | Get-StatusCakeHelperAPIParameter -InvocationInfo $MyInvocation -Exclude $exclude
    $statusCakeAPIParams = $statusCakeAPIParams | ConvertTo-StatusCakeHelperAPIParameter

    $requestParams = @{
        uri = "https://app.statuscake.com/API/Alerts/"
        Headers = @{"Username"=$APICredential.Username;"API"=$APICredential.GetNetworkCredential().password}
        UseBasicParsing = $true
        method = "Get"
        ContentType = "application/x-www-form-urlencoded"
        body = $statusCakeAPIParams
    }

    if( $pscmdlet.ShouldProcess("StatusCake API", "Retrieve StatusCake Sent Alerts") )
    {
        $response = Invoke-RestMethod @requestParams
        $requestParams=@{}
        Return $response
    }
}

