function Add-VSTeamClassificationNode {
    [CmdletBinding(DefaultParameterSetName = 'ByPath')]
    param(
       [ValidateSet("areas", "iterations")]
       [Parameter(Mandatory = $true, ParameterSetName="ByPath")]
       [string] $StructureGroup,
 
       [Parameter(Mandatory = $false, ParameterSetName="ByPath")]
       [string] $Path,

       [Parameter(Mandatory = $true, ParameterSetName="ByPath")]
       [VSTeamClassificationNode] $ClassificationNode,
 
       [Parameter(Mandatory = $false, ParameterSetName="ByPath")]
       [Int32] $Depth
    )
 
    DynamicParam {
       _buildProjectNameDynamicParam -Mandatory $true
    }
 
    process {
        # Bind the parameter to a friendly variable
        $ProjectName = $PSBoundParameters["ProjectName"]
        $id = $StructureGroup

        $Path = [uri]::UnescapeDataString($Path)

        if ($Path)
        {
            $Path = [uri]::EscapeUriString($Path)
            $Path = $Path.TrimStart("/")
            $id += "/$Path"
        }

        if (-not $Depth -or $Depth -lt 2) {
            $Depth = 10
        }
        
        $body = $ClassificationNode.toJsonObject() | ConvertTo-Json -Depth $Depth;

        Write-Verbose $body

        # Call the REST API
        $resp = _callAPI -ProjectName $ProjectName -Area 'wit' -Resource "classificationnodes" -id $id `
                -Method Post -ContentType 'application/json' -Body $body -Version $([VSTeamVersions]::Core)

        if ([bool]($resp.PSobject.Properties.name -match "value"))
        {
            try {
                $objs = @()

                foreach ($item in $resp.value) {
                $objs += [VSTeamClassificationNode]::new($item, $ProjectName)
                }

                Write-Output $objs
            }
            catch {
                # I catch because using -ErrorAction Stop on the Invoke-RestMethod
                # was still running the foreach after and reporting useless errors.
                # This casuses the first error to terminate this execution.
                _handleException $_
            }
        } else {
            # Storing the object before you return it cleaned up the pipeline.
            # When I just write the object from the constructor each property
            # seemed to be written
            $classificationNode = [VSTeamClassificationNode]::new($resp, $ProjectName)

            Write-Output $classificationNode
        }
    }
 }