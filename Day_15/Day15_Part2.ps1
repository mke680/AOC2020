$file = 'C:\Users\mcho\OneDrive - GRACE WORLDWIDE (AUSTRALIA) PTY LTD\Documents\AOC\Day_15\Day15Test.txt'

$inputs = Get-Content $file

$inputs = $inputs.Split(",")
$index = $inputs.Count -1
$spoken = New-Object 'system.collections.generic.dictionary[int32,pscustomobject]'
$counter = 0
$turnsApart = 0
$target = 30000000
while($counter -lt $target){
    if($counter -le $index){
    
        ### Run through initially Supplied Numbers
        $currentNumber = $inputs[$counter]/1
        $turnsApart = $counter
    }else{
        
        ### Compare Last Spoken Age
        $justSpoken = ($spoken.$currentNumber)
        if($justSpoken.previous -eq ($counter -1) ){

            ### If First Time 
            $currentNumber = 0
            $turnsApart = ($spoken.$currentNumber).latest

        }else{

            ### If Existing Get Turns Apart
            $currentNumber = $counter - ($justSpoken.previous +1)
            $latest = ($spoken.$currentNumber).latest
            $turnsApart = if($latest -ge 0){$latest}else{$counter}
            
        }
    }

    ### Previous and Latest Steps
    #write-host $currentNumber -ForegroundColor Yellow
    $count = [PSCustomObject]@{
        latest = [int]$counter
        previous = [int]$turnsApart
    }
    $spoken[$currentNumber] = $count
    $counter++
}
write-host $currentNumber -ForegroundColor Cyan