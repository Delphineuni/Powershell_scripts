function test_key {
 $key=$Host.UI.RawUI.ReadKey('NoEcho,IncludeKeyDown')
switch ( $key.character ) {
    p { write-host "pause" }
    s { write-host "stop" }
    y { Write-Host "yes" }
    n { Write-Host "no" }
    x { Write-Host "bye"; exit }
}
}
while ($true) {
if ( $Host.UI.RawUI.KeyAvailable ) {
test_key
sleep -m 300
}
}