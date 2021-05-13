$file = 'C:\Users\mcho\OneDrive - GRACE WORLDWIDE (AUSTRALIA) PTY LTD\Documents\AOC\Day_7\Day7Test.txt'

$inputs = Get-Content $file 

$validBags = New-Object System.Collections.ArrayList
$validBagsList = New-Object System.Collections.ArrayList
$validChildBags = New-Object System.Collections.ArrayList
$rules = [System.Collections.ArrayList]@()
$totalBags = [System.Collections.ArrayList]@()

$bagRule = @{
    Number     =  1
    ParentBag = 'shiny gold'
    ChildBag    = 'shiny gold'
}

foreach($rule in $inputs){
    #write-host $rule -ForegroundColor Magenta
    $ruleSplit = $rule -split " contain "
    $parentBag = $ruleSplit[0]
    if($ruleSplit[1] -match ','){
        $subBagCount =($ruleSplit[1].ToCharArray() | Where-Object {$_ -eq ','} | Measure-Object).Count
        foreach($subBag in $ruleSplit[1].Split(',')){
            $currentRule = [pscustomobject]$bagRule
            $currentRule.ParentBag = ($parentBag.Trim() -split " bag")[0]
            $currentRule.ChildBag = ((($subBag.Trim() -split " bag")[0]) -split ' ',2)[1]
            $currentRule.Number = ((($subBag.Trim() -split " bag")[0]) -split ' ',2)[0]
            #write-host $currentRule -ForegroundColor Green
            [void]$rules.Add($currentRule)
        }
    }else{
        if($ruleSplit[1] -ne 'no other bags.'){
            $currentRule = [pscustomobject]$bagRule
            $currentRule.ParentBag = ($parentBag.Trim() -split " bag")[0]
            $currentRule.ChildBag = ((($ruleSplit[1].Trim() -split " bag")[0]) -split ' ',2)[1]
            $currentRule.Number = ((($ruleSplit[1].Trim() -split " bag")[0]) -split ' ',2)[0]
            #write-host $currentRule -ForegroundColor Yellow
            [void]$rules.Add($currentRule)
        }
    }
}

foreach($rule in $rules){
    if($rule.ChildBag -match $currentBag){
        [void]$validBags.Add($rule.ParentBag)
        [void]$validBagsList.Add($rule.ParentBag) ##4
    }
}
$match = $true

## Store valid bags in Valid Child Bags
[void]$validChildBags.Add("1_shiny gold")

$match = $true
while($match){
    $matchCount = 0
    $tempBag = @($validChildBags) ## Temporary Recurse List to allow overwriting
    $validChildBags.Clear() ## Clear Recurse List to get next Candidates

    foreach($validBag in $tempBag){
        foreach($rule in $rules){
            if($rule.ParentBag -match $validBag.Split('_')[1]){
                ## Convert to Int and Multiply to get current bagCount
                $bagCount = [convert]::ToInt32($rule.Number,10) * [convert]::ToInt32($validBag.Split('_')[0],10)
                [void]$validChildBags.Add($bagCount.ToString() + '_' +  $rule.childBag)  ## Overwrite Recurse List
                $matchCount++
                $rule.number = $bagCount ##Overwrite to get rolling bag count
                [void]$totalBags.Add($rule) 
            } 
        }
    }
    if($matchCount -eq 0){$match=$false}
}
$answer = 0
foreach($bag in $totalBags){$answer = $answer + $bag.Number} ## Recursively Sum Bag Counts
write-host $answer -ForegroundColor Green