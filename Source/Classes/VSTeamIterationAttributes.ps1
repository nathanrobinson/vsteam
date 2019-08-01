class VSTeamIterationAttributes {
    [string] $FinishDate = $null
    [string] $StartDate	= $null
    [string] $TimeFrame = $null

    VSTeamIterationAttributes (
        [object]$obj
     ) {  
        Write-Verbose $obj
  
        if (Get-Member -inputobject $obj -name "finishDate" -MemberType Properties)
        {
            $this.FinishDate = $obj.finishDate
        }
        
        if (Get-Member -inputobject $obj -name "startDate" -MemberType Properties)
        {
            $this.StartDate = $obj.startDate
        }
        
        if (Get-Member -inputobject $obj -name "timeFrame" -MemberType Properties)
        {
            $this.TimeFrame = $obj.timeFrame
        }
    }

    [object]toJsonObject() {
        $json = @{};
        if ($this.StartDate) {
            $json.Add("startDate", $this.StartDate)
        }
        if ($this.FinishDate) {
            $json.Add("finishDate", $this.FinishDate)
        }
        if ($this.TimeFrame) {
            $json.Add("timeFrame", $this.TimeFrame)
        }
        return $json
    }
}