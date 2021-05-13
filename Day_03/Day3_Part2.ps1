$file = 'C:\Users\mcho\OneDrive - GRACE WORLDWIDE (AUSTRALIA) PTY LTD\Documents\AOC\Day_3\Day3Test.txt'

$inputs = import-csv $file -Header 'Path'

## Horizontal and Vertical Movement Rate
$paths = @(
       [pscustomobject]@{xTarget=1;yTarget=1}
       [pscustomobject]@{xTarget=3; yTarget=1}
       [pscustomobject]@{xTarget=5; yTarget=1}
       [pscustomobject]@{xTarget=7; yTarget=1}
       [pscustomobject]@{xTarget=1; yTarget=2}
   )

$runningTotal = 1
foreach($path in $paths){

    ## Reset Counters
    $collisions = 0; $x = 0;$y = 0
    $travelHeight = [math]::floor(($inputs.Count/$path.yTarget) + 1) ## WorkOut Travel Height 

    foreach($line in $inputs){
        ## Work out Horizontal Travel and Divide by Array
        $travelWidth = [math]::floor(($travelHeight * $path.xTarget)/($line.Path.ToCharArray()).Count + 1)
        $line.Path = $line.path * $travelWidth ## Multiply to ensure enough Horizontal Travel
    }

    foreach($line in $inputs){

        if($y -eq $path.yTarget){ ## If Vertical Position matches
            $x = $x + $path.xTarget ## Increase Horizontal
            if($line.Path[$x] -eq '#'){$collisions++}
            $y = 1 ## Reset Y Counter
        }else{  ## If Vertical Position doesn't match
            $y = $y + 1
        }
    }
    $runningTotal = $collisions * $runningTotal
}$runningTotal