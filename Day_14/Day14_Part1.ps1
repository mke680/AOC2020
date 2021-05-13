$file = 'C:\Users\mcho\OneDrive - GRACE WORLDWIDE (AUSTRALIA) PTY LTD\Documents\AOC\Day_14\Day14Test.txt'

$inputs = Get-Content $file
$bitMasks = [System.Collections.ArrayList]@()
$memory = [System.Collections.ArrayList]@()

foreach($input in $inputs){
    if($input.StartsWith("mem")){ 
        $bitMemory = [PSCustomObject]@{
            value = 0
            position = ($input -split (" = "))[0]
        }
        [void]$memory.Add($bitMemory)
    }
}
$memory = $memory | sort position -unique

#write-host $memory -ForegroundColor DarkCyan
foreach($input in $inputs){

    #### DO THIS WHEN I SEE THE "MASK ="
    if($input.StartsWith("mask = ")){ 
        $bitMasks = [System.Collections.ArrayList]@()
        $bitMask = $input.Replace("mask = ","")
        write-host $bitMask -foreground Cyan
        $bitPosition = 0
        foreach($bit in $bitMask.ToCharArray()){
            if($bit -ne 'X'){
                ### CUSTOM OBJECT TO HOLD Bitmask and "Repetitions" i.e. kurrent
                $currentBitMask = [PSCustomObject]@{
                    bit = $bit
                    position = $bitPosition
                }
                [void]$bitMasks.Add($currentBitMask)   ### STORE VALUE

            }
            $bitPosition++
        }
    }else{ ### DO THIS WHEN I DON't SEE THE MASK
        $bitValue = [Convert]::ToString(($input -split (" = "))[1],2).PadLeft(36,'0')
        $bitValue = $bitValue.ToCharArray()
        foreach($bitMask in $bitMasks){
            $bitValue[$bitMask.position] = $bitMask.bit
        }
        $bitValue = $bitValue -join ''
        $bitPosition = ($input -split (" = "))[0]
        $bitValue = [Convert]::ToInt64($bitValue -join '',2)
        write-host $bitPosition '-' $bitValue -foreground green
        ($memory | Where-Object {$_.position -eq $bitPosition}).value = $bitValue
    }

}
$memory | Measure -Property value -Sum
