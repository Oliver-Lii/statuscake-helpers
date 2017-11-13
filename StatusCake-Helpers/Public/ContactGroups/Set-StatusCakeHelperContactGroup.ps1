
<#
.Synopsis
   Set a StatusCake ContactGroup
.EXAMPLE
   Set-StatusCakeHelperContactGroup -Username "Username" -ApiKey "APIKEY" -GroupName "Example" -email @(test@example.com)
.INPUTS
    baseContactGroupURL - Base URL endpoint of the statuscake ContactGroup API
    Username - Username associated with the API key
    ApiKey - APIKey to access the StatusCake API
    ContactID - ID of the contact group to Set

    GroupName - Name of the ContactGroup to be displayed in StatusCake    
    DesktopAlert - Set to 1 To Enable Desktop Alerts
    Email - Array containing emails addresses to alert.
    Boxcar - A Boxcar API Key
    Pushover - A Pushover Account Key
    PingURL - A URL To Send a POST alert.
    Mobile - Array containing list of International Format Cell Numbers
    SetByGroupName - Flag to set if you wish to Set the Contact Group by Group Name    

.FUNCTIONALITY
   Sets a StatusCake ContactGroup using the supplied parameters. Values supplied overwrite existing values
#>
function Set-StatusCakeHelperContactGroup
{
    [CmdletBinding(PositionalBinding=$false,SupportsShouldProcess=$true)]    
    Param(     
        $baseContactGroupURL = "https://app.statuscake.com/API/ContactGroups/Update",

        [Parameter(Mandatory=$true)]           
        [string]$Username,

        [Parameter(Mandatory=$true)]
        [string]$ApiKey,       

        [Parameter(ParameterSetName='SetByContactID')]        
        [int]$ContactID,

        [Parameter(ParameterSetName='SetByGroupName')]        
        [switch]$SetByGroupName,

        [Parameter(ParameterSetName='SetByGroupName',Mandatory=$true)]
        [Parameter(ParameterSetName='SetByContactID')]          
        [ValidateNotNullOrEmpty()] 
        $GroupName,

        [Parameter(ParameterSetName='SetByGroupName')]
        [Parameter(ParameterSetName='SetByContactID')]         
        [ValidateRange(0,1)]         
        $DesktopAlert,

        [Parameter(ParameterSetName='SetByGroupName')]
        [Parameter(ParameterSetName='SetByContactID')]         
        [object]$Email,

        [Parameter(ParameterSetName='SetByGroupName')]
        [Parameter(ParameterSetName='SetByContactID')]         
        [ValidatePattern('^((http|https):\/\/)([a-zA-Z0-9\-]+(\.[a-zA-Z]+)+.*)$|^(?!^.*,$)')]                  
        $PingURL,
        
        [Parameter(ParameterSetName='SetByGroupName')]
        [Parameter(ParameterSetName='SetByContactID')]         
        [ValidateNotNullOrEmpty()]            
        [string]$Boxcar,

        [Parameter(ParameterSetName='SetByGroupName')]
        [Parameter(ParameterSetName='SetByContactID')]         
        [ValidateNotNullOrEmpty()]         
        [string]$Pushover,

        [Parameter(ParameterSetName='SetByGroupName')]
        [Parameter(ParameterSetName='SetByContactID')]         
        [object]$Mobile      
    )
    $authenticationHeader = @{"Username"="$username";"API"="$ApiKey"}

    if($SetByGroupName -and $GroupName)
    {
        if( $pscmdlet.ShouldProcess("StatusCake API", "Retrieve StatusCake ContactGroups"))
        {            
            $contactGroupCheck = Get-StatusCakeHelperContactGroup -Username $username -apikey $ApiKey -GroupName $GroupName
            if(!$contactGroupCheck)
            {
                Write-Error "Unable to find Contact Group with specified name [$GroupName]"
                Return $null  
            }
            elseif($contactGroupCheck.GetType().Name -eq 'Object[]')
            {
                Write-Error "Multiple Contact Groups with the same name [$GroupName]"
                Return $null            
            }
            $ContactID = $contactGroupCheck.ContactID
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
    $ParamsToIgnore = @("baseContactGroupURL","Username","ApiKey","SetByGroupName")
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