<#
.Synopsis
   Sets the StatusCake API Username and API Key
.EXAMPLE
   Set-StatusCakeHelperAPIAuth -Credentials <Credential>
.INPUTS
   Credentials - Credentials object containing the username and API Key
.FUNCTIONALITY
    Sets the StatusCake API Username and API Key
   
#>
function Set-StatusCakeHelperAPIAuth
{
    [CmdletBinding(PositionalBinding=$false)]    
    Param(                            
        [Parameter(Mandatory=$true)]
        [ValidateNotNullOrEmpty()]        
        [System.Management.Automation.PSCredential] $Credentials
    )

    Try 
    {
        New-Variable -Name StatusCakeAPICredentials -Value $Credentials -Scope Global -Force -ErrorAction Stop
    }
    Catch 
    {
        Write-Error $_
        Return $false
    }

    Return $true    
}

