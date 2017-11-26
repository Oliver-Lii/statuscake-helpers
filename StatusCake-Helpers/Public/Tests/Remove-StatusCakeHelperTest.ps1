

<#
.Synopsis
   Removes the specified StatusCake Test
.EXAMPLE
   Remove-StatusCakeHelperTest -Username "Username" -ApiKey "APIKEY" -TestID 123456
.INPUTS
    baseTestURL - Base URL endpoint of the statuscake Test API
    Username - Username associated with the API key
    ApiKey - APIKey to access the StatusCake API
    TestID - ID of the Test to be removed
.OUTPUTS    
    Returns the result of the test removal as an object
.FUNCTIONALITY
    Removes the StatusCake test via it's Test ID
   
#>
function Remove-StatusCakeHelperTest
{
    [CmdletBinding(PositionalBinding=$false,SupportsShouldProcess=$true)]
    Param(
        $baseTestURL = "https://app.statuscake.com/API/Tests/Details/?TestID=",
        [Parameter(Mandatory=$true)]        
        $Username,
        [Parameter(Mandatory=$true)]        
        $ApiKey,
        [Parameter(ParameterSetName = "Test ID")]
        [ValidateNotNullOrEmpty()]
        [int]$TestID,
        [Parameter(ParameterSetName = "Test Name")]
        [ValidateNotNullOrEmpty()]
        [string]$TestName,        
        [switch]$PassThru
    )
    $authenticationHeader = @{"Username"="$username";"API"="$ApiKey"}
    
    if($TestName)
    {
        $testCheck = Get-StatusCakeHelperTest -Username $username -apikey $ApiKey -TestName $TestName
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
    }

    $requestParams = @{
        uri = "$baseTestURL$TestID"
        Headers = $authenticationHeader
        UseBasicParsing = $true
        Method = "Delete"
    }

    if( $pscmdlet.ShouldProcess("TestID - $TestID", "Remove StatusCake Test") )
    {
        $jsonResponse = Invoke-WebRequest @requestParams
        $response = $jsonResponse | ConvertFrom-Json
        if($response.Success -ne "True")
        {
            Write-Verbose $response
            Write-Error "$($response.Message) [$($response.Issues)]"
        }
        if(!$PassThru)
        {
            Return
        }
        Return $response        
    }
}

