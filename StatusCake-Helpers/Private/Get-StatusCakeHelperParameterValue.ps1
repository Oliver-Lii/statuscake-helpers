<#
.SYNOPSIS
    Get the all the parameter which have values
.DESCRIPTION
    Combines the default parameter values with the parameters from bound parameters excluding any null parameters
.PARAMETER InvocationInfo
    InvocationInfo object supplied by the calling function
.PARAMETER BoundParameters
    The $PSBoundParameters hashtable supplied by the calling function
.EXAMPLE
    C:\PS>$MyInvocation | Get-StatusCakeHelperParameterValue -BoundParameters $PSBoundParameters
    Get all the parameters which values from $MyInvocation and $PSBoundParameter objects
.OUTPUTS
    Returns a hashtable with all parameters which are bound or have non-null defaults
#>
Function Get-StatusCakeHelperParameterValue
{
    [CmdletBinding()]
    [OutputType([hashtable])]
    param(
        [Parameter(Mandatory=$True,ValueFromPipeline=$True)]
        [System.Management.Automation.InvocationInfo]$InvocationInfo,

        [Parameter(Mandatory=$True)]
        [hashtable]$BoundParameters
    )

    $allParameterValues = @{}
    foreach($parameter in $InvocationInfo.MyCommand.Parameters.GetEnumerator())
    {
        $value = Get-Variable -Name $parameter.Key -ValueOnly -ErrorAction Ignore
        # Check if variable value is not null
        if($null -ne $value)
        {
            # Check if variable is not a null type
            if($value -ne ($null -as $parameter.Value.ParameterType))
            {
                $allParameterValues[$parameter.Key] = $value
            }
        }
        if($BoundParameters.ContainsKey($parameter.Key))
        {
            $allParameterValues[$parameter.Key] = $BoundParameters[$parameter.Key]
        }
    }
    return $allParameterValues
}