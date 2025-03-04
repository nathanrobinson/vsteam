


# Set-VSTeamAPIVersion

## SYNOPSIS

Sets the API versions to support either TFS2017, TFS2018 or VSTS.

## SYNTAX

## DESCRIPTION

Set-VSTeamAPIVersion sets the versions of APIs used.

## EXAMPLES

### -------------------------- EXAMPLE 1 --------------------------

```PowerShell
PS C:\> Set-VSTeamAPIVersion AzD
```

This command sets the API versions to support AzD.

### -------------------------- EXAMPLE 2 --------------------------

```PowerShell
PS C:\> Set-VSTeamAPIVersion -Service Release -Version '5.0'
```

This command sets the version of the Release calls to 5.0.

## PARAMETERS

### -Target

Specifies the version to use. The acceptable values for this parameter are:

- TFS2017
- TFS2018
- VSTS
- AzD

```yaml
Type: String
Required: True
Position: 0
Parameter Sets: Target
Default value: TFS2017
```

### -Service

Specifies the service to change. The acceptable values for this parameter are:

- Build
- Release
- Core
- Git
- DistributedTask
- Tfvc
- Packaging
- MemberEntitlementManagement
- ExtensionsManagement
- ServiceFabricEndpoint

```yaml
Type: String
Required: True
Parameter Sets: Service
```

### -Version

Specifies the version to use.

```yaml
Type: String
Required: True
Parameter Sets: Service
```

### -Force

Forces the command without confirmation

```yaml
Type: SwitchParameter
Required: false
Position: Named
Accept pipeline input: false
Parameter Sets: (All)
```

## INPUTS

## OUTPUTS

## NOTES

## RELATED LINKS

