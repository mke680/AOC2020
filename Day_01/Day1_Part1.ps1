$file = 'C:\Users\mcho\OneDrive - GRACE WORLDWIDE (AUSTRALIA) PTY LTD\Documents\AOC\Day_1\Day1Input.txt'

$inputs = import-csv $file -Header 'Expense'

$result = 0

foreach($input in $inputs){
    foreach($test in $inputs){
        $result = $input.Expense/1 + $test.Expense/1
        if($result -eq 2020){write-host ($input.Expense/1 * $test.Expense/1); return }
    }
}
    
