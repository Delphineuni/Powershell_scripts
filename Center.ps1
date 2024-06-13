$wait= "Waiting for execution, time to act!"
$width=(Get-Host).UI.RawUI.WindowSize.Width
$heigh=(Get-Host).UI.RawUI.WindowSize.Height
[console]::CursorVisible=$false
$HOST.UI.RawUI.Flushinputbuffer()
While ($null =! $Host.UI.RawUI.KeyAvailable) {
cls;sleep -m 500
$i=($heigh/4);while ($i -ge 1){Write-Host "`n";$i--;} 
$length=$width+($wait.Length); $wait.PadLeft( "{0:N0}" -f (($length / 2)," "))
#$i=($heigh/8);while ($i -ge 0){Write-Host "`n";$i--;} 
sleep -m 500}
#$Host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown")> $null
[console]::CursorVisible=$true
