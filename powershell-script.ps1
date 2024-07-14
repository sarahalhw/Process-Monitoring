# Create a filter file with those unneeded entries removed (ProcmonConfiguration.pmc).
#copy the process monitor application and the filter file to the folder c:\eng\ProcMonScan
# Determine the length of the scan by changing the value /runtime 15 (seconds)
$Answ = test-path -path C:\ProcessMonitor
If ($Answ -eq "True") {}Else{ MD C:\ProcessMonitor }

$Answ = test-path -path C:\ProcessMonitor\ProcMonScan
If ($Answ -eq "True") {}Else{ MD C:\ProcessMonitor\ProcMonScan}


C:\ProcessMonitor\procmon.exe /accepteula /loadconfig C:\ProcessMonitor\ProcMonScan\ProcmonConfiguration.pmc /Quiet /runtime 45 /backingfile C:\ProcessMonitor\Procmon.pml
C:\ProcessMonitor\procmon.exe /openlog C:\originalpath.PML /saveas C:\ProcessMonitor\Procmon.csv | wait-Job


$Search1 = test-path -path C:\ProcessMonitor\Procmon.csv
If ($search1 -eq "True"){
rename-item -NewName newProcmon1.txt C:\ProcessMonitor\Procmon.csv}{}
$regex = '\b\d{1,3}\.\d{1,3}\.\d{1,3}\.\d{1,3}\b'

Select-String -Path C:\ProcessMonitor\Procmon.txt | Out-File -FilePath C:\ProcessMonitor\ProcmonFiltered.txt


$Search2 = test-path -path C:\ProcessMonitor\ProcessMonCHKLOG.txt

If ($Search2 -eq "True"){
rename-item -NewName ((Get-Date). tostring("dd-MM-yyyy-hh-mm-ss") + "ProcessMonCHK.txt") C:\ProcessMonitor\ProcessMonCHKLOG.txt}{}

$Search3 = test-path -path C:\ProcessMonitor\Procmon.txt
If ($search3 -eq "True") {
remove-item -path C:\ProcessMonitor\Procmon.txt}{}


$Search4 = test-path -path C:\ProcessMonitor\Procmon.PML
If ($Search4 -eq "True") {
remove-item -path C:\ProcessMonitor\Procmon.PML}{}
