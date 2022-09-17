
<#
.SYNOPSIS
    Resumes a StatusCake test check
.DESCRIPTION
    Resumes a test
.PARAMETER APICredential
    Credentials to access StatusCake API
.PARAMETER ID
    ID of the Test to be removed from StatusCake
.PARAMETER Name
    Name of the Test to be removed from StatusCake
.EXAMPLE
    C:\PS>Resume-StatusCakeHelperUptimeTest -Name "Example"
    Unpause the test called "Example"
#>
function Resume-StatusCakeHelperUptimeTest
{
    [CmdletBinding(PositionalBinding=$false,SupportsShouldProcess=$true)]
    Param(
        [ValidateNotNullOrEmpty()]
        [System.Management.Automation.PSCredential] $APICredential = (Get-StatusCakeHelperAPIAuth),

        [Parameter(ParameterSetName='ResumeById',Mandatory=$true)]
        [int]$ID,

        [Parameter(ParameterSetName='ResumeByName',Mandatory=$true)]
        [string]$Name
    )

    if($Name)
    {   #If resuming by name check if resource with that name exists
        if( $pscmdlet.ShouldProcess("StatusCake API", "Retrieve StatusCake Tests"))
        {
            $uptimeTest = Get-StatusCakeHelperUptimeTest -APICredential $APICredential -Name $Name
            if(!$uptimeTest)
            {
                Write-Error "No Test with Specified Name Exists [$Name]"
                Return $null
            }
            elseif($uptimeTest.GetType().Name -eq 'Object[]')
            {
                Write-Error "Multiple Tests with the same name [$Name] [$($uptimeTest.ID)]"
                Return $null
            }
            $ID = $uptimeTest.ID
        }
    }
    elseif($ID)
    {   #If resuming by ID verify that a resource with the Id already exists
        if( $pscmdlet.ShouldProcess("StatusCake API", "Retrieve StatusCake Tests"))
        {
            $uptimeTest = Get-StatusCakeHelperUptimeTest -APICredential $APICredential -ID $ID
            if(!$uptimeTest)
            {
                Write-Error "No Test with Specified ID Exists [$ID]"
                Return $null
            }
            $ID = $uptimeTest.ID
        }
    }

    if( $pscmdlet.ShouldProcess("StatusCake API", "Resume StatusCake Test"))
    {
        $result = Update-StatusCakeHelperUptimeTest -APICredential $APICredential -ID $ID -Paused $false
    }
    Return $result
}