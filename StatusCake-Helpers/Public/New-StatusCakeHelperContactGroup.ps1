
<#
.Synopsis
   Create a StatusCake ContactGroup
.EXAMPLE
   New-StatusCakeHelperContactGroup -Username "Username" -ApiKey "APIKEY" -GroupName "Example" -email @(test@example.com)
.INPUTS
    baseContactGroupURL - Base URL endpoint of the statuscake ContactGroup API
    Username - Username associated with the API key
    ApiKey - APIKey to access the StatusCake API
    GroupName - Name of the ContactGroup to be displayed in StatusCake

    <optional parameters>
    DesktopAlert - Set to 1 To Enable Desktop Alerts
    Email - Array containing emails addresses to alert.
    Boxcar - A Boxcar API Key
    Pushover - A Pushover Account Key
    PingURL - A URL To Send a POST alert.
    Mobile - Array containing list of International Format Cell Numbers

.FUNCTIONALITY
   Creates a new StatusCake ContactGroup using the supplied parameters.
#>
function New-StatusCakeHelperContactGroup
{
    [CmdletBinding(PositionalBinding=$false,SupportsShouldProcess=$true)]    
    Param(
        $baseContactGroupURL = "https://app.statuscake.com/API/ContactGroups/Update",
        [Parameter(Mandatory=$true)]        
        $Username,
        [Parameter(Mandatory=$true)]        
        $ApiKey,
        [Parameter(Mandatory=$true)]
        [ValidateNotNullOrEmpty()] 
        $GroupName,
 
        #Optional parameters
        [ValidateRange(0,1)]         
        $DesktopAlert,
        [object]$Email,
        [ValidatePattern('^((http|https):\/\/)([a-zA-Z0-9\-]+(\.[a-zA-Z]+)+.*)$|^(?!^.*,$)')]                  
        $PingURL,       
        [ValidateNotNullOrEmpty()]            
        [string]$Boxcar,
        [ValidateNotNullOrEmpty()]         
        [string]$Pushover,
        [object]$Mobile
    )
    $authenticationHeader = @{"Username"="$username";"API"="$ApiKey"}

    if( $pscmdlet.ShouldProcess("StatusCake API", "Retrieve StatusCake ContactGroups") )
    {
        $ContactGroupCheck = Get-StatusCakeHelperContactGroup -Username $username -apikey $ApiKey -GroupName $GroupName
        if($ContactGroupCheck)
        {
            Write-Error "ContactGroup with specified name already exists [$ContactGroupCheck]"
            Return $null 
        }
    }

    if($Email)
    {
        foreach($emailAddress in $Email)
        {
            Write-Verbose "Validating email address [$emailAddress]"
            if(!$($emailAddress | Test-StatusCakeHelperEmailAddress))
            {
                Write-Error "Invalid email address supplied [$emailAddress]"
                Return $null 
            }
        }
    }

    if($Mobile)
    {
        foreach($mobileNumber in $Mobile)
        {
            Write-Verbose "Validating mobile number [$mobileNumber]"
            if(!$($mobileNumber | Test-StatusCakeHelperMobileNumber))
            {          
                Write-Error "Mobile number is not in E.164 format [$mobileNumber]"
                Return $null 
            }
        }
    }    

    $psParams = @{}
    $ParameterList = (Get-Command -Name $MyInvocation.InvocationName).Parameters
    $ParamsToIgnore = @("baseContactGroupURL","Username","ApiKey")
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
        uri = $baseContactGroupURL
        Headers = $authenticationHeader
        UseBasicParsing = $true
        method = "Put"
        ContentType = "application/x-www-form-urlencoded"
        body = $statusCakeAPIParams 
    }

    if( $pscmdlet.ShouldProcess("StatusCake API", "Add StatusCake ContactGroup") )
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