
<#
.SYNOPSIS
    Clears a property of a StatusCake contact group
.DESCRIPTION
    Clears the property of a StatusCake contact group using the supplied parameters.
.PARAMETER APICredential
    Credentials to access StatusCake API
.PARAMETER ID
    ID of the contact group to clear the property on
.PARAMETER Name
    Name of the Contact Group on which to clear the property
.PARAMETER Email
    Flag to clear all email addresses from contact group
.PARAMETER PingURL
    Flag to clear ping URL from contact group
.PARAMETER Mobile
    Flag to clear all mobile numbers from contact group
.PARAMETER Integration
    Flag to clear all integration IDs from contact group
.EXAMPLE
    C:\PS>Clear-StatusCakeHelperContactGroup -Name "Example" -email
    Set the contact group name "Example" with email address "test@example.com"
.LINK
    https://github.com/Oliver-Lii/statuscake-helpers/blob/master/Documentation/ContactGroups/Clear-StatusCakeHelperContactGroup.md
#>
function Clear-StatusCakeHelperContactGroup
{
    [CmdletBinding(PositionalBinding=$false,SupportsShouldProcess=$true)]
    Param(
        [ValidateNotNullOrEmpty()]
        [System.Management.Automation.PSCredential] $APICredential = (Get-StatusCakeHelperAPIAuth),

        [Parameter(ParameterSetName='ByID')]
        [ValidateNotNullOrEmpty()]
        [int]$ID,

        [Parameter(ParameterSetName='ByName')]
        [ValidateNotNullOrEmpty()]
        [string]$Name,

        [Alias("email_addresses")]
        [switch]$Email,

        [switch]$PingURL,

        [Alias("mobile_numbers")]
        [switch]$Mobile,

        [Alias("integrations")]
        [switch]$Integration
    )

    if($ByName -and $Name)
    {
        if( $pscmdlet.ShouldProcess("StatusCake API", "Retrieve StatusCake ContactGroups"))
        {
            $contactGroupCheck = Get-StatusCakeHelperContactGroup -APICredential $APICredential -Name $Name
            if(!$contactGroupCheck)
            {
                Write-Error "Unable to find Contact Group with specified name [$Name]"
                Return $null
            }
            elseif($contactGroupCheck.GetType().Name -eq 'Object[]')
            {
                Write-Error "Multiple Contact Groups with the same name [$Name]"
                Return $null
            }
            $ContactID = $contactGroupCheck.ID
        }
    }

    $exclude=@("ByName")
    $clear = @()

    foreach($parameter in $PSBoundParameters.GetEnumerator())
    {
        $variableValue = Get-Variable -Name $parameter.Key -ValueOnly
        if($variableValue.GetType().Name-eq "SwitchParameter" -and $variableValue -eq $true)
        {
            $clear += $parameter.Key
        }
    }
    $allParameterValues = $MyInvocation | Get-StatusCakeHelperParameterValue -BoundParameters $PSBoundParameters
    $statusCakeAPIParams = $allParameterValues | Get-StatusCakeHelperAPIParameter -InvocationInfo $MyInvocation -Exclude $exclude -Clear $clear
    $statusCakeAPIParams = $statusCakeAPIParams | ConvertTo-StatusCakeHelperAPIParameter

    $requestParams = @{
        uri = "https://api.statuscake.com/v1/contact-groups/$ContactID"
        Headers = @{"Authorization"="Bearer $($APICredential.GetNetworkCredential().password)"}
        UseBasicParsing = $true
        method = "Put"
        ContentType = "application/x-www-form-urlencoded"
        body = $statusCakeAPIParams
    }

    if( $pscmdlet.ShouldProcess("StatusCake API", "Update StatusCake ContactGroup") )
    {
        try{
            Invoke-RestMethod @requestParams
        }
        catch [System.Net.WebException] {
            Write-Verbose "A web exception was caught: [$($_.Exception.Message)] / [$($_.Exception.Response.StatusCode)] / [$($_.Exception.Response.StatusDescription)]"
        }

    }

}