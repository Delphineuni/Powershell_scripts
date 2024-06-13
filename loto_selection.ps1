$numbers=@()
for ($i=0; $i -lt 7; $i++) {
$number=(get-random -min 1 -max 49)
if ($numbers -contains $number) {
 $i--
 }
 else {
    $numbers+=$number
   }
}
$numbers=$numbers|sort
Write-Host "Lottery numbers for today : ",$numbers