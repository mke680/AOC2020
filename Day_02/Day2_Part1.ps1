#Measure-Command {
 
    $file = 'C:\Users\mcho\OneDrive - GRACE WORLDWIDE (AUSTRALIA) PTY LTD\Documents\AOC\Day_2\Day2Input.txt'

    $inputs = import-csv $file -Header 'PasswordPolicy','Requirement','Password' -Delimiter ' '
    $valid = 0

    ForEach($input in $inputs){
        $policy = $input.PasswordPolicy.Split("-")
        $min = $policy[0]
        $max = $policy[1]
        $requirement = $input.Requirement -replace ':'
        $charCount = ($input.Password.ToCharArray() | Where-Object {$_ -eq $requirement} | Measure-Object).Count
        if($charCount -ge $min -and $charCount -le $max){ $valid++}
    }
    $valid
 #   }