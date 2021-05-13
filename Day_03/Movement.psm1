    
    
    $file = 'C:\Users\mcho\OneDrive - GRACE WORLDWIDE (AUSTRALIA) PTY LTD\Documents\AOC\Day_3\Day3Test.txt'

    $inputs = import-csv $file -Header 'Path'

    foreach($line in $inputs){
        $line.Path = $line.path + $Line.Path + $line.path + $Line.Path+$line.Path + $line.path + $Line.Path + $line.path + $Line.Path + $line.path + $Line.Path + $line.path + $Line.Path+$line.Path + $line.path + $Line.Path + $line.path + $Line.Path + $line.path + $Line.Path + $line.path + $Line.Path+$line.Path + $line.path + $Line.Path + $line.path + $Line.Path+$line.path + $Line.Path + $line.path + $Line.Path+$line.Path + $line.path + $Line.Path + $line.path + $Line.Path+$line.path + $Line.Path + $line.path + $Line.Path+$line.Path + $line.path + $Line.Path + $line.path + $Line.Path+$line.path + $Line.Path + $line.path + $Line.Path+$line.Path + $line.path + $Line.Path + $line.path + $Line.Path+$line.path + $Line.Path + $line.path + $Line.Path+$line.Path + $line.path + $Line.Path + $line.path + $Line.Path+$line.path + $Line.Path + $line.path + $Line.Path+$line.Path + $line.path + $Line.Path + $line.path + $Line.Path+$line.path + $Line.Path + $line.path + $Line.Path+$line.Path + $line.path + $Line.Path + $line.path + $Line.Path
    }

    $xTarget = 1
    $yTarget = 2
     $x = 0
    $y = 0
    $currentLevel =0
    $collisions = 0

    foreach($line in $inputs){
    
        if($y -eq $yTarget){
            $x = $x + $xTarget
            write-host $x ':' $currentLevel
            if($line.Path[$x] -eq '#'){$collisions++;write-host $x ':' $currentLevel -ForegroundColor Red}
            $y = 1
        }else{
            $y = $y + 1
        }
      $currentLevel++

    }
    write-host $collisions