$file = 'C:\Users\mcho\OneDrive - GRACE WORLDWIDE (AUSTRALIA) PTY LTD\Documents\AOC\Day_11\Day11_input.txt'

$inputs = Get-Content $file 
$xLimit = ($inputs[1].ToCharArray().Count)-1
$yLimit = $inputs.Count-1

$nextLayout = @($inputs)


$xPos = 0
$yPos = 0

$positions = @(-1,1,0)

while($xPos -le $xLimit -and $yPos -le $yLimit){
 
    $occupiedSeats = 0
    foreach($xPosition in $positions){
        foreach($yPosition in $positions){
            if(($xPosition -eq 0 -and $yPosition -eq 0)){
                $currentSeat = $inputs[$yPos].ToCharArray()[$xPos]
            }else{
                $y = $yPos+$yPosition
                $x = $xPos+$xPosition
                $checkPosition = try{$inputs[$y].ToCharArray()[$x]}catch{'.'}   
                if($checkPosition -eq '#' -and $y -ge 0 -and $x -ge 0){
                    $occupiedSeats++
                }

            }
        }
    }
    if($currentSeat -eq 'L' -and $occupiedSeats -eq 0){
        $row = $nextLayout[$yPos].ToCharArray()
        $row[$xPos] = '#'
        $nextLayout[$yPos] = ($row -join '').ToString()
    }
    if($currentSeat -eq '#' -and $occupiedSeats -ge 4){
        $row = $nextLayout[$yPos].ToCharArray() 
        $row[$xPos] = 'L'
        $nextLayout[$yPos] = ($row -join '').ToString()
    }

    if($xPos -eq $xLimit){
        if($yPos -eq $yLimit){
            $yPos = 0
            $counter = 0
            $occupied = 0
            foreach($row in $nextLayout){
                if($row -eq $inputs[$counter]){
                    $counter++
                    $occupied = $occupied + ($row.ToCharArray() -eq '#').count
                }
            }
            if($counter -eq $yLimit+1){
                write-host $occupied 'occupied seats.' -ForegroundColor Green;return
            }
            $inputs = @($nextLayout)
            #$inputs
        }else{
            $yPos++
        }
        $xPos = 0
    }else{
        $xPos++
    }
    #$nextLayout
    #write-host $xPos '/' $xLimit ':' $yPos '/' $yLimit -ForegroundColor Red
}
