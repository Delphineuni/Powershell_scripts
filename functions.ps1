function Who {cls;While($True) {Write-Host -ForegroundColor ([System.ConsoleColor](Get-Random -Min 0 -Max ([System.ConsoleColor].GetFields().Count - 1))) 'Dooooctoor?!'; sleep 5 }}
function Do-Something {Write-Host -ForegroundColor red 'EXTERMINATE!!'}
