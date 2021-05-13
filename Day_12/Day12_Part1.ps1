$file = 'C:\Users\mcho\OneDrive - GRACE WORLDWIDE (AUSTRALIA) PTY LTD\Documents\AOC\Day_12\Day12Test.txt'

$inputs = Get-Content $file 
$x = 0
$y = 0
$bearing = 90

foreach($input in $inputs){
    $action = $input[0]
    $value = ($input[1..3] -join '')/1
    write-host 'Move' $value 'units in' $action 'direction' -ForegroundColor Gray
    switch($action){

        'F' {switch($bearing){
                0 {$y = $y + $value}
                90 {$x = $x + $value}
                180 {$y = $y - $value}
                270 {$x = $x - $value}
            }}
    
        'R' {$bearing = (($bearing + $value) % 360 + 360) % 360}
        'L' {$bearing = (($bearing - $value) % 360 + 360) % 360}
        'N' {$y = $y + $value}
        'E' {$x = $x + $value}
        'S' {$y = $y - $value}
        'W' {$x = $x - $value}
    }
}
write-host 'Manhattan Distance is' ([Math]::Abs($x)+ [Math]::Abs($y)) -ForegroundColor Green
