@echo off
setlocal enabledelayedexpansion

REM Initialize counter
set counter=1

:run_process_monitor
echo Starting Process Monitor...
C:\ProcessMonitor\procmon.exe /accepteula /loadconfig C:\ProcessMonitor\ProcMonScan\ProcmonConfiguration.pmc /Quiet /runtime 10 /backingfile C:\ProcessMonitor\Procmon.pml

echo Process Monitor will pause for 5 seconds...
timeout /t 5 /nobreak >nul

echo Converting PML file to CSV...

REM Construct filename with incrementing counter
set csv_file=C:\ProcessMonitor\Procmon!counter!.csv

REM Save PML file as CSV
C:\ProcessMonitor\procmon.exe /OpenLog C:\originalpath.PML /SaveAs !csv_file!

REM Increment counter
set /a counter+=1

REM Check if counter exceeds 50, reset if necessary
if !counter! gtr 50 set counter=1

goto run_process_monitor
