$width=(Get-Host).UI.RawUI.WindowSize.Width;
$heigh=(Get-Host).UI.RawUI.WindowSize.Height;
[console]::CursorVisible=$false
$HOST.UI.RawUI.Flushinputbuffer()
while($null =! $Host.UI.RawUI.KeyAvailable){
cls;
$i=($heigh/4);while ($i -ge 1){Write-Host "`n";$i--;};
$totalhours='480'; $left=(28800-(((((get-date).hour*3600)-((Get-Process -id 4).starttime.Hour*3600))+((get-date).Minute*60)-((Get-Process -id 4).starttime.minute*60))+((get-date).second)-((Get-Process -id 4).starttime.second)))
$length=($width-$left.length); 
Write-Host -NoNewline $(' '*(($length/2)-4))
$lft=$([timespan]::FromSeconds($left))
("{0:00}" -f $lft.hours + ":" + "{0:00}" -f $lft.minutes + ":" + "{0:00}" -f $lft.seconds);
sleep 1;
}
[console]::CursorVisible=$true
