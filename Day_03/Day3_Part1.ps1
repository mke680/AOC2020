#Measure-Command {
 
    $file = 'C:\Users\mcho\OneDrive - GRACE WORLDWIDE (AUSTRALIA) PTY LTD\Documents\AOC\Day_3\Day3Test.txt'

    $inputs = import-csv $file -Header 'Path'

    ## Movement Rate
    $xTarget = 3
    $yTarget = 1

    ## WorkOut Travel Height 
    $travelHeight = [math]::floor(($inputs.Count/$yTarget) + 1)

    foreach($line in $inputs){
        ## Work out Horizontal Travel and Divide by Array
        $travelWidth = [math]::floor(($travelHeight * $xTarget)/($line.Path.ToCharArray()).Count)
        ## Multiply to ensure enough Horizontal Travel
        $line.Path = $line.path * $travelWidth 
    }

    ## X coords
    $x = 0

    ## Tally Collisions
    $collisions = 0
    
    foreach($line in $inputs){
        if($line.Path[$x] -eq '#'){$collisions++;}
        ## Increment Horizontal Position
        $x = $x + $xTarget
    }
    write-host $collisions
    
