$file = 'C:\Users\mcho\OneDrive - GRACE WORLDWIDE (AUSTRALIA) PTY LTD\Documents\AOC\Day_16\Day16Test.txt'

$inputs = Import-CSV $file -Delimiter '|' -Header 'TicketInfo'
$limit = $inputs.Count
$rules = $false
$index = 0

$validPositions = New-Object System.Collections.ArrayList 
$validtickets = New-Object System.Collections.ArrayList 
$myTicket = New-Object 'system.collections.generic.dictionary[int32,int32]'
$nearbyTicket = New-Object 'system.collections.generic.dictionary[int32,pscustomobject]'
$ticketFields = [System.Collections.ArrayList]@()

#$inputs
$rules = $false
while($rules -eq $false){
    $range = @()
    if($inputs[$index].TicketInfo -eq 'your ticket:'){break}

    $range1 = ($inputs[$index].TicketInfo.Split(":")[1] -Split " or " )[0] 
    $range2 = ($inputs[$index].TicketInfo.Split(":")[1] -Split " or " )[1]
    $range += ($range1.Split("-")[0]..$range1.Split("-")[1])
    $range += ($range2.Split("-")[0]..$range2.Split("-")[1])

    $ticketNotes = [PSCustomObject]@{
        note = $inputs[$index].TicketInfo.Split(":")[0]
        rules = $range
    }

    [void]$ticketFields.Add($ticketNotes)
    $index++
    
}
$index++
$myTicketIndex = 0
foreach($number in $inputs[$index].TicketInfo.Split(",")){
    $myTicket[$myTicketIndex] = $number/1
    $myTicketIndex++
}
$index = $index +2
$testIndex = $index
$fullTicket = $inputs[$index].TicketInfo.Split(",").Count

while($index -lt $limit){
    $validTicket  = New-Object System.Collections.ArrayList 
    foreach($number in $inputs[$index].TicketInfo.Split(",")){
        
        if(!$ticketFields.rules.Contains($number/1)){
            $answer = $answer + $number/1
        }else{
            #$validTickets += $number/1
            #write-host $number
            [void]$validTicket.Add($number/1)
        }
        if($validTicket.Count -eq $fullTicket){
            [void]$validtickets.Add($validTicket)
        }
    }
    $index++
}
#write-host 'omg'
$ticketIndex = 0
$limit = $validTickets.Count

while($ticketIndex -lt $limit){
    $nearByIndex = 0
    #write-host $validTickets -ForegroundColor Green
    #foreach($number in $inputs[$index].TicketInfo.Split(",")){
    foreach($number in $validTickets[$ticketIndex]){
        if($ticketIndex -eq 0){ 
            $nearByRange = New-Object System.Collections.ArrayList  
            [void]$nearByRange.Add($number/1)
            $nearbyTicket[$nearByIndex] = $nearByRange
        }else{
            #write-host $number -foreground Cyan
            $nearbyTicket[$nearByIndex] += $number/1
        }
        #write-host $number -foreground Cyan
        $nearByIndex++
    }
    $ticketIndex++
}



foreach($field in $ticketFields){
    $position = 0
    $validPos = @()
    while($position -lt $nearbyTicket.Count){
        $match = 0
        foreach($value in $nearbyTicket[$position]){
            if($field.rules -eq $value/1){
                $match++
            }
        }
        #write-host $field.note $match 'Found in' $position -ForegroundColor Cyan
        if($match -eq $nearbyTicket[$position].Count){
            #write-host $field.note 'is' $position
            $validPos += $position
        }
        $position++
    }
    $validPosition = [PSCustomObject]@{       
        field = $field.note
        position = $validPos   
        sort = $validPos.Count
    } 
    [void]$validPositions.Add($validPosition)
}


$HOLYFUCK = @($validPositions)
$processPositions = New-Object System.Collections.ArrayList 
$tempBag = New-Object System.Collections.ArrayList 
$final = New-Object System.Collections.ArrayList 

$processPositions.Clear();$final.Clear();$tempBag.Clear()

$processPositions = $validPositions
$match = 0

while($match -ne 3){
    $tempBag = @($processPositions)
    $processPositions.Clear()
    $tempBag = $tempBag | Sort-Object -Property sort
    write-host $tempBag[0].position $tempBag.field.Count -ForegroundColor Gray
    $count = $tempBag.field.Count
    $x = 0
    $remove = $null

    $tempArray = @()
    while($x -lt $count){
        #write-host $tempBag[$x].field $tempBag[$x].position
        if($tempBag[$x].position.Count -eq 1 ){
            write-host $tempBag[$x].field 'is' $tempBag[$x].position -ForegroundColor Cyan
            $remove = ($tempBag[$x].position)[0]
            $validPosition = [PSCustomObject]@{   
                field = $tempBag[$x].field 
                position = $tempBag[$x].position   } 
            [void]$final.Add($validPosition)
        
        }else{
            if($remove -ne $null){
                write-host 'Removing' $remove 'from ' $tempBag[$x].field  $tempBag[$x].position -ForegroundColor Red
                $validPosition = [PSCustomObject]@{   
                    field = $tempBag[$x].field 
                    position = $tempBag[$x].position -ne $remove 
                    sort =   ($tempBag[$x].position -ne $remove ).Count } 
                    write-host 'Storing' $tempBag[$x].field 'with' ($tempBag[$x].position -ne $remove) -ForegroundColor Magenta
                [void]$processPositions.Add($validPosition)
            }
        }
        $x++
    }

    if(!$tempBag){$match = 3}
    $tempBag = $null
    write-host '------' $match -ForegroundColor Green
}
#write-host '------' $match -ForegroundColor Green
$final