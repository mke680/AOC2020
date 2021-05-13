$file = 'C:\Users\mcho\OneDrive - GRACE WORLDWIDE (AUSTRALIA) PTY LTD\Documents\AOC\Day_5\Day5Input.txt'

$inputs = Get-Content $file

$boardingPasses = New-Object System.Collections.ArrayList

foreach($pass in $inputs){
    $boardingPass = $pass.toCharArray()


    $charCount = 0
    $row = @(0..127)
    $column = @(0..7)

    foreach($char in $boardingPass){
        if($charCount -le 6){
            if($char -eq 'F'){
                $a1 = [array]::CreateInstance([int32], [Math]::Ceiling(($row.length /2)))
                [array]::Copy($row, 0, $a1, 0, $a1.Length)
                $row = $a1
            }else{
                $a1 = [array]::CreateInstance([int32], [Math]::Ceiling(($row.length /2)))
                $a2 = [array]::CreateInstance([int32], [Math]::Floor(($row.length /2)))
                [array]::Copy($row, $a1.Length, $a1, 0, $a2.Length)
                $row = $a1
            }
        }else{
            if($char -eq 'L'){
                $a1 = [array]::CreateInstance([int32], [Math]::Ceiling(($column.length /2)))
                [array]::Copy($column, 0, $a1, 0, $a1.Length)
                $column = $a1
            }else{
                $a1 = [array]::CreateInstance([int32], [Math]::Ceiling(($column.length /2)))
                $a2 = [array]::CreateInstance([int32], [Math]::Floor(($column.length /2)))
                [array]::Copy($column, $a1.Length, $a1, 0, $a2.Length)
                $column = $a1
            }
        }
        $charCount++
    }
    $seatLocation = New-Object -TypeName psobject 
    $seatID = [convert]::ToInt32($row,10) * 8 + [convert]::ToInt32($column,10)

    $seatLocation | Add-Member -NotePropertyName Row -NotePropertyValue ([convert]::ToInt32($row,10))
    $seatLocation | Add-Member -NotePropertyName Column -NotePropertyValue ([convert]::ToInt32($column,10))
    $seatLocation | Add-Member -NotePropertyName seatID -NotePropertyValue $seatID
    $boardingPasses.Add($seatLocation)
}
$lastPass = ($boardingPasses.seatID  | measure -Maximum).Maximum
$firstPass = ($boardingPasses.seatID  | measure -Minimum).Minimum

while($lastPass -ge $firstPass){
    if($boardingPasses.seatID -match $lastPass){
        write-host $lastPass -ForegroundColor Green
    }else{
        write-host $lastPass -ForegroundColor Red;return
    }
    $lastPass--
}