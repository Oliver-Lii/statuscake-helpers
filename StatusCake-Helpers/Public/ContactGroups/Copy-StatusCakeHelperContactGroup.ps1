
<#
.Synopsis
   Copies the settings of a StatusCake ContactGroup
.PARAMETER Username
   Username associated with the API key
.PARAMETER ApiKey
   APIKey to access the StatusCake API
.PARAMETER GroupName
   Name of the Contact Group to be copied
.PARAMETER ContactID
   ID of the Contact Group to be copied
.PARAMETER NewGroupName
   Name of the Contact Group copy
.EXAMPLE
   Copy-StatusCakeHelperContactGroup -GroupName "Example" -NewGroupName "Example - Copy"
.FUNCTIONALITY
   Creates a copy of a contact group
#>
function Copy-StatusCakeHelperContactGroup
{
    [CmdletBinding(PositionalBinding=$false,SupportsShouldProcess=$true)]
    Param(
        [Parameter(ParameterSetName='CopyByName')]
        [Parameter(ParameterSetName='CopyById')]
		[ValidateNotNullOrEmpty()]
        $Username = (Get-StatusCakeHelperAPIAuth).Username,

        [Parameter(ParameterSetName='CopyByName')]
        [Parameter(ParameterSetName='CopyById')]
        [ValidateNotNullOrEmpty()]
        $ApiKey = (Get-StatusCakeHelperAPIAuth).GetNetworkCredential().password,

        [Parameter(ParameterSetName='CopyById',Mandatory=$true)]
        [ValidatePattern('^\d{1,}$')]
        $ContactID,

        [Parameter(ParameterSetName='CopyByName',Mandatory=$true)]
        [ValidateNotNullOrEmpty()]
        $GroupName,

        [Parameter(ParameterSetName='CopyByName',Mandatory=$true)]
        [Parameter(ParameterSetName='CopyById',Mandatory=$true)]
        [ValidateNotNullOrEmpty()]
        $NewGroupName
    )
    $statusCakeFunctionAuth = @{"Username"=$Username;"Apikey"=$ApiKey}

    if($GroupName)
    {   #If copying by name check if resource with that name exists
        if( $pscmdlet.ShouldProcess("StatusCake API", "Retrieve StatusCake Contact Groups"))
        {
            $exists = Get-StatusCakeHelperContactGroup @statusCakeFunctionAuth -GroupName $GroupName
            if(!$exists)
            {
                Write-Error "No Contact with Specified Name Exists [$GroupName]"
                Return $null
            }
            elseif($exists.GetType().Name -eq 'Object[]')
            {
                Write-Error "Multiple Contacts with the same name [$GroupName] [$($exists.InsertID)]"
                Return $null
            }
        }
    }
    elseif($ContactID)
    {   #If copying by ID verify that a resource with the Id already exists
        if( $pscmdlet.ShouldProcess("StatusCake API", "Retrieve StatusCake Contacts"))
        {
            $exists = Get-StatusCakeHelperContactGroup @statusCakeFunctionAuth -ContactID $ContactID
            if(!$exists)
            {
                Write-Error "No Contact with Specified ID Exists [$ContactID]"
                Return $null
            }
        }
    }

    $psParams = @{}
    $ParameterList = (Get-Command -Name New-StatusCakeHelperContactGroup).Parameters

    $paramsToUse = $exists | Get-Member | Select-Object Name
    $paramsToUse = Compare-Object $paramsToUse.Name @($ParameterList.keys) -IncludeEqual -ExcludeDifferent
    $paramsToUse = $paramsToUse | Select-Object -ExpandProperty InputObject
    $paramsToUse += @("Emails","Mobiles") # Values from response is different from parameters

    foreach ($key in $paramsToUse)
    {
        $value = $exists | Select-Object -ExpandProperty $key
        if($key -eq "Emails" -and $value)
        {
            $psParams.Add("Email",$value)
        }
        elseif($key -eq "Mobiles" -and $value)
        {
            $psParams.Add("Mobile",$value)
        }
        elseif($value -or $value -eq 0)
        {
            $psParams.Add($key,$value)
        }
    }

    $psParams["GroupName"] = $NewGroupName

    if( $pscmdlet.ShouldProcess("StatusCake API", "Create StatusCake Contact Group"))
    {
        $result = New-StatusCakeHelperContactGroup @statusCakeFunctionAuth @psParams
    }
    Return $result
}