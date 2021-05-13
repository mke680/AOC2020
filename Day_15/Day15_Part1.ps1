$file = 'C:\Users\mcho\OneDrive - GRACE WORLDWIDE (AUSTRALIA) PTY LTD\Documents\AOC\Day_15\Day15Test.txt'

$inputs = Get-Content $file

$inputs = $inputs.Split(",")
$index = $inputs.Count -1
$spoken = new-object System.Collections.ArrayList
$counter = 0

while($counter -le 2020){
    if($counter -le $index){
        $currentNumber = $inputs[$counter]/1
    }else{
        if(($spoken | Where-Object {$_ -eq $currentNumber}).Count -eq 1){
            $currentNumber = 0
        }else{
            $spoken.RemoveAt($counter-1)
            $turnsApart = $spoken.LastIndexOf($currentNumber) + 1
            #write-host ($counter ) $turnsApart ' ' $spoken -NoNewline -ForegroundColor Red
            [void]$spoken.Add($currentNumber)
            $currentNumber = $counter - $turnsApart
            #write-host $spoken -ForegroundColor Green
        }
    }
    write-host $currentNumber -ForegroundColor Cyan
    [void]$spoken.Add($currentNumber)
    $counter++
}