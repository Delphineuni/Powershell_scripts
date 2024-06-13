$base=''
function power($base,$exponent) {
    if ($exponent -le 0){
            return 1;
        }
    else {
            return $base * (power $base ($exponent=$exponent-1))
        }
}
while ($true) {
try {
    if (-not $base) {
        [int]$base=read-host "base"
    }
    [int]$exponent=read-host "exponent"
    break
    }
catch {
    Write-Host "Not a number!"
    }
}
$result=(power $base $exponent)
write-host "result:"$result