
<#
.Synopsis
   Remove tag(s) from a StatusCake test
.EXAMPLE
   Remove-StatusCakeHelperTestTags -Username "Username" -ApiKey "APIKEY" -TestID "123456" -TestTags @("Tag1","Tag2")
.INPUTS
    baseTestURL - Base URL endpoint of the statuscake test API
    Username - Username associated with the API key
    ApiKey - APIKey to access the StatusCake API
    TestID - The Test ID to modify the details for
    RemoveByTestName - Remove tag from a test via the name of the test
    TestTags - Array of tags to be removed
    TestName - Name of the Test

.FUNCTIONALITY
    Add tag(s) to a existing test.

#>
function Remove-StatusCakeHelperTestTags
{
    [CmdletBinding(PositionalBinding=$false,SupportsShouldProcess=$true)]
    Param(
        [Parameter(ParameterSetName='RemoveByTestName')]
        [Parameter(ParameterSetName='RemoveByTestID')]
        $baseTestURL = "https://app.statuscake.com/API/Tests/Update",

        [Parameter(ParameterSetName='RemoveByTestName')]
        [Parameter(ParameterSetName='RemoveByTestID')]
		[ValidateNotNullOrEmpty()]
        $Username = (Get-StatusCakeHelperAPIAuth).Username,

        [Parameter(ParameterSetName='RemoveByTestName')]
        [Parameter(ParameterSetName='RemoveByTestID')]
        [ValidateNotNullOrEmpty()]
        $ApiKey = (Get-StatusCakeHelperAPIAuth).GetNetworkCredential().password,

        [Parameter(ParameterSetName='RemoveByTestID',Mandatory=$true)]
        [ValidatePattern('^\d{1,}$')]
        $TestID,

        [Parameter(ParameterSetName='RemoveByTestName',Mandatory=$true)]
        [switch]$RemoveByTestName,

        [Parameter(ParameterSetName='RemoveByTestName',Mandatory=$true)]
        [Parameter(ParameterSetName='RemoveByTestID')]
        [ValidateNotNullOrEmpty()]
        $TestName,

        [Parameter(ParameterSetName='RemoveByTestName')]
        [Parameter(ParameterSetName='RemoveByTestID')]
        [ValidateNotNullOrEmpty()]
        [object]$TestTags

    )
    $authenticationHeader = @{"Username"="$Username";"API"="$ApiKey"}
    $statusCakeFunctionAuth = @{"Username"=$Username;"Apikey"=$ApiKey}

    Write-Warning -Message "Remove-StatusCakeHelperTestTags will be renamed to Remove-StatusCakeHelperTestTag in the next release"
    if($RemoveByTestName -and $TestName)
    {   #If setting test by name check if a test or tests with that name exists
        if( $pscmdlet.ShouldProcess("StatusCake API", "Retrieve StatusCake Tests"))
        {
            $testCheck = Get-StatusCakeHelperTest @statusCakeFunctionAuth -TestName $TestName
            if(!$testCheck)
            {
                Write-Error "No Test with Specified Name Exists [$TestName]"
                Return $null
            }
            elseif($testCheck.GetType().Name -eq 'Object[]')
            {
                Write-Error "Multiple Tests with the same name [$TestName] [$($testCheck.TestID)]"
                Return $null
            }
            $TestID = $testCheck.TestID
        }
    }
    elseif($TestID)
    {   #If setting by TestID verify that TestID already exists
        if( $pscmdlet.ShouldProcess("StatusCake API", "Retrieve StatusCake Tests"))
        {
            $testCheck = Get-StatusCakeHelperTest @statusCakeFunctionAuth -TestID $TestID
            if(!$testCheck)
            {
                Write-Error "No Test with Specified ID Exists [$TestID]"
                Return $null
            }
            $TestID = $testCheck.TestID
        }
    }

    if( $pscmdlet.ShouldProcess("StatusCake API", "Retrieve StatusCake Detailed Test Data") )
    {
        $detailedTestData = Get-StatusCakeHelperDetailedTestData @statusCakeFunctionAuth -TestID $TestID
    }

    if(!$detailedTestData.Tags)
    {
        Write-Verbose "Test currently contains no tags"
        $detailedTestData.Tags = ""
    }
    $TestTags = $TestTags | Select-Object -Unique
    $differentTestTags = Compare-Object $detailedTestData.Tags $TestTags -IncludeEqual
    $TestTags = $differentTestTags | Where-Object {$_.SideIndicator -eq "<="} | Select-Object -ExpandProperty InputObject
    $RemovedTags = $differentTestTags | Where-Object {$_.SideIndicator -eq "=="} | Select-Object -ExpandProperty InputObject
    $TagsNotPresent = $differentTestTags | Where-Object {$_.SideIndicator -eq "=>"} | Select-Object -ExpandProperty InputObject

    Write-Verbose "Removing Following Tags from Test [$RemovedTags]"
    Write-Verbose "Following Tags not attached to Test [$TagsNotPresent]"

    $psParams = @{}
    $ParameterList = (Get-Command -Name $MyInvocation.InvocationName).Parameters
    $ParamsToIgnore = @("baseTestURL","Username","ApiKey","RemoveByTestName")
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
        uri = $baseTestURL
        Headers = $authenticationHeader
        UseBasicParsing = $true
        method = "Put"
        ContentType = "application/x-www-form-urlencoded"
        body = $statusCakeAPIParams
    }

    if( $pscmdlet.ShouldProcess("StatusCake API", "Set StatusCake Test") )
    {
        $jsonResponse = Invoke-WebRequest @putRequestParams
        $response = $jsonResponse | ConvertFrom-Json
        if($response.Success -ne "True")
        {
            Write-Error "$($response.Message) [$($response.Issues)]"
            Return $null
        }
        Return $response
    }

}