$try_again=1
while ($try_again -eq 1) {
$count=0
$number=$(get-random -Min 1 -Max 100)
Write-Host "Trouvez un nombre entre 1 et 100"
while ($true) {
    $count++
    while ($true) {
        try {
            [int]$choice=Read-Host "Your choice?"
            break
        }
        catch {
            Write-Host "Not a Number!`n"
        }
    }
    if (($choice -eq $number) -or ($count -ge 10)) {
        break
        }
    elseif ( $choice -gt $number ) {
        Write-Host "Smaller !`n"
        }
    else {
        Write-Host "Bigger !`n"
        }
}
if ( $choice -eq $number ) {
    Write-Host "You won!"
    }
else {
    Write-Host "You lost! The number was $number"
    }
while ($true) {
$answer=Read-Host "Do you want to play again? (y/n)"
if ($answer -contains 'y') {
break
}
if ($answer -contains 'n') {
$try_again=0
break
}
}
}
