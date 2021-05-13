$file = 'C:\Users\mcho\OneDrive - GRACE WORLDWIDE (AUSTRALIA) PTY LTD\Documents\AOC\Day_8\Day8Input.txt'

$inputs = Get-Content $file 

$accumulator = 0

$instructionEnd = $inputs.Count
$position = 0


while($position -lt $instructionEnd){
    $operation = $inputs[$position].Split(' ')[0]
    $argument = $inputs[$position].Split(' ')[1]
    switch ($operation)
    {
        nop {$position++}
        acc {$position++;$accumulator = $accumulator + $argument}
        jmp {$position = $position + $argument}
    }

    try{
        $inputs[$position] | Add-Member -MemberType NoteProperty -name 'ConsumeStatus' -Value 'Consumed' -ErrorAction Stop
    }catch{
        break
    }
    write-host ($position+1) 'is next position and accumulator is' $accumulator
}
write-host $accumulator -ForegroundColor Green