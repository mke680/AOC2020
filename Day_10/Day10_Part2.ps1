$file = 'C:\Users\mcho\OneDrive - GRACE WORLDWIDE (AUSTRALIA) PTY LTD\Documents\AOC\Day_10\Day10Input.txt'

$inputs = Get-Content $file 

$currentJolts = 0
$currentTrie = [System.Collections.ArrayList]@()
$nextTrie = [System.Collections.ArrayList]@()
$variances = 0

### End Stops
$builtInCharger = ($inputs | Measure -Maximum).Maximum
$joltLimit = 3

## Starting Data
$valueDetails = [PSCustomObject]@{
    jolt = 0
    kurrent = 1
}
[void]$currentTrie.Add($valueDetails)

### Loop whilst End not reached
while($currentTrie){
    foreach($trie in $currentTrie){     ### Every Branch
        foreach($charger in $inputs){   ### Every Match in Selected Branch
            ### Match Condition
            if($charger/1 -gt $trie.jolt/1 -and $charger/1 -le ($trie.jolt/1 + $joltLimit)){

                ### CUSTOM OBJECT TO HOLD Voltage and "Repetitions" i.e. kurrent
                $valueDetails = [PSCustomObject]@{
                    jolt = $charger/1
                    kurrent = ($trie.kurrent)/1
                }
                [void]$nextTrie.Add($valueDetails)   ### STORE VALUE
            }
        }
    }
        
    ### OPTIMIZATION GROUP SAME NUMBERS :) :)
    $nextTrie = $nextTrie | Group-Object jolt | %{
        [PSCustomObject]@{
            jolt = $_.Name
            kurrent = ($_.Group | Measure-Object kurrent -Sum).Sum
        }
    }

    ### COLLECT/REMOVE VARIENCES THAT HAVE HIT THE END AND RESTART CACHE
    $variances = $variances + ($nextTrie | Where-Object {$_.jolt -eq $builtInCharger}).kurrent
    $currentTrie = @($nextTrie | Where-Object {$_.jolt -ne $builtInCharger})
    $nextTrie = [System.Collections.ArrayList]@()

}
write-host 'Max Variances equal' $variances 