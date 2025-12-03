@echo off

rem Crear carpeta destino
mkdir C:\LabboxDuende 2>nul

rem Copiar archivos
copy "%~dp0duende.ps1" C:\LabboxDuende\ /Y
copy "%~dp0duende.png" C:\LabboxDuende\ /Y

rem Borrar tarea anterior si existe
powershell.exe -ExecutionPolicy Bypass -Command "if (Get-ScheduledTask -TaskName 'Duende' -ErrorAction SilentlyContinue) { Unregister-ScheduledTask -TaskName 'Duende' -Confirm:$false }"

rem Crear tarea programada cada 10 minutos
powershell.exe -ExecutionPolicy Bypass -Command ^
"$action = New-ScheduledTaskAction -Execute 'powershell.exe' -Argument '-ExecutionPolicy Bypass -File ""C:\LabboxDuende\duende.ps1""' ; ^
 $trigger = New-ScheduledTaskTrigger -Once -At (Get-Date).AddMinutes(2) -RepetitionInterval (New-TimeSpan -Minutes 10) -RepetitionDuration (New-TimeSpan -Days 1) ; ^
 Register-ScheduledTask -TaskName 'Duende' -Action $action -Trigger $trigger -RunLevel Highest -Force"



