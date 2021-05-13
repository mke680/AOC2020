$file = 'C:\Users\mcho\OneDrive - GRACE WORLDWIDE (AUSTRALIA) PTY LTD\Documents\AOC\Day_6\Day6Input.txt'

$inputs = Get-Content $file ; $inputs = $inputs + ''

$group = New-Object System.Collections.ArrayList
$groups = New-Object System.Collections.ArrayList
$valid = 0
$members = 0

foreach($input in $inputs){
    if($input -eq '' ){ 
        $allAnswers = $group | Group-Object
        foreach($answer in $allAnswers){
            if($answer.Count -eq $members){
                $valid++
            }
        }
        $groups.Add($valid)
        $valid = 0
        $members = 0
        $group = New-Object System.Collections.ArrayList
    }else{
        $members++
        if($input -match ('[a-z]')){
            foreach($char in $input.ToCharArray()){
                if($char -match ('[a-z]')){
                     $group.add($char)
                }
            }
        }
    }
}

write-host $groups -ForegroundColor Green
$groups | Measure-Object -Sum