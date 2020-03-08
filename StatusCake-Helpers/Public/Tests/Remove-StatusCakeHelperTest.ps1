

<#
.Synopsis
   Removes the specified StatusCake Test
.PARAMETER APICredential
    Credentials to access StatusCake API
.PARAMETER TestID
    ID of the Test to be removed from StatusCake
.PARAMETER TestName
    Name of the Test to be removed from StatusCake
.PARAMETER PassThru
    Return the object that is removed
.EXAMPLE
   Remove-StatusCakeHelperTest -TestID 123456
.OUTPUTS
    Returns the result of the test removal as an object
.FUNCTIONALITY
    Removes the StatusCake test via it's Test ID or name

#>
function Remove-StatusCakeHelperTest
{
    [CmdletBinding(PositionalBinding=$false,SupportsShouldProcess=$true)]
    Param(
        [ValidateNotNullOrEmpty()]
        [System.Management.Automation.PSCredential] $APICredential = (Get-StatusCakeHelperAPIAuth),

        [Parameter(ParameterSetName = "Test ID")]
        [ValidateNotNullOrEmpty()]
        [int]$TestID,

        [Parameter(ParameterSetName = "Test Name")]
        [ValidateNotNullOrEmpty()]
        [string]$TestName,

        [switch]$PassThru
    )

    $checkParams = @{}
    if($TestName)
    {
        $checkParams.Add("TestName",$TestName)
    }
    else
    {
        $checkParams.Add("TestID",$TestID)
    }

    $testCheck = Get-StatusCakeHelperTest -APICredential $APICredential -Detailed @checkParams
    if($testCheck)
    {
        if($testCheck.GetType().Name -eq 'Object[]')
        {
            Write-Error "Multiple Tests found with name [$TestName]. Please remove the test by TestID"
            Return $null
        }
        $TestID = $testCheck.TestID
    }
    else
    {
        Write-Error "Unable to find Test with name [$TestName]"
        Return $null
    }

    $requestParams = @{
        uri = "https://app.statuscake.com/API/Tests/Details/?TestID=$TestID"
        Headers = @{"Username"=$APICredential.Username;"API"=$APICredential.GetNetworkCredential().password}
        UseBasicParsing = $true
        Method = "Delete"
    }

    if( $pscmdlet.ShouldProcess("TestID - $TestID", "Remove StatusCake Test") )
    {
        $response = Invoke-RestMethod @requestParams
        $requestParams = @{}
        if($response.Success -ne "True")
        {
            Write-Error "$($response.Message) [$($response.Issues)]"
        }
        elseif($PassThru)
        {
            Return $testCheck
        }
    }
}

