$file = 'C:\Users\mcho\OneDrive - GRACE WORLDWIDE (AUSTRALIA) PTY LTD\Documents\AOC\Day_6\Day6Test.txt'

$inputs = Get-Content $file ; $inputs = $inputs + ''

$group = New-Object System.Collections.ArrayList
$groups = New-Object System.Collections.ArrayList
$valid = 0

foreach($input in $inputs){
    
    if($input -eq '' ){ 
        $successfulGroups = $group | Group-Object #Group by Letter To Find Unique 26 answers.
        foreach($success in $successfulGroups){$valid++} #Count Valid Answers
        $groups.Add($valid) #Add Valid Sum to Groups List

        #Reset Stuff
        $valid = 0
        $group = New-Object System.Collections.ArrayList
    }else{
        if($input -match ('[a-z]')){
            foreach($char in $input.ToCharArray()){
                if($char -match ('[a-z]')){
                     $group.Add($char)
                }
            }
        }
    }
}

$sum = ($groups | Measure -Sum).Sum

write-host $sum -ForegroundColor Green