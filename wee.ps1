$heigh=(Get-Host).UI.RawUI.WindowSize.Height;
$width=(Get-Host).UI.RawUI.WindowSize.Width;
[console]::CursorVisible=$false
$weee="weee...";
$leng=$($width-$($weee.length))
$space=$leng
$sens=0
$pass=0
while (1){
    if ($Host.UI.RawUI.KeyAvailable) {
        $key=$host.ui.RawUI.ReadKey("noecho,includekeydown,includekeyup")
        if ($key.keydown -eq "True") {
        [console]::CursorVisible=$true
        exit;
        }}
    if ($sens -eq 0){
        $space--
        } 
    else {
        $space++
        };
    if ($space -le 0) {
        $sens=1
        } 
    elseif ($space -ge $leng) {
        $sens=0
        };
	$sp=(' '*$space);$he=($heigh/4);
	while ($he -ge $((Get-Random -Minimum -2 -Maximum 2)+1)){Write-Host "`n";$he--;}
	$up=(Get-Random -Minimum 0 -Maximum 2);$pass++; 
$weee = Switch ($pass) {
	1 {"Weee..."};
	2 {"wEee..."};
	3 {"weEe..."};
	4 {"weeE..."};
	5 {"weee!.."};
	6 {"weee.!."};
	7 {"weee..!"};
	8 {"weee..."; $pass=0};
}
	Write-Host -NoNewline $sp $weee;
	sleep -m 40;
	cls;
}