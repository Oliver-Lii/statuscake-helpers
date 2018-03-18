
<#
.Synopsis
   Retrieves a list of each period of data.
.EXAMPLE
   Get-StatusCakeHelperPeriodOfData -TestID 123456
.INPUTS
    basePeriodURL - Base URL endpoint of the statuscake API
    Username - Username associated with the API key
    ApiKey - APIKey to access the StatusCake API
    TestID - ID of the Test to retrieve the period of data for
    TestName - Name of the Test to retrieve the period of data for
    Additional - Flag to set to return information about the downtime. NOTE: This will slow down the query considerably.
.OUTPUTS    
    Returns an object with the details the periods of data
.FUNCTIONALITY
    Retrieves a list of each period of data. A period of data is two time stamps 
    in which status has remained the same, such as a period of downtime or uptime.
   
#>
function Get-StatusCakeHelperPeriodOfData
{
    [CmdletBinding(PositionalBinding=$false,SupportsShouldProcess=$true)]    
    Param(                     
        $basePeriodURL = "https://app.statuscake.com/API/Tests/Periods/",
         
		[ValidateNotNullOrEmpty()]
        $Username = (Get-StatusCakeHelperAPIAuth).Username,

        [ValidateNotNullOrEmpty()]        
        $ApiKey = (Get-StatusCakeHelperAPIAuth).GetNetworkCredential().password,

        [Parameter(ParameterSetName = "Test ID")]        
        [int]$TestID,

        [Parameter(ParameterSetName = "Test Name")]              
        [ValidateNotNullOrEmpty()]            
        [string]$TestName,

        [Parameter(ParameterSetName = "Test Name")]
        [Parameter(ParameterSetName = "Test ID")]            
        [switch]$Additional 
    )
    $authenticationHeader = @{"Username"="$Username";"API"="$ApiKey"}
    $statusCakeFunctionAuth = @{"Username"=$Username;"Apikey"=$ApiKey}    

    if($TestName)
    {
        $testCheck = Get-StatusCakeHelperTest @statusCakeFunctionAuth -TestName $TestName
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
    if($Additional){[string]$Additional = 0}
    else{[string]$Additional = 1}

    $psParams = @{}
    $ParameterList = (Get-Command -Name $MyInvocation.InvocationName).Parameters
    $ParamsToIgnore = @("basePeriodURL","Username","ApiKey","TestName")
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
        uri = $basePeriodURL
        Headers = $authenticationHeader
        UseBasicParsing = $true
        method = "Get"
        ContentType = "application/x-www-form-urlencoded"
        body = $statusCakeAPIParams 
    }

    if( $pscmdlet.ShouldProcess("StatusCake API", "Retrieve StatusCake Period of Data") )
    {
        $jsonResponse = Invoke-WebRequest @requestParams
        $response = $jsonResponse | ConvertFrom-Json

        if(!$response)
        {
            Write-Warning "No checks have been carried out for the specified test [$TestID]"
            Return $null        
        }
    }
    Return $response
}

