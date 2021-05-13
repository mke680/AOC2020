#Measure-Command {
 
    $file = 'C:\Users\mcho\OneDrive - GRACE WORLDWIDE (AUSTRALIA) PTY LTD\Documents\AOC\Day_2\Day2Input.txt'

    $inputs = import-csv $file -Header 'PasswordPolicy','Requirement','Password' -Delimiter ' '
    $valid = 0

    ForEach($input in $inputs){
    #$input
        $policy = $input.PasswordPolicy.Split("-")
        $min = $policy[0]/1 - 1
        $max = $policy[1]/1 - 1
        $requirement = $input.Requirement -replace ':'
        $charCount = $input.Password.ToCharArray()
        if( ( $charCount[$min] -eq $requirement -or $charCount[$max] -eq $requirement ) -and $charCount[$min] -ne $charCount[$max] ) {$valid++}
    }
    $valid
 #   }