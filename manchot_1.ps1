$width=(Get-Host).UI.RawUI.WindowSize.Width;
$heigh=(Get-Host).UI.RawUI.WindowSize.Height;
[console]::CursorVisible=$false
while ($true) {
$timeout = new-timespan -Seconds 5
$first=(get-random -max 9)
$second=(get-random -max 9)
$third=(get-random -max 9)
$i=0
$roll=0
$sleep=10
$spc=' '
do {
switch ($i) {
    0 { $test=$first }
    1 { $test=$second }
    2 { $test=$third }
}

$sw = [diagnostics.stopwatch]::StartNew()
while (($sw.elapsed -lt $timeout) -or ($roll -ne $test)) {
cls
$roll++
if ($roll -gt 9) {$roll=0}
$a=($($heigh/4));while ($a -ge 1){Write-Host "`n";$a--;};
#before roll
write-host -nonewline $(' '*(($width-('888'.Length))/2))
#write-host -nonewline $(if($i -eq 1) {$first};if($i -eq 2) {"$first$second"})
switch ($i) {
    0 { write-host -fore DarkGreen $(if ($($roll-1) -lt 0) { "9" } else { $($roll-1) }) }
    1 { write-host -fore DarkGreen $spc$(if ($($roll-1) -lt 0) { "9" } else { $($roll-1) }) }
    2 { write-host -fore DarkGreen $spc$spc$(if ($($roll-1) -lt 0) { "9" } else { $($roll-1) }) }
}
#roll
write-host -nonewline $(' '*(($width-('888'.Length))/2))
write-host -nonewline -fore Green $(if($i -eq 1) {$first};if($i -eq 2) {"$first$second"})
write-host -fore Green $roll
#after roll
write-host -nonewline $(' '*(($width-('888'.Length))/2))
#write-host -nonewline $(if($i -eq 1) {$first};if($i -eq 2) {"$first$second"})
switch ($i) {
    0 { write-host -nonewline -fore DarkGreen $(if ($($roll+1) -gt 9) { "0" } else { $($roll+1) })}
    1 { write-host -nonewline -fore DarkGreen $spc$(if ($($roll+1) -gt 9) { "0" } else { $($roll+1) })}
    2 { write-host -nonewline -fore DarkGreen $spc$spc$(if ($($roll+1) -gt 9) { "0" } else { $($roll+1) })}
}
if ($sw.Elapsed -gt ($timeout.ticks/5)) {
    $sleep=$sleep+5
}
sleep -m $sleep
}
$sleep=10
$i++
cls
$a=($($heigh/4));while ($a -ge 1){Write-Host "`n";$a--;};
write-host ""
write-host -nonewline $(' '*(($width-('888'.Length))/2))
write-host -nonewline -fore Green $(if($i -eq 1){$first};if($i -eq 2){"$first$second"};if($i -eq 3){"$first$second$third"})
sleep -m 500
}
until ( $i -eq 3)
if (($first -eq $second) -and ($second -eq $third) -and ($third -eq 7)) {
    $sw = [diagnostics.stopwatch]::StartNew()
    while ($sw.elapsed -lt $timeout) {
    cls
    sleep -m 300
    $a=($heigh/4);while ($a -ge 1){Write-Host "`n";$a--;};
    write-host ""
    write-host -fore Green $(' '*(($width-("888".Length))/2)),$first$second$third
    write-host -nonewline $(' '*(($width-('MEGA JACKPOT'.Length))/2)),"MEGA JACKPOT!"
    sleep -m 300
    }
}
elseif (($first -eq $second) -and ($second -eq $third)) {
    $sw = [diagnostics.stopwatch]::StartNew()
    while ($sw.elapsed -lt $timeout) {
    cls
    sleep -m 300
    $a=($heigh/4);while ($a -ge 1){Write-Host "`n";$a--;};
    write-host ""
    write-host -fore Green $(' '*(($width-("888".Length))/2)),$first$second$third
    write-host -nonewline $(' '*(($width-('JACKPOT'.Length))/2)),"JACKPOT!"
    sleep -m 300
    }
}
else {
    cls
    $a=($heigh/4);while ($a -ge 1){Write-Host "`n";$a--;};
    write-host ""
    write-host -fore Green $(' '*(($width-("888".Length))/2)),$first$second$third
    write-host -nonewline $(' '*(($width-('TRY AGAIN'.Length))/2)),"TRY AGAIN!"
}
Read-Host
while ($true) {
cls
$a=($heigh/4);while ($a -ge 1){Write-Host "`n";$a--;};
$play=read-host $(' '*(($width-("Play again?".Length))/2)),"Play again?"
if ($play -contains 'n') {
exit
}
elseif ($play -contains 'y') {
break
}
}
}