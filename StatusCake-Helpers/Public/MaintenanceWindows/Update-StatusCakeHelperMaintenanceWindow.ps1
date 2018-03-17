
<#
.Synopsis
   Updates a StatusCake Maintenance Window
.EXAMPLE
   Update-StatusCakeHelperMaintenanceWindow -Username "Username" -ApiKey "APIKEY" -id 123456 -checkrate 3600
.INPUTS
    baseMaintenanceWindowURL - Base URL endpoint of the statuscake ContactGroup API
    Username - Username associated with the API key
    ApiKey - APIKey to access the StatusCake API
    
    Name - 	A descriptive name for your maintenance window
    Id - The maintenance window ID
    start_date - Start date of your window. Can be slightly in the past
    end_date - 	End time of your window. Must be in the future
    timezone - 	Must be a valid timezone, or UTC
    raw_tests - Individual tests that should be included
    raw_tags - Tests with these tags will be included
    recur_every - How often in days this window should recur. 0 disables this
    follow_dst - Whether DST should be followed or not

.FUNCTIONALITY
   Updates the configuration of StatusCake Maintenance Window using the supplied parameters. You can only update a window which is in a pending state.
#>
function Update-StatusCakeHelperMaintenanceWindow
{
    [CmdletBinding(PositionalBinding=$false,SupportsShouldProcess=$true)]    
    Param(
        [Parameter(ParameterSetName='SetByID')]
        [Parameter(ParameterSetName='SetByName')]        
        $baseMaintenanceWindowURL = "https://app.statuscake.com/API/Maintenance/Update",

        [Parameter(ParameterSetName='SetByID',Mandatory=$true)]
        [Parameter(ParameterSetName='SetByName',Mandatory=$true)]         
        $Username,

        [Parameter(ParameterSetName='SetByID',Mandatory=$true)]
        [Parameter(ParameterSetName='SetByName',Mandatory=$true)]
        $ApiKey,

        [Parameter(ParameterSetName='SetByName',Mandatory=$true)]
        [switch]$SetByName,

        [Parameter(ParameterSetName='SetByID')]
        [ValidateNotNullOrEmpty()]                 
        [string]$id,        

        [Parameter(ParameterSetName='SetByID')]
        [Parameter(ParameterSetName='SetByName')]  
        [ValidateNotNullOrEmpty()]                 
        [string]$name,

        [Parameter(ParameterSetName='SetByID')]
        [Parameter(ParameterSetName='SetByName')] 
        [datetime]$start_date,

        [Parameter(ParameterSetName='SetByID')]
        [Parameter(ParameterSetName='SetByName')]  
        [datetime]$end_date,

        [Parameter(ParameterSetName='SetByID')]
        [Parameter(ParameterSetName='SetByName')]       
        [string]$timezone,

        [Parameter(ParameterSetName='SetByID')]
        [Parameter(ParameterSetName='SetByName')]       
        [ValidateScript({$_ -match '^[\d]+$'})]
        [object]$raw_tests,

        [Parameter(ParameterSetName='SetByID')]
        [Parameter(ParameterSetName='SetByName')] 
        [object]$raw_tags,        

        [Parameter(ParameterSetName='SetByID')]
        [Parameter(ParameterSetName='SetByName')]    
        [ValidateSet("0","1","7","14","30")] 
        $recur_every,

        [Parameter(ParameterSetName='SetByID')]
        [Parameter(ParameterSetName='SetByName')] 
        [ValidateRange(0,1)] 
        $follow_dst

    )
    $authenticationHeader = @{"Username"="$username";"API"="$ApiKey"}
 
    if($SetByName -and $name)
    {   #If setting test by name verify if a test or tests with that name exists
        if( $pscmdlet.ShouldProcess("StatusCake API", "Retrieve StatusCake Maintenance Windows"))
        {      
            $maintenanceWindow = Get-StatusCakeHelperMaintenanceWindow -Username $username -apikey $ApiKey -name $name -state "PND"
            if(!$maintenanceWindow)
            {
                Write-Error "No pending Maintenance Window with specified name exists [$name]"
                Return $null 
            }
            elseif($maintenanceWindow.GetType().Name -eq 'Object[]')
            {
                Write-Error "Multiple Pending Maintenance Windows with the same name [$name] [$($maintenanceWindow.id)]"
                Return $null          
            }            
            $id = $maintenanceWindow.id
        }
    }
    elseif($id)
    {   #If setting by id verify that id already exists
        if( $pscmdlet.ShouldProcess("StatusCake API", "Retrieve StatusCake Maintenance Windows"))
        {      
            $maintenanceWindow = Get-StatusCakeHelperMaintenanceWindow -Username $username -apikey $ApiKey -id $id -state "PND"
            if(!$maintenanceWindow)
            {
                Write-Error "No pending Maintenance Window with specified ID exists [$id]"
                Return $null 
            }            
            $id = $maintenanceWindow.id
        }
    }

    $psParams = @{}
    $ParameterList = (Get-Command -Name $MyInvocation.InvocationName).Parameters
    $ParamsToIgnore = @("baseMaintenanceWindowURL","Username","ApiKey","Name","SetByName")
    foreach ($key in $ParameterList.keys)
    {
        $var = Get-Variable -Name $key -ErrorAction SilentlyContinue;
        if($ParamsToIgnore -contains $var.Name)
        {
            continue
        }
        elseif($var.value -or $var.value -eq 0)
        {   #Contact_Groups can be empty string but must be supplied
            $psParams.Add($var.name,$var.value)                  
        }
    }

    $statusCakeAPIParams = $psParams | ConvertTo-StatusCakeHelperAPIParams

    $putRequestParams = @{
        uri = $baseMaintenanceWindowURL
        Headers = $authenticationHeader
        UseBasicParsing = $true
        method = "Post"
        ContentType = "application/x-www-form-urlencoded"
        body = $statusCakeAPIParams 
    }

    if( $pscmdlet.ShouldProcess("StatusCake API", "Set StatusCake Maintenance Window") )
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