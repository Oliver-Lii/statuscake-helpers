
<#
.Synopsis
   Retrieves alerts that have been sent in relation to tests setup on the account
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
   Get-StatusCakeHelperSentAlerts -TestID 123456 -since "2017-08-19 13:29:49"
.FUNCTIONALITY
    Retrieves alerts that have been sent in regards to tests setup on the account

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

