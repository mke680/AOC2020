$file = 'C:\Users\mcho\OneDrive - GRACE WORLDWIDE (AUSTRALIA) PTY LTD\Documents\AOC\Day_13\Day13Test.txt'

$inputs = Get-Content $file 
$startTime = $inputs[0]/1

$busSchedule = $inputs[1] -replace '(x,)'
$validRoutes = new-object System.Collections.ArrayList

foreach($bus in $busSchedule.Split(",")){
    $multiplier = 0
    while( $total -le $startTime ){
        $total = ( $bus/1 * $multiplier )
        #write-host $bus $total
        $multiplier++
    }
    $validRoute = [PSCustomObject]@{
        busID = $bus
        departureTime = $total-$startTime 
    }
    [void]$validRoutes.Add($validRoute)   ### STORE VALUE
    $total = 0
}

$earliestDeparture = ($validRoutes | Measure -Property departureTime -Minimum).Minimum
(($validRoutes | Where-Object {$_.departureTime -eq $earliestDeparture }).busID)/1 *($earliestDeparture)/1