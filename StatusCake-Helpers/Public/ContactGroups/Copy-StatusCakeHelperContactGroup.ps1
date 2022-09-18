
<#
.SYNOPSIS
    Copies the settings of a StatusCake ContactGroup
.DESCRIPTION
    Creates a copy of a contact group which can be specified by name or id. The new name of the contact group must not already exist for the command to be successful.
.PARAMETER APICredential
    Credentials to access StatusCake API
.PARAMETER Name
    Name of the Contact Group to be copied
.PARAMETER ID
    ID of the Contact Group to be copied
.PARAMETER NewName
    Name of the copy of the Contact Group
.EXAMPLE
    C:\PS> Copy-StatusCakeHelperContactGroup -Name "Example" -NewName "Example - Copy"
    Create a copy of a contact group called "Example" with name "Example - Copy"
.LINK
    https://github.com/Oliver-Lii/statuscake-helpers/blob/master/Documentation/ContactGroups/Copy-StatusCakeHelperContactGroup.md
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
        [int]$ID,

        [Parameter(ParameterSetName='CopyByName',Mandatory=$true)]
        [ValidateNotNullOrEmpty()]
        [string]$Name,

        [Parameter(ParameterSetName='CopyByName',Mandatory=$true)]
        [Parameter(ParameterSetName='CopyById',Mandatory=$true)]
        [ValidateNotNullOrEmpty()]
        [string]$NewName
    )

    if($Name)
    {   #If copying by name check if resource with that name exists
        if( $pscmdlet.ShouldProcess("StatusCake API", "Retrieve StatusCake Contact Groups"))
        {
            $statusCakeItem = Get-StatusCakeHelperContactGroup -APICredential $APICredential -Name $Name
            if(!$statusCakeItem)
            {
                Write-Error "No Contact with Specified Name Exists [$Name]"
                Return $null
            }
            elseif($statusCakeItem.GetType().Name -eq 'Object[]')
            {
                Write-Error "Multiple Contacts with the same name [$Name] [$($statusCakeItem.ID)]"
                Return $null
            }
        }
    }
    elseif($ID)
    {   #If copying by ID verify that a resource with the Id already exists
        if( $pscmdlet.ShouldProcess("StatusCake API", "Retrieve StatusCake Contacts"))
        {
            $statusCakeItem = Get-StatusCakeHelperContactGroup -APICredential $APICredential -ID $ID
            if(!$statusCakeItem)
            {
                Write-Error "No Contact with Specified ID Exists [$ID]"
                Return $null
            }
        }
    }

    $psParams = @{}
    $psParams = $statusCakeItem | Get-StatusCakeHelperCopyParameter -FunctionName "New-StatusCakeHelperContactGroup"

    Write-Verbose "$($psParams.Keys -join ",")"

    $psParams.Name = $NewName

    if( $pscmdlet.ShouldProcess("StatusCake API", "Create StatusCake Contact Group"))
    {
        $result = New-StatusCakeHelperContactGroup -APICredential $APICredential @psParams
    }
    Return $result
}