
<#
.Synopsis
   Create a StatusCake PageSpeed Test
.EXAMPLE
   New-StatusCakeHelperPageSpeedTest -Username "Username" -ApiKey "APIKEY" -title "https://www.example.com" -checkrate 3600
.INPUTS
    basePageSpeedTestURL - Base URL endpoint of the statuscake ContactGroup API
    Username - Username associated with the API key
    ApiKey - APIKey to access the StatusCake API
    
    Name - Name for this test
    Website_Url - URL that should be checked
    Location_iso - 	2-letter ISO code of the location
    Private_Name - Must select PRIVATE in location_iso. Name of private server [NOT YET IMPLEMENTED]
    Checkrate - Checkrate in minutes
    Contact_Groups - IDs of selected Contact Groups
    Alert_Smaller - Size in kb, will alert to Contact Groups if actual size is smaller
    Alert_Bigger - 	Size in kb, will alert to Contact Groups if actual size is bigger
    Alert_Slower - Time in ms, will alert to Contact Groups if actual time is slower     

.FUNCTIONALITY
   Creates a new StatusCake PageSpeed Test using the supplied parameters.
#>
function New-StatusCakeHelperPageSpeedTest
{
    [CmdletBinding(PositionalBinding=$false,SupportsShouldProcess=$true)]    
    Param(
        $basePageSpeedTestURL = "https://app.statuscake.com/API/Pagespeed/Update",
        [Parameter(Mandatory=$true)]        
        $Username,
        [Parameter(Mandatory=$true)]        
        $ApiKey,

        [Parameter(Mandatory=$true)] 
        [ValidateNotNullOrEmpty()]                 
        [string]$name,

        [Parameter(Mandatory=$true)] 
        [ValidatePattern('^((http|https):\/\/)([a-zA-Z0-9\-]+(\.[a-zA-Z]+)+.*)$|^(?!^.*,$)')]    
        [string]$website_url,

        [Parameter(Mandatory=$true)] 
        [ValidateSet("AU","CA","DE","IN","NL","SG","UK","US","PRIVATE")]
        $location_iso,
       
        [Parameter(Mandatory=$true)] 
        [ValidateSet("1","5","10","15","30","60","1440")]      
        [int]$checkrate,

        [ValidateScript({$_ -match '^[\d]+$'})]
        [int]$alert_bigger=0,

        [ValidateScript({$_ -match '^[\d]+$'})]
        [int]$alert_slower=0,        

        [ValidateScript({$_ -match '^[\d]+$'})] 
        [int]$alert_smaller=0,

        [ValidateScript({$_ -match '^[\d]+$'})] 
        [object]$contact_groups,
        
        [ValidateNotNullOrEmpty()]                 
        [string]$private_name        
    )
    $authenticationHeader = @{"Username"="$username";"API"="$ApiKey"}
 

    if( $pscmdlet.ShouldProcess("StatusCake API", "Retrieve StatusCake PageSpeed Test") )
    {
        $PageSpeedTest = Get-StatusCakeHelperPageSpeedTest -Username $username -apikey $ApiKey -name $name
        if($PageSpeedTest)
        {
            Write-Error "PageSpeed Check with specified title already exists [$title] [$($PageSpeedTest.id)]"
            Return $null 
        }
    }    

    $psParams = @{}
    $ParameterList = (Get-Command -Name $MyInvocation.InvocationName).Parameters
    $ParamsToIgnore = @("basePageSpeedTestURL","Username","ApiKey")
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

    $webRequestParams = @{
        uri = $basePageSpeedTestURL
        Headers = $authenticationHeader
        UseBasicParsing = $true
        method = "Post"
        ContentType = "application/x-www-form-urlencoded"
        body = $statusCakeAPIParams
    }

    if( $pscmdlet.ShouldProcess("StatusCake API", "Add StatusCake PageSpeed Test") )
    {
        $jsonResponse = Invoke-WebRequest @webRequestParams
        $response = $jsonResponse | ConvertFrom-Json
        if($response.Success -ne "True")
        {
            Write-Error "$($response.Message) [$($response.Issues)]"
            Return $null
        }         
        Return $response
    }

}