
<#
.Synopsis
   Updates a StatusCake PageSpeed Test
.EXAMPLE
   Set-StatusCakeHelperPageSpeedTest -Username "Username" -ApiKey "APIKEY" -id 123456 -checkrate 3600
.INPUTS
    basePageSpeedTestURL - Base URL endpoint of the statuscake ContactGroup API
    Username - Username associated with the API key
    ApiKey - APIKey to access the StatusCake API
    
    Id - ID of the PageSpeed Test to remove
    Name - Name for this test
    SetByName - Flag to set to use Page Speed Test name instead of id
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
function Set-StatusCakeHelperPageSpeedTest
{
    [CmdletBinding(PositionalBinding=$false,SupportsShouldProcess=$true)]    
    Param(
        [Parameter(ParameterSetName='SetByID')]
        [Parameter(ParameterSetName='SetByName')]
        [Parameter(ParameterSetName='NewPageSpeedTest')]          
        $basePageSpeedTestURL = "https://app.statuscake.com/API/Pagespeed/Update/",

        [Parameter(ParameterSetName='SetByID',Mandatory=$true)]
        [Parameter(ParameterSetName='SetByName',Mandatory=$true)]        
        [Parameter(ParameterSetName='NewPageSpeedTest',Mandatory=$true)] 
        $Username,

        [Parameter(ParameterSetName='SetByID',Mandatory=$true)]
        [Parameter(ParameterSetName='SetByName',Mandatory=$true)]        
        [Parameter(ParameterSetName='NewPageSpeedTest',Mandatory=$true)] 
        $ApiKey,

        [Parameter(ParameterSetName='SetByID',Mandatory=$true)]
        $id,

        [Parameter(ParameterSetName='SetByName',Mandatory=$true)]
        [switch]$SetByName,        

        [Parameter(ParameterSetName='NewPageSpeedTest',Mandatory=$true)]
        [Parameter(ParameterSetName='SetByID')]        
        [Parameter(ParameterSetName='SetByName')]                        
        $name,

        [Parameter(ParameterSetName='SetByID')]
        [Parameter(ParameterSetName='SetByName')]          
        [Parameter(ParameterSetName='NewPageSpeedTest',Mandatory=$true)]   
        [ValidateSet("1","5","10","15","30","60","1440")]
        $checkrate,
       
        [Parameter(ParameterSetName='SetByID')]
        [Parameter(ParameterSetName='SetByName')]          
        [Parameter(ParameterSetName='NewPageSpeedTest',Mandatory=$true)]           
        [ValidateSet("AU","CA","DE","IN","NL","SG","UK","US","PRIVATE")]
        $location_iso,

        [Parameter(ParameterSetName='SetByID')]
        [Parameter(ParameterSetName='SetByName')]          
        [Parameter(ParameterSetName='NewPageSpeedTest',Mandatory=$true)] 
        [ValidatePattern('^((http|https):\/\/)([a-zA-Z0-9\-]+(\.[a-zA-Z]+)+.*)$|^(?!^.*,$)')]    
        [string]$website_url,           

        [Parameter(ParameterSetName='SetByID')]
        [Parameter(ParameterSetName='SetByName')]          
        [Parameter(ParameterSetName='NewPageSpeedTest')]   
        [ValidateScript({$_ -match '^[\d]+$'})]
        [int]$alert_bigger=0,

        [Parameter(ParameterSetName='SetByID')]
        [Parameter(ParameterSetName='SetByName')]          
        [Parameter(ParameterSetName='NewPageSpeedTest')]   
        [ValidateScript({$_ -match '^[\d]+$'})]
        [int]$alert_slower=0,

        [Parameter(ParameterSetName='SetByID')]
        [Parameter(ParameterSetName='SetByName')]          
        [Parameter(ParameterSetName='NewPageSpeedTest')]           
        [ValidateScript({$_ -match '^[\d]+$'})] 
        [int]$alert_smaller=0,
        
        [Parameter(ParameterSetName='SetByID')]
        [Parameter(ParameterSetName='SetByName')]          
        [Parameter(ParameterSetName='NewPageSpeedTest')]    
        [ValidateScript({$_ -match '^[\d]+$'})] 
        [object]$contact_groups,           

        [Parameter(ParameterSetName='SetByID')]
        [Parameter(ParameterSetName='SetByName')]          
        [Parameter(ParameterSetName='NewPageSpeedTest')]
        [ValidateNotNullOrEmpty()]                 
        [string]$private_name

    )
    $authenticationHeader = @{"Username"="$username";"API"="$ApiKey"}
 
    if($Alert_At -and $Alert_At.count -ne 3)
    {
        Write-Error "Only three values must be specified for Alert_At parameter"
        Return
    }

    if($SetByName -and $name)
    {   #If setting test by name verify if a test or tests with that name exists
        if( $pscmdlet.ShouldProcess("StatusCake API", "Retrieve StatusCake PageSpeed tests"))
        {      
            $pageSpeedTest = Get-StatusCakeHelperPageSpeedTest -Username $username -apikey $ApiKey -name $name
            if(!$pageSpeedTest)
            {
                Write-Error "No PageSpeed test with Specified name Exists [$name]"
                Return $null 
            }
            elseif($pageSpeedTest.GetType().Name -eq 'Object[]')
            {
                Write-Error "Multiple PageSpeed tests with the same name [$name] [$($pageSpeedTest.id)]"
                Return $null          
            }            
            $id = $pageSpeedTest.id
        }
    }
    elseif($id)
    {   #If setting by id verify that id already exists
        if( $pscmdlet.ShouldProcess("StatusCake API", "Retrieve StatusCake PageSpeed tests"))
        {      
            $pageSpeedTest = Get-StatusCakeHelperPageSpeedTest -Username $username -apikey $ApiKey -id $id
            if(!$pageSpeedTest)
            {
                Write-Error "No PageSpeed test with Specified ID Exists [$id]"
                Return $null 
            }            
            $id = $pageSpeedTest.id
        }
    }
    else 
    {   #Setup a test with the supplied detiails
        if( $pscmdlet.ShouldProcess("StatusCake API", "Retrieve StatusCake PageSpeed tests") )
        {
            $pageSpeedTest = Get-StatusCakeHelperPageSpeedTest -Username $username -apikey $ApiKey -name $name
            if($pageSpeedTest)
            {
                Write-Error "PageSpeed test with specified name already exists [$name] [$($pageSpeedTest.id)]"
                Return $null 
            }
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
        uri = "$basePageSpeedTestURL"
        Headers = $authenticationHeader
        UseBasicParsing = $true
        method = "Post"
        ContentType = "application/x-www-form-urlencoded"
        body = $statusCakeAPIParams 
    }

    if( $pscmdlet.ShouldProcess("StatusCake API", "Set StatusCake PageSpeed Test") )
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