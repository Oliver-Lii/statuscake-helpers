
<#
.Synopsis
   Copies the settings of a StatusCake Public Reporting Page
.EXAMPLE
   Copy-StatusCakeHelperPublicReportingPage -Name "Example" -NewName "Example - Copy"
.INPUTS
    Username - Username associated with the API key
    ApiKey - APIKey to access the StatusCake API

    Name - Name of the Public Reporting Page to be copied
    ID - ID of the Public Reporting Page to be copied
    NewTitle - Name of the new Public Reporting Page
    Checkrate - Checkrate in seconds. Default is one day.
.FUNCTIONALITY
   Creates a copy of a Public Reporting Page.
#>
function Copy-StatusCakeHelperPublicReportingPage
{
    [CmdletBinding(PositionalBinding=$false,SupportsShouldProcess=$true)]    
    Param(
        [Parameter(ParameterSetName='CopyByTitle')]
        [Parameter(ParameterSetName='CopyById')]
		[ValidateNotNullOrEmpty()]
        $Username = (Get-StatusCakeHelperAPIAuth).Username,

        [Parameter(ParameterSetName='CopyByTitle')]
        [Parameter(ParameterSetName='CopyById')]
        [ValidateNotNullOrEmpty()]        
        $ApiKey = (Get-StatusCakeHelperAPIAuth).GetNetworkCredential().password,

        [Parameter(ParameterSetName='CopyById',Mandatory=$true)]
        [ValidateNotNullOrEmpty()]
        $Id,

        [Parameter(ParameterSetName='CopyByTitle',Mandatory=$true)]       
        [ValidateNotNullOrEmpty()]
        $Title,

        [Parameter(ParameterSetName='CopyByTitle',Mandatory=$true)]
        [Parameter(ParameterSetName='CopyById',Mandatory=$true)]
        [ValidateNotNullOrEmpty()]
        $NewTitle
    )
    $statusCakeFunctionAuth = @{"Username"=$Username;"Apikey"=$ApiKey}

    if($Name)
    {   #If copying by name check if resource with that name exists
        if( $pscmdlet.ShouldProcess("StatusCake API", "Retrieve StatusCake Public Reporting Pages"))
        {      
            $statusCakeItem = Get-StatusCakeHelperPublicReportingPage @statusCakeFunctionAuth -Title $Title
            if(!$statusCakeItem)
            {
                Write-Error "No Public Reporting Page with Specified Title Exists [$Title]"
                Return $null 
            }
            elseif($statusCakeItem.GetType().Name -eq 'Object[]')
            {
                Write-Error "Multiple Public Reporting Pages with the same title [$Title] [$($statusCakeItem.ID)]"
                Return $null          
            }            
        }
    }
    elseif($ID)
    {   #If copying by ID verify that a resource with the Id already exists
        if( $pscmdlet.ShouldProcess("StatusCake API", "Retrieve StatusCake Public Reporting Pages"))
        {      
            $statusCakeItem = Get-StatusCakeHelperPublicReportingPage @statusCakeFunctionAuth -id $ID
            if(!$statusCakeItem)
            {
                Write-Error "No Public Reporting Page with Specified ID Exists [$ID]"
                Return $null 
            }            
        }
    }

    $psParams = @{}
    $ParameterList = (Get-Command -Name New-StatusCakeHelperPublicReportingPage).Parameters

    $paramsToUse = $statusCakeItem | Get-Member | Select-Object Name
    $paramsToUse = Compare-Object $paramsToUse.Name @($ParameterList.keys) -IncludeEqual -ExcludeDifferent
    $paramsToUse = $paramsToUse | Select-Object -ExpandProperty InputObject

    foreach ($key in $paramsToUse)
    {
        $value = $statusCakeItem.$key
        if($value -or $value -eq 0)
        {   
            $psParams.Add($key,$value)                  
        }
    }

    $psParams.Title = $NewTitle

    if( $pscmdlet.ShouldProcess("StatusCake API", "Create StatusCake Public Reporting Page"))
    { 
        $result = New-StatusCakeHelperPublicReportingPage @statusCakeFunctionAuth @psParams
    }
    Return $result
}