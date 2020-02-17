

<#
.Synopsis
   Removes the specified StatusCake ContactGroup
.PARAMETER APICredential
   Username and APIKey Credentials to access StatusCake API
.PARAMETER ContactID
    ID of the ContactGroup to be removed
.PARAMETER GroupName
    Name of the Contact Group to be removed
.PARAMETER Force
    Delete the contact group if it is in use
.PARAMETER Passthru
    Return the object to be deleted
.EXAMPLE
   Remove-StatusCakeHelperContactGroup -contactID 123456
.OUTPUTS
    Returns the result of the ContactGroup removal as an object
.FUNCTIONALITY
    Removes the StatusCake ContactGroup via it's ContactID or GroupName

#>
function Remove-StatusCakeHelperContactGroup
{
    [CmdletBinding(PositionalBinding=$false,SupportsShouldProcess=$true)]
    Param(
        [ValidateNotNullOrEmpty()]
        [System.Management.Automation.PSCredential] $APICredential = (Get-StatusCakeHelperAPIAuth),

        [Parameter(ParameterSetName = "ContactID")]
        [ValidateNotNullOrEmpty()]
        [int]$ContactID,

        [Parameter(ParameterSetName = "GroupName")]
        [ValidateNotNullOrEmpty()]
        [string]$GroupName,

        [switch]$Force,

        [switch]$PassThru
    )

    $checkParams = @{}
    if($GroupName)
    {
        $checkParams.Add("GroupName",$GroupName)
    }
    else
    {
        $checkParams.Add("ContactID",$ContactID)
    }

    if( $pscmdlet.ShouldProcess("StatusCake API", "Retrieve StatusCake Contact Groups") )
    {
        $contactGroup = Get-StatusCakeHelperContactGroup -APICredential $APICredential @checkParams
        if($contactGroup)
        {
            if($contactGroup.GetType().Name -eq 'Object[]')
            {
                Write-Error "Multiple ContactGroups found with name [$GroupName]. Please remove the ContactGroup by ContactID"
                Return $null
            }
            $ContactID = $contactGroup.ContactID
        }
        else
        {
            Write-Error "Unable to find ContactGroup with name [$GroupName]"
            Return $null
        }
    }


    if( $pscmdlet.ShouldProcess("StatusCake API", "Retrieve StatusCake Tests") )
    {
        $StatusCakeTests = Get-StatusCakeHelperTest -APICredential $APICredential
        $StatusCakeTestsWithContact = $StatusCakeTests | Where-Object {$_.ContactGroup -Contains $ContactID}
        if($StatusCakeTestsWithContact -and !$Force)
        {
            Write-Error "ContactGroup in use by tests [$($StatusCakeTestsWithContact.TestID)]. Please use -Force switch to remove this ContactGroup"
            Return $null
        }
    }

    $requestParams = @{
        uri = "https://app.statuscake.com/API/ContactGroups/Update/?ContactID=$ContactID"
        Headers = @{"Username"=$APICredential.Username;"API"=$APICredential.GetNetworkCredential().password}
        UseBasicParsing = $true
        Method = "Delete"
    }

    if( $pscmdlet.ShouldProcess("ContactID - $ContactID", "Remove StatusCake ContactGroup") )
    {
        $response = Invoke-RestMethod @requestParams
        $requestParams=@{}
        if($response.Success -ne "True")
        {
            Write-Error "$($response.Message) [$($response.Issues)]"
        }
        elseif($PassThru)
        {
            Return $contactGroup
        }
    }
}

