
<#
.SYNOPSIS
    Copies the settings of a StatusCake ContactGroup
.DESCRIPTION
    Creates a copy of a contact group which can be specified by name or id. The new name of the contact group must not already exist for the command to be successful
.PARAMETER APICredential
    Credentials to access StatusCake API
.PARAMETER GroupName
    Name of the Contact Group to be copied
.PARAMETER ContactID
    ID of the Contact Group to be copied
.PARAMETER NewGroupName
    Name of the Contact Group copy
.EXAMPLE
    C:\PS> Copy-StatusCakeHelperContactGroup -GroupName "Example" -NewGroupName "Example - Copy"
    Create a copy of a contact group called "Example" with name "Example - Copy"
.OUTPUTS

#>
function Copy-StatusCakeHelperContactGroup
{
    [CmdletBinding(PositionalBinding=$false,SupportsShouldProcess=$true)]
    Param(
        [Parameter(ParameterSetName='CopyByName')]
        [Parameter(ParameterSetName='CopyById')]
        [ValidateNotNullOrEmpty()]
        [System.Management.Automation.PSCredential] $APICredential = (Get-StatusCakeHelperAPIAuth),

        [Parameter(ParameterSetName='CopyById',Mandatory=$true)]
        [int]$ContactID,

        [Parameter(ParameterSetName='CopyByName',Mandatory=$true)]
        [ValidateNotNullOrEmpty()]
        [string]$GroupName,

        [Parameter(ParameterSetName='CopyByName',Mandatory=$true)]
        [Parameter(ParameterSetName='CopyById',Mandatory=$true)]
        [ValidateNotNullOrEmpty()]
        [string]$NewGroupName
    )

    if($GroupName)
    {   #If copying by name check if resource with that name exists
        if( $pscmdlet.ShouldProcess("StatusCake API", "Retrieve StatusCake Contact Groups"))
        {
            $statusCakeItem = Get-StatusCakeHelperContactGroup -APICredential $APICredential -GroupName $GroupName
            if(!$statusCakeItem)
            {
                Write-Error "No Contact with Specified Name Exists [$GroupName]"
                Return $null
            }
            elseif($statusCakeItem.GetType().Name -eq 'Object[]')
            {
                Write-Error "Multiple Contacts with the same name [$GroupName] [$($statusCakeItem.InsertID)]"
                Return $null
            }
        }
    }
    elseif($ContactID)
    {   #If copying by ID verify that a resource with the Id already exists
        if( $pscmdlet.ShouldProcess("StatusCake API", "Retrieve StatusCake Contacts"))
        {
            $statusCakeItem = Get-StatusCakeHelperContactGroup -APICredential $APICredential -ContactID $ContactID
            if(!$statusCakeItem)
            {
                Write-Error "No Contact with Specified ID Exists [$ContactID]"
                Return $null
            }
        }
    }

    $psParams = @{}
    $ParameterList = (Get-Command -Name New-StatusCakeHelperContactGroup).Parameters

    $paramsToUse = $statusCakeItem | Get-Member | Select-Object Name
    $paramsToUse = Compare-Object $paramsToUse.Name @($ParameterList.keys) -IncludeEqual -ExcludeDifferent
    $paramsToUse = $paramsToUse | Select-Object -ExpandProperty InputObject
    $paramsToUse += @("Emails","Mobiles") # Values from response is different from parameters

    foreach ($key in $paramsToUse)
    {
        $value = $statusCakeItem | Select-Object -ExpandProperty $key
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
        $result = New-StatusCakeHelperContactGroup -APICredential $APICredential @psParams
    }
    Return $result
}