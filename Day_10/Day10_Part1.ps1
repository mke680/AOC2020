$file = 'C:\Users\mcho\OneDrive - GRACE WORLDWIDE (AUSTRALIA) PTY LTD\Documents\AOC\Day_10\Day10Test.txt'

$inputs = Get-Content $file 

$currentJolts = 0
$joltDifference = new-object System.Collections.ArrayList
$builtInCharger = ($inputs | Measure -Maximum).Maximum
write-host 'Target is' $builtInCharger -ForegroundColor Magenta

$joltLimit = 1

while($currentJolts -lt $builtInCharger){
    write-host 'Current Jolts' $currentJolts '' -ForegroundColor Green -NoNewline
    foreach($charger in $inputs){
        $match = $false
        if($charger/1 -gt $currentJolts/1 -and $charger/1 -le ($currentJolts/1 + $joltLimit)){
            write-host $charger 'jolt charger selected. Difference of' ($charger/1 - $currentJolts/1) -ForegroundColor Cyan #-NoNewline

            [void]$joltDifference.Add($charger/1 - $currentJolts)
            $currentJolts = $charger/1
            $match = $true
        }
        if($match){break}
    } if(!$match){$joltLimit++}else{$joltLimit = 1}
    
}
[void]$joltDifference.Add(3)
$3joltDiff = ($joltDifference | Group-Object | Where-Object {$_.Name -eq 3}).Count
$1JoltDiff = ($joltDifference | Group-Object | Where-Object {$_.Name -eq 1}).Count

write-host  ( $3joltDiff * $1JoltDiff ) -ForegroundColor Red