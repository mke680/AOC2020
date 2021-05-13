$file = 'C:\Users\mcho\OneDrive - GRACE WORLDWIDE (AUSTRALIA) PTY LTD\Documents\AOC\Day_12\Day12Test.txt'

$inputs = Get-Content $file 
$xShip = 0
$yShip = 0
$xWaypoint = 10
$yWaypoint = 1

$bearing = 90

foreach($input in $inputs){
    $action = $input[0]
    $value = ($input[1..3] -join '')/1
    switch($action){

        'F' {### Store Relative Location, Move Ship Forward then Move Waypoint relative to Ship
                $xRelative = $xWaypoint - $xShip
                $yRelative = $yWaypoint - $yShip
                $xShip = $xShip + ($xRelative)*$value
                $yShip = $yShip + ($yRelative)*$value
                $xWaypoint = $xShip + $xRelative
                $yWaypoint = $yShip + $yRelative
            }

            ### Move Waypoints N,E,S,W
        'N' {$yWaypoint = $yWaypoint  + $value}
        'E' {$xWaypoint  = $xWaypoint  + $value}
        'S' {$yWaypoint  = $yWaypoint  - $value}
        'W' {$xWaypoint  = $xWaypoint  - $value}

        default {### Determine Rotation Direction, Store Relative Locations, Perform Rotation based on 0,0 then translate location based on Ship
                    if($action -eq 'L'){ $value = $value * -1 } ### Counter Rotation Modifier - Reverse Degrees for CCW
                    $xRelative = $xWaypoint - $xShip
                    $yRelative = $yWaypoint - $yShip
                    $xTemp = ( $xRelative  *[Math]::Cos($value * [math]::pi / 180) ) + ( $yRelative * [Math]::Sin($value *[math]::pi / 180) )
                    $yRelative = -( $xRelative   *[Math]::Sin($value * [math]::pi / 180) ) + ( $yRelative * [Math]::Cos($value *[math]::pi / 180) )
                    $xRelative = $xTemp
                    $xWaypoint = $xShip + $xRelative
                    $yWaypoint = $yShip + $yRelative
                }
    }
    Write-Host 'Ship Position' $xShip ':' $yShip '- Waypoint Position' $xWaypoint ':' $yWaypoint -ForegroundColor Cyan
}
write-host 'Manhattan Distance is' ([Math]::Abs($xShip)+ [Math]::Abs($yShip)) -ForegroundColor Green
