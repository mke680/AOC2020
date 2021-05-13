#Measure-Command {
 
    $file = 'C:\Users\mcho\OneDrive - GRACE WORLDWIDE (AUSTRALIA) PTY LTD\Documents\AOC\Day_4\Day4Input.txt'

    $inputs = Get-Content $file ; $inputs = $inputs + ''

    $passport = New-Object -TypeName psobject 
    $passports = New-Object System.Collections.ArrayList
    $passportData = ''
    
    $lineCount = 0
    $passportCount = 0
    $valid = 0
    foreach($input in $inputs){
        if($input -eq '' ){ 

            $properties = 0
            $passportData.Trim().Split(' ') | ForEach{
                $kvp = $_.Split(':')

                if($kvp[0] -ne 'cid'){
                    if($kvp[0] -eq 'byr' -and $kvp[1] -match '^((19)([2-9][0-9]))|[2][0][0][0-2]$' ){Add-Member -InputObject $passport -Name $kvp[0] -Value $kvp[1] -MemberType NoteProperty;$properties ++}
                    if($kvp[0] -eq 'iyr' -and $kvp[1] -match '^((20)([1][0-9]|(20)))$' ){Add-Member -InputObject $passport -Name $kvp[0] -Value $kvp[1] -MemberType NoteProperty;$properties ++}
                    if($kvp[0] -eq 'eyr' -and $kvp[1] -match '^((20)([2][0-9]|(30)))$' ){Add-Member -InputObject $passport -Name $kvp[0] -Value $kvp[1] -MemberType NoteProperty;$properties ++}
                    if($kvp[0] -eq 'hgt' -and $kvp[1] -match '^([1](([5-8][0-9])|[9][0-3])[c][m]|(([6][0-9])|([7][0-6])|([5][9]))[i][n])$'){
                        Add-Member -InputObject $passport -Name $kvp[0] -Value $kvp[1] -MemberType NoteProperty;$properties ++
                    }
                    if($kvp[0] -eq 'hcl' -and $kvp[1] -match '^([#]([a-f]|[0-9]){6})$'){
                        Add-Member -InputObject $passport -Name $kvp[0] -Value $kvp[1] -MemberType NoteProperty;$properties ++
                    }
                    if($kvp[0] -eq 'ecl' -and $kvp[1] -match '^((amb)|(blu)|(brn)|(gry)|(grn)|(hzl)|(oth))$' ){Add-Member -InputObject $passport -Name $kvp[0] -Value $kvp[1] -MemberType NoteProperty;$properties ++}
                    if($kvp[0] -eq 'pid' -and $kvp[1] -match '^([0-9]{9})$' ){Add-Member -InputObject $passport -Name $kvp[0] -Value $kvp[1] -MemberType NoteProperty;$properties ++}
                }
            }
            if($properties -eq 7){$valid++;$passports.Add($passport)}
            
            $passport = New-Object -TypeName psobject 
            $passportData=''
            $passportCount++
        }else{
            $passportData = $passportData + $input + ' '
        }
        $lineCount++
    }
    Write-Host 'Valid Passports: ' $valid -ForegroundColor Green
    $passportCount