$file = 'C:\Users\mcho\OneDrive - GRACE WORLDWIDE (AUSTRALIA) PTY LTD\Documents\AOC\Day_9\Day9Test.txt'

$inputs = Get-Content $file 

$preamble = new-object System.Collections.ArrayList
$tempPreamble = new-object System.Collections.ArrayList

$counter = 0
$preambleLimit = 5 ### Preamble Size

### BUILD Initial Preamble Size Determined by Above Variable
while($counter -lt $preambleLimit){[void]$preamble.Add($inputs[$counter]);$counter++}

$match = $false
while(!$match){
    $found = $false
    $target = $inputs[$counter]
    
    $tempPreamble = @($preamble) ## Temporary Preamble to Allow Overwriting

    foreach($number in $tempPreamble){  ### Increment number
        foreach($multiplier in $tempPreamble){  ### Increment Mutliplier
            if($number -ne $multiplier){             ### Ignore same number
                if($number/1 + $multiplier/1 -eq $target){

                    ### Shift Preamble Array
                    [void]$preamble.Add($inputs[$counter]); 
                    $preamble.RemoveAt(0)

                    ### Reset Counters and Continue Code, 0 Prevents further scanning for rest of loop
                    $counter++
                    $found = $true
                    $target = 0 
                }
            }
        }
    }
    if(!$found){$target;return}  ### Exit Code
}