#Measure-Command {
 
    $file = 'C:\Users\mcho\OneDrive - GRACE WORLDWIDE (AUSTRALIA) PTY LTD\Documents\AOC\Day_4\Day4Input.txt'

    $inputs = Get-Content $file ; $inputs = $inputs + ''

    $passport = New-Object -TypeName psobject 
    $passports = New-Object System.Collections.ArrayList
    $passportData = ''
    $valid = 0
    $lineCount = 0
    $passportCount = 0
    foreach($input in $inputs){
        if($input -eq '' ){ 
            $properties = 0
            $passportData.Trim().Split(' ') | ForEach{
                $kvp = $_.Split(':')
                if($kvp[0] -ne 'cid'){Add-Member -InputObject $passport -Name $kvp[0] -Value $kvp[1] -MemberType NoteProperty;$properties ++}
            }
            if($properties -eq 7){$valid++}
            $passports.Add($passport)
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