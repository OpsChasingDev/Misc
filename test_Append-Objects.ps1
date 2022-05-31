function Test-1 {
    $Collection = @()
    for ($i = 0; $i -lt 3; $i++) {
        $obj = New-Object -TypeName psobject
        $obj | Add-Member -MemberType NoteProperty -Name 'Prop1' -Value '1'
        $obj | Add-Member -MemberType NoteProperty -Name 'Prop2' -Value '2'        
        $obj | Add-Member -MemberType ScriptProperty -Name 'Prop3' -Value {$this.Prop2 + 'ok'}

        $Collection += $obj
    }
    #Write-Output $Collection
    
    $Collection2 = @()
    <#for ($j = 0; $j -lt $Collection.Count; $j++) {
        $Collection[$j] | Add-Member -MemberType ScriptProperty -Name 'Prop3' -Value {'3' + $j}
    }#>
    foreach ($c in $Collection) {
        $c | Add-Member -MemberType ScriptProperty -Name 'Prop4' -Value {$c.Prop1}
    }
    Write-Output $Collection
}