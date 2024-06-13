$i=$null
$j=$null
while ($True) {
try{
if (!$i){
[int]$i= read-host "What is the start of the range?"
}
[int]$j= read-host "What is the end of the range?"
}
catch{
write-host "Not a Number"
continue
}
break
}
$start=$i
$end=$j
[int]$j=2
[int]$primes=0
$numbers=@()
if (($start -eq 1) -and ($end -ge 2)){
$numbers+=@(1..2)
}
elseif ($start -eq 1) {
$numbers+=@(1)
}
elseif ($start -eq 2) {
$numbers+=@(2)
}
for ($i; $i -le $end; $i++){
 while ( $j -lt $i){
 if (-not ($i%$j)){
 break
 }
 elseif ($j -gt $i/$j){
 $numbers+=$i
 break
 }
 $j++
 }
 $j=2
}
if ($start -eq $end){
if ($numbers.contains($start)){
Write-Host $start,"est un nombre premier"
}
else{
Write-Host $start,"n'est pas un nombre premier"
}
}
else{
if ($numbers.length -eq 1){
  Write-Host "Il y a 1 nombre premier entre ",$start,"et ",$end
  }
  else{
  Write-Host "il y a",$numbers.Length,"nombres premiers entre",$start,"et",$end
  }
   Foreach ($number in $numbers) {
  if ($number -eq ($numbers[$($numbers.Length-1)])) {
  Write-Host -NoNewline $number
  break
  }
  write-host -nonewline $number", "
  }
  }
 
