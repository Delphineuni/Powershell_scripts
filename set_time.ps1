# Get window's width
$width=(Get-Host).UI.RawUI.WindowSize.Width;
# Get window's height
$heigh=(Get-Host).UI.RawUI.WindowSize.Height;
# Turns cursor invisible to prevent it from flashing during script execution
#$start=''
function set_time ($text) {
    cls;
    $i=($heigh/4);while ($i -ge 1){Write-Host "`n";$i--;};
    $global:value=Read-Host $(' '*(($width-($text.Length))/2)),$text;
}

while (1) {
    try {
        set_time 'Starting time? [2400 format]' 
        [string]$start=$value
        [int]$starthour=([int]($start[0..1] -join ""))*3600;
        [int]$startminute=([int]($start[2..3] -join ""))*60
        $starttime=$starthour+$startminute
        echo $start, $starttime
        break
        }
    catch {
        echo 'nan'
        sleep 1
     }
}
Write-Host $start