# Get-StatusCakeHelperContactGroup

## SYNOPSIS
Retrieves a StatusCake Contact Group with a specific name or Test ID

## SYNTAX

### all (Default)
```
Get-StatusCakeHelperContactGroup [-APICredential <PSCredential>] [<CommonParameters>]
```

### Group Name
```
Get-StatusCakeHelperContactGroup [-APICredential <PSCredential>] [-GroupName <String>] [<CommonParameters>]
```

### Contact ID
```
Get-StatusCakeHelperContactGroup [-APICredential <PSCredential>] [-ContactID <Int32>] [<CommonParameters>]
```

## DESCRIPTION
Retrieves StatusCake Test via the test name of the test or Test ID.
If no group name or id supplied all contact groups will be returned

## EXAMPLES

### EXAMPLE 1
```
Get-StatusCakeHelperContactGroup
```

Retrieve all contact groups

### EXAMPLE 2
```
Get-StatusCakeHelperContactGroup -ContactID 123456
```

Retrieve contact group with ID 123456

## PARAMETERS

### -APICredential
Credentials to access StatusCake API

```yaml
Type: PSCredential
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: (Get-StatusCakeHelperAPIAuth)
Accept pipeline input: False
Accept wildcard characters: False
```

### -GroupName
Name of the Contact Group

```yaml
Type: String
Parameter Sets: Group Name
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -ContactID
ID of the Contact Group to be copied

```yaml
Type: Int32
Parameter Sets: Contact ID
Aliases:

Required: False
Position: Named
Default value: 0
Accept pipeline input: False
Accept wildcard characters: False
```

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable.
For more information, see about_CommonParameters (http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

### Returns the contact group(s) returning $null if no matching contact groups
## NOTES

## RELATED LINKS
