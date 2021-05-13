$file = 'C:\Users\mcho\OneDrive - GRACE WORLDWIDE (AUSTRALIA) PTY LTD\Documents\AOC\Day_14\Day14Test.txt'

$inputs = Get-Content $file
$bitMasks = [System.Collections.ArrayList]@()
$memory = [System.Collections.ArrayList]@()
$floatingBits = [System.Collections.ArrayList]@()
$totalBits = New-Object 'system.collections.generic.dictionary[int64,int32]'

foreach($input in $inputs){

    #### MASK LOGIC ####
    if($input.StartsWith("mask = ")){ 
        $bitMasks = [System.Collections.ArrayList]@()
        $bitMask = $input.Replace("mask = ","")
        $bitPosition = 0
        foreach($bit in $bitMask.ToCharArray()){
            if($bit -ne '0'){
                #### BITMASK STORAGE ####
                $currentBitMask = [PSCustomObject]@{
                    bit = $bit
                    position = $bitPosition
                }
                [void]$bitMasks.Add($currentBitMask)   ### STORE VALUE
                 
            }
            $bitPosition++
        }
    }else{ 
        #### VALUE LOGIC ####
        $bitValue = ($input -split (" = "))[1]
        $bitPosition = [Convert]::ToString(((($input -split (" = "))[0].Split("[")[1]) -replace "]" ,""),2).PadLeft(36,'0')
        $bitData = [PSCustomObject]@{
            value = $bitValue 
            position = $bitPosition
        }
        [void]$floatingBits.Add($bitData)

        write-host 'Restart' $floatingBits -ForegroundColor Green

        ##### X MASK LOGIC  #####
        foreach($mask in $bitMasks | Where-Object {$_.bit -eq 'X'}){
            $tempBits = @($floatingBits) ### RECURSION
            $floatingBits.Clear()
            foreach($binary in ('0','1')){
                foreach($bit in $tempBits){
                    $bitValue = $bit.value
                    $bit = $bit.position.ToCharArray()
                    $bit[$mask.position] = $binary
                    ### FOR X REPLACEMENT RECURSION ###
                    $bitData = [PSCustomObject]@{
                        value = $bitValue 
                        position = $bit -join ''
                    }
                    [void]$floatingBits.Add($bitData)
                }
            }
        }

        ### NON X mASK LOGIC ###
        $tempBag = @($floatingBits) ## Temporary Recurse List to allow overwriting
        $floatingBits.Clear() ## Clear Recurse List to get next Candidates

        foreach($tempBit in $tempBag){
            $bitPosition = $tempBit.position.ToCharArray()
            foreach($bitMask in $bitMasks){
                if($bitMask.bit -eq '1'){
                    $bitPosition[$bitMask.position] = $bitMask.bit 
                }
            }
            $bitData = [PSCustomObject]@{
                value = $tempBit.value 
                position = $bitPosition -join ''
            }
            [void]$floatingBits.Add($bitData)
        }

        foreach($bit in $floatingBits){
            $bitPosition = [Convert]::ToInt64($bit.position,2)
            write-host $bit.position ':' $bitPosition ':' $bit.value -ForegroundColor Magenta
            $totalBits[$bitPosition] = $bit.value
        }
        $floatingBits.Clear()
    }


}
$totalBits.Values | Measure -Sum