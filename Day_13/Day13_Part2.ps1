$file = 'C:\Users\mcho\OneDrive - GRACE WORLDWIDE (AUSTRALIA) PTY LTD\Documents\AOC\Day_13\Day13Test.txt'

$inputs = Get-Content $file 

$busSchedule = $inputs[1]
$busList = new-object System.Collections.ArrayList

$limit = ($busList.Count) -1
$x = 0
$oldInt = 1
foreach($bus in $busSchedule.Split(",") ){
    #write-host $bus -foreground Red
    if($bus -eq 'x'){
        $x++
    }else{
        
        ### LCM Calculator
        $gcfInt = @($bus ,$oldInt)
        $a = [int]$gcfInt[0];
        $b = [int]$gcfInt[1];

        while($gcfInt[1] -ne 0)
        {
            $tempB = [int]$gcfInt[1];
            $gcfInt[1] = $gcfInt[0] % $gcfInt[1]
            $gcfInt[0] = $tempB
        }
        $lcm = ($a/$gcfInt[0])*$b


        $busDetails = [PSCustomObject]@{
            bus = [int]$bus
            skip = 1 + [int]$x
            lcm = [int]$bus * $oldInt
        }
        $oldInt = [int]$bus * $oldInt
        $x = 0
        [void]$busList.Add($busDetails)
    }
} 

$limit = ($busList.Count) -1
$multiplier = 1
$arrayCounter = 0
$total = 0
$match = $true

while($match){
    $StartTotal = $busList[$arrayCounter].bus * $multiplier + $busList[$arrayCounter+1].skip
    if(($StartTotal) % $busList[$arrayCounter+1].bus -eq 0){
        write-host 'Start found at' $StartTotal -ForegroundColor Green 
        $multiplier = 1
        $arrayCounter++
        while($match){
        write-host  $busList[$arrayCounter].lcm  ($StartTotal + ($busList[$arrayCounter].lcm * $multiplier))
        $total = $StartTotal + $busList[$arrayCounter].lcm * $multiplier + $busList[$arrayCounter+1].skip
        
        if($total % $buslist[$arrayCounter+1].bus -eq 0){
            $StartTotal = $total
            write-host $StartTotal -ForegroundColor Yellow
            $arrayCounter ++
            if($arrayCounter -eq $limit){ $StartTotal+1-($busList | Measure -Property skip -Sum).Sum;return}
            $multiplier = 1
        }else{
            $multiplier++
        }
        }
    }
    $multiplier++
}