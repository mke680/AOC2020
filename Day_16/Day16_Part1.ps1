$file = 'C:\Users\mcho\OneDrive - GRACE WORLDWIDE (AUSTRALIA) PTY LTD\Documents\AOC\Day_16\Day16Test.txt'

$inputs = Get-Content $file
$range = @()
$myTickets = @()
$validtickets = New-Object System.Collections.ArrayList 
$limit = $inputs.Count
$rules = $false
$index = 0

while($rules -eq $false){
    if($inputs[$index] -eq ''){
        $rules = $true
    }else{
        $range1 = ($inputs[$index].Split(":")[1] -Split " or " )[0] 
        $range2 = ($inputs[$index].Split(":")[1] -Split " or " )[1]
        $range += ($range1.Split("-")[0]..$range1.Split("-")[1])
        $range += ($range2.Split("-")[0]..$range2.Split("-")[1])
    }
    $index++
}
$index++
foreach($number in $inputs[$index].Split(",")){$myTickets += $number}
$index = $index +3

$answer = 0
$fullTicket = $inputs[$index].Split(",").Count
while($index -lt $limit){
    $validTicket  = New-Object System.Collections.ArrayList 
    foreach($number in $inputs[$index].Split(",")){
        
        if(!$range.Contains($number/1)){
            $answer = $answer + $number/1
        }else{
            #$validTickets += $number/1
            [void]$validTicket.Add($number/1)
        }
        if($validTicket.Count -eq $fullTicket){
            [void]$validtickets.Add($validTicket)
        }
    }
    $index++
}

write-host $answer -ForegroundColor Green