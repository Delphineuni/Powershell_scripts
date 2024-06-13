[console]::TreatControlCAsInput=$true
while (1) { 
    if ($Host.UI.rawUI.KeyAvailable -and (3 -eq [int]$Host.UI.RawUI.ReadKey("AllowCtrlC,IncludeKeyUp,NoEcho").character)) {
         for ($i=0; $i -lt 3; $i++) { 
            Write-Host -ForegroundColor red "Ahahah, you didn't say the magic word!";
            sleep -m 500
            }
         break
         } 
sleep 1 
}