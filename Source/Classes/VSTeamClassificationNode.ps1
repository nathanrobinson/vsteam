class VSTeamClassificationNode : VSTeamLeaf {
    [guid]$Identifier
    [string]$StructureType = $null
    [bool]$HasChildren = $false
    [VSTeamClassificationNode[]]$Children = @()
    [string]$Path = $null
    [string]$Url = $null
    [string]$ParentUrl = $null
    [VSTeamIterationAttributes]$Attributes = $null

   VSTeamClassificationNode (
      [object]$obj,
      [string]$Projectname
   ) : base($obj.name, $obj.id, $Projectname) {

      Write-Verbose $obj

      $this.Identifier = $obj.identifier
      $this.Name = $obj.name
      $this.StructureType = $obj.structureType
      $this.HasChildren = $obj.hasChildren

      if (Get-Member -inputobject $obj -name "Path" -MemberType Properties)
      {
         $this.Path = $obj.Path
      }

      $this.Url = $obj.Url
      $this.Id = $obj.id
      if ($this.HasChildren -and (Get-Member -inputobject $obj -name "children" -MemberType Properties))
      {
         foreach ($child in $obj.children)
         {
            $childObject = [VSTeamClassificationNode]::new($child, $ProjectName)
            $this.Children += $childObject
         }
      }

      if ((Get-Member -inputobject $obj -name "_links" -MemberType Properties) -and (Get-Member -inputobject $obj._links -name "parent" -MemberType Properties))
      {
         $this.ParentUrl = $obj._links.parent.href
      }

      if (Get-Member -inputobject $obj -name "attributes" -MemberType Properties)
      {
         $this.Attributes = [VSTeamIterationAttributes]::new($obj.attributes)
      }


      $this._internalObj = $obj

      $this.AddTypeName('Team.ClassificationNode')
   }

   [object]toJsonObject() {
       $json = @{}
       if ($this.Attributes) {
           $json.Add("attributes", $this.Attributes.toJsonObject())
       }
       if ($this.HasChildren) {
           [array]$childObjArr = $this.Children | .{process{ $_.toJsonObject() }}
           $json.Add("children", $childObjArr)
           $json.Add("hasChildren", $true)
       }
       if ($this.Name) {
           $json.Add("name", $this.Name)
       }
       if ($this.StructureType) {
           $json.Add("structureType", $this.StructureType)
       }
       return $json
   }
}