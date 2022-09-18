
<#
.SYNOPSIS
    Returns the parameters which can be copied from an object
.DESCRIPTION
    Returns the properties and values of a StatusCake object which be set via the API. Not all parameters returned by StatusCake can by set via the API.
    The properties of the statuscake object are compared against the parameter names and aliases on the supplied function name.
.PARAMETER Name
    The name of the dynamic parameter to create.
.PARAMETER Type
    The variable type of the parameter to be created
.PARAMETER ParameterSetName
    The name of the parameter set that the variable is a part of
.PARAMETER Mandatory
    Specify if the parameter should be made mandatory
.PARAMETER Alias
    The aliases that the parameter should have
.PARAMETER ValidateCount
    The minimum and maximum number of arguments that a parameter can accept
.PARAMETER ValidateLength
    The minimum and maximum number of characters in the parameter argument
.PARAMETER ValidateNotNullOrEmpty
    Validate whether the parameter can contain a null or empty value
.PARAMETER ValidatePattern
    Regular expression that the parameter argument should meet
.PARAMETER ValidateRange
    The minimum and maximum values in the parameter argument
.PARAMETER ValidateScript
    Script to use for validation of the parameter argument
.PARAMETER ValidateSet
    The set of valid values for the parameter argument
.EXAMPLE
    C:\PS>New-StatusCakeHelperDynamicParameter -Name "Port" -Type $( "int" -as [type]) -Mandatory $true -ValidateRange @(1,65535)
    Create a new dynamic parameter called Port which is an integer that is mandatory and has a minimum value of 1 and maximum value of 65535
#>
function New-StatusCakeHelperDynamicParameter
{
    [CmdletBinding(PositionalBinding=$false,SupportsShouldProcess=$true)]
    [OutputType([System.Management.Automation.RuntimeDefinedParameter])]
    Param(
        [Parameter(Mandatory=$True)]
        [ValidateNotNullOrEmpty()]
        [string] $Name,

        [Parameter(Mandatory=$True)]
        [ValidateNotNullOrEmpty()]
        [string] $Type,

        [string] $ParameterSetName,

        [boolean] $Mandatory=$false,

        [string[]] $Alias,

        [Parameter(ParameterSetName = "ValidateCount")]
        [ValidateCount(2,2)]
        [int[]]$ValidateCount,

        [Parameter(ParameterSetName = "ValidateLength")]
        [ValidateCount(2,2)]
        [int[]]$ValidateLength,

        [Parameter(ParameterSetName = "ValidateNotNullOrEmpty")]
        [boolean]$ValidateNotNullOrEmpty,

        [Parameter(ParameterSetName = "ValidatePattern")]
        [ValidateNotNullOrEmpty()]
        [string]$ValidatePattern,

        [Parameter(ParameterSetName = "ValidateRange")]
        [ValidateCount(2,2)]
        [int[]]$ValidateRange,

        [Parameter(ParameterSetName = "ValidateScript")]
        [ValidateNotNullOrEmpty()]
        [scriptblock]$ValidateScript,

        [Parameter(ParameterSetName = "ValidateSet")]
        [ValidateNotNullOrEmpty()]
        [string[]]$ValidateSet

    )

    if( $pscmdlet.ShouldProcess("Parameter Attribute", "Create") )
    {
        $parameterAttributes = New-Object -Type System.Management.Automation.ParameterAttribute
        if($ParameterSetName)
        {
            $parameterAttributes.ParameterSetName = $ParameterSetName
        }
        $parameterAttributes.Mandatory = $Mandatory

        $parameterAttributesCollection = New-Object -Type System.Collections.ObjectModel.Collection[System.Attribute]
    }

    if($Alias)
    {
        $parameterAliasAttribute = New-Object -Type System.Management.Automation.AliasAttribute($Alias)
        $parameterAttributesCollection.Add($parameterAliasAttribute)
    }

    #Add validation objects to parameter attribute collection
    switch($PsCmdlet.ParameterSetName)
    {
        "ValidateCount"{$validationOption = New-Object -Type System.Management.Automation.ValidateCountAttribute($ValidateCount[0],$ValidateCount[1]) ;continue }
        "ValidateLength"{$validationOption = New-Object -Type System.Management.Automation.ValidateLengthAttribute($ValidateLength[0],$ValidateLength[1]) ;continue }
        "ValidatePattern"{$validationOption = New-Object -Type System.Management.Automation.ValidatePatternAttribute($ValidatePattern) ;continue }
        "ValidateRange"{$validationOption = New-Object -Type System.Management.Automation.ValidateRangeAttribute($ValidateRange[0],$ValidateRange[1]) ;continue }
        "ValidateScript"{$validationOption = New-Object -Type System.Management.Automation.ValidateScriptAttribute($ValidateScript) ;continue }
        "ValidateSet"{$validationOption = New-Object -Type System.Management.Automation.ValidateSetAttribute ($ValidateSet) ;continue }
    }
    If($ValidateNotNullOrEmpty){$validationOption = New-Object -Type System.Management.Automation.ValidateNotNullOrEmptyAttribute}
    If($validationOption){$parameterAttributesCollection.Add($validationOption)}

    $parameterAttributesCollection.Add($parameterAttributes)

    if( $pscmdlet.ShouldProcess("Runtime Defined Parameter", "Create") )
    {
        $dynamicParameter = New-Object -Type System.Management.Automation.RuntimeDefinedParameter( `
        $Name,
        ($Type -as [type]),
        $parameterAttributesCollection)
    }

    return $dynamicParameter
}
