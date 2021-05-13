$file = 'C:\Users\mcho\OneDrive - GRACE WORLDWIDE (AUSTRALIA) PTY LTD\Documents\AOC\Day_9\Day9Input.txt'

$inputs = Get-Content $file 

$counter = 0
$target = 552655238

$startCounter = 0
$match = $false
while(!$match){
    $sum = 0
    $counter = $startCounter
    $preamble.Clear()
    while($sum -le $target){
        [void]$preamble.Add($inputs[$counter])
        $sum = $sum + $inputs[$counter]
        if($sum -eq $target){
            ### Spit Answer and Stop
            write-host $preamble;($preamble |Measure -Maximum).Maximum +($preamble |Measure -Minimum).Minimum
            $match = $true
        }
        $counter++ ### Increment Inner Loop

    }$startCounter++ ### Increment Starting Contiguous Range
}
