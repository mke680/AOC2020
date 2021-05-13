$file = 'C:\Users\mcho\OneDrive - GRACE WORLDWIDE (AUSTRALIA) PTY LTD\Documents\AOC\Day_11\Day11_Test.txt'

$inputs = Get-Content $file 
$xLimit = ($inputs[1].ToCharArray().Count)-1
$yLimit = $inputs.Count-1

$nextLayout = @($inputs)

$xPos = 0
$yPos = 0

while($xPos -le $xLimit -and $yPos -le $yLimit){
 
    $occupiedSeats = 0

    foreach($xPosition in -1,1,0){
        foreach($yPosition in -1,1,0){
            $multiplier = 1  ### Muliplier to move multiple steps

            ### Get Current Seat and Process If not 0,0
            $currentSeat = $inputs[$yPos].ToCharArray()[$xPos]
            if(!($xPosition -eq 0 -and $yPosition -eq 0)){ 
                if($currentSeat -ne '.'){
                    while($multiplier -lt $xLimit){

                    ### Attempt to Get position
                        $y = $yPos +$yPosition*$multiplier
                        $x = $xPos +$xPosition*$multiplier
                        $checkPosition = try{$inputs[$y].ToCharArray()[$x]}catch{'.'} 

                        ### Check if within Parameters *Seat spotted* or *Out of Array*
                        if(($checkPosition -eq '#' -or $checkPosition -eq 'L') -and $y -ge 0 -and $x -ge 0 -and $y -le $yLimit -and $x -le $xLimit){

                            ### Stop if Empty or Filled Seat encountered or Increase Looking distance.
                            if($checkPosition -eq '#'){$occupiedSeats++}
                            $multiplier = $xLimit + 1
                        }else{
                            if($y -lt 0 -or $x -lt 0){
                                $multiplier = $xLimit + 1
                            }else{
                                $multiplier++  
                            }
                        }
                    }
                }else{ 
                    continue ### (FLOOR) Move to Next Position
                }
            }
        }
    }
    
    ### Rebuild Seating Array Logic
    if($currentSeat -eq 'L' -and $occupiedSeats -eq 0){
        $row = $nextLayout[$yPos].ToCharArray()
        $row[$xPos] = '#'
        $nextLayout[$yPos] = ($row -join '').ToString()
    }
    if($currentSeat -eq '#' -and $occupiedSeats -ge 5){
        $row = $nextLayout[$yPos].ToCharArray() 
        $row[$xPos] = 'L'
        $nextLayout[$yPos] = ($row -join '').ToString()
    }

    ### Recurse and Exit Logic
    if($xPos -eq $xLimit){
        if($yPos -eq $yLimit){
            $yPos = 0

            ### Exit Logic and Occupied Seat Summary
            $counter = 0
            $occupied = 0
            foreach($row in $nextLayout){
                if($row -eq $inputs[$counter]){
                    $counter++
                    $occupied = $occupied + ($row.ToCharArray() -eq '#').count
                }
            }
            #$nextLayout
            if($counter -eq $yLimit+1){
                write-host $occupied 'occupied seats.' -ForegroundColor Green;return
            }
            $inputs = @($nextLayout)
            write-host 'Completed Round' -ForegroundColor Cyan
            #$inputs
        }else{
            $yPos++
        }
        $xPos = 0
    }else{
        $xPos++
    }
}
