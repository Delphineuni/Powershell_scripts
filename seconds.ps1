$width=(Get-Host).UI.RawUI.WindowSize.Width;
$heigh=(Get-Host).UI.RawUI.WindowSize.Height;
[console]::CursorVisible=$false
while (-not $Host.UI.RawUI.KeyAvailable){
cls;
$i=($heigh/4);while ($i -ge 1){Write-Host "`n";$i--;};
$length=($width-$second.length); 
$second=("{0:ss}" -f (Get-Date));
$SecRev="$("{0:d2}" -f (59-$second))";
$SecRev.PadLeft(("{0:N0}" -f (($length/2)," ")));
sleep 1;
}
[console]::CursorVisible=$true
