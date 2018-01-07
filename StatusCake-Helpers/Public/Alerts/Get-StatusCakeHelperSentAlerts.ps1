
<#
.Synopsis
   Retrieves alerts that have been sent in relation to tests setup on the account
.EXAMPLE
   Get-StatusCakeHelperSentAlerts -TestID 123456 -since "2017-08-19 13:29:49"
.INPUTS
    baseAlertURL - Base URL endpoint of the statuscake alert API
    Username - Username associated with the API key
    ApiKey - APIKey to access the StatusCake API
    TestID - ID of the Test to retrieve the sent alerts for
    TestName - Name of the Test to retrieve the sent alerts for
    Since - Supply to include results only since the specified date
.OUTPUTS    
    Returns an object with the details on the Alerts Sent
.FUNCTIONALITY
    Retrieves alerts that have been sent in regards to tests setup on the account
   
#>
function Get-StatusCakeHelperSentAlerts
{
    [CmdletBinding(PositionalBinding=$false,SupportsShouldProcess=$true)]    
    Param(                     
        $baseAlertURL = "https://app.statuscake.com/API/Alerts/",
         
        [Parameter(Mandatory=$true)]        
        [string]$Username,

        [Parameter(Mandatory=$true)]
        [string]$ApiKey,
                    
        [int]$TestID,     
              
        [ValidateNotNullOrEmpty()]            
        [string]$TestName,
                   
        [datetime]$Since
    )
    $authenticationHeader = @{"Username"="$username";"API"="$ApiKey"}

    if($TestName)
    {
        if( $pscmdlet.ShouldProcess("StatusCake API", "Retrieve StatusCake Tests") )
        {        
            $testCheck = Get-StatusCakeHelperTest -Username $username -apikey $ApiKey -TestName $TestName
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

    $psParams = @{}
    $ParameterList = (Get-Command -Name $MyInvocation.InvocationName).Parameters
    $ParamsToIgnore = @("baseAlertURL","Username","ApiKey","TestName")
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
        uri = $baseAlertURL
        Headers = $authenticationHeader
        UseBasicParsing = $true
        method = "Get"
        ContentType = "application/x-www-form-urlencoded"
        body = $statusCakeAPIParams 
    }

    if( $pscmdlet.ShouldProcess("StatusCake API", "Retrieve StatusCake Sent Alerts") )
    {
        $jsonResponse = Invoke-WebRequest @requestParams
        $response = $jsonResponse | ConvertFrom-Json
        Return $response
    }
}

