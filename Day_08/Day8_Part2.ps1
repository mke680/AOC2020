$file = 'C:\Users\mcho\OneDrive - GRACE WORLDWIDE (AUSTRALIA) PTY LTD\Documents\AOC\Day_8\Day8Test.txt'

$inputs = Get-Content $file 

$instructionEnd = $inputs.Count
$position = 0
$accumulator = 0

$positionRecord = New-Object System.Collections.ArrayList

$changed = $false
while( ($position +1) -ne $instructionEnd){

    if($positionRecord -contains $position){ ### RESET EVERYTHING IF LOOPING DETECTED###
        $changed = $false;$position = 0;$accumulator = 0;
        write-host 'Restarting' -ForegroundColor Green;
        $positionRecord = New-Object System.Collections.ArrayList
    }
    ### STORE OPS AND ARGS ###
    $operation = $inputs[$position].Split(' ')[0]
    $argument = $inputs[$position].Split(' ')[1]
    [void]$positionRecord.Add($position) ### STORE POSITION FOR LOOP DETECTION

    ### MESSY LOGIC. IF NEVER CHANGE ATTEMPT CHANGE. IF NOT CHANGE DEFER TO DEFAULT BEHAVIOUR ###
    if(!$changed -and ($inputs[$position].ChangedStatus) -ne 'Changed' -and $operation -ne 'acc'){
     
        $inputs[$position] | Add-Member -MemberType NoteProperty -name 'ChangedStatus' -Value 'Changed'
        write-host 'Replacing' $operation $argument ' ' -ForegroundColor Red -NoNewline

        switch ($operation){
            nop {$position = $position + $argument;$changed = $true;}
            jmp {$position++;$changed = $true;}
        }
    }else{
        switch ($operation){
            nop {$position++}
            acc {$position++;$accumulator = $accumulator + $argument}
            jmp {$position = $position + $argument}
        }
    }write-host $operation $argument ' '-NoNewline -ForegroundColor Cyan
}write-host 'Accumulator is' $accumulator -ForegroundColor Green