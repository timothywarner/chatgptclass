# Surface Pro 3 System Diagnostics Script
# Run as Administrator in PowerShell
# Creates: SystemDiagnostics_[timestamp].txt on Desktop

$timestamp = Get-Date -Format "yyyyMMdd_HHmmss"
$outputFile = "$env:USERPROFILE\Desktop\SystemDiagnostics_$timestamp.txt"

Write-Host "Starting Surface Pro 3 diagnostics..." -ForegroundColor Green
Write-Host "Output file: $outputFile" -ForegroundColor Yellow

# Start output file
"Surface Pro 3 System Diagnostics Report" | Out-File $outputFile
"Generated: $(Get-Date)" | Out-File $outputFile -Append
"=" * 60 | Out-File $outputFile -Append

try {
    # System Information
    "`n### SYSTEM OVERVIEW ###" | Out-File $outputFile -Append
    $sysInfo = Get-ComputerInfo | Select-Object WindowsVersion, WindowsBuildLabEx, TotalPhysicalMemory, CsProcessors, CsSystemType
    $sysInfo | Out-File $outputFile -Append

    # Top CPU processes
    "`n### TOP 10 CPU PROCESSES ###" | Out-File $outputFile -Append
    Get-Process | Sort-Object CPU -Descending | Select-Object -First 10 Name, CPU, WorkingSet, Id | Format-Table | Out-File $outputFile -Append

    # CPU Performance Sample
    "`n### CPU PERFORMANCE (5 samples) ###" | Out-File $outputFile -Append
    $cpuSamples = Get-Counter "\Processor(_Total)\% Processor Time" -SampleInterval 1 -MaxSamples 5
    $cpuSamples.CounterSamples | ForEach-Object {
        "CPU Usage: $([math]::Round($_.CookedValue, 2))% at $($_.Timestamp)"
    } | Out-File $outputFile -Append

    # Memory Status
    "`n### MEMORY STATUS ###" | Out-File $outputFile -Append
    $memCounters = Get-Counter "\Memory\Available MBytes", "\Memory\Pages/sec", "\Memory\Committed Bytes" -SampleInterval 1 -MaxSamples 3
    $memCounters.CounterSamples | Group-Object Path | ForEach-Object {
        $counterName = $_.Name.Split('\')[-1]
        $avgValue = ($_.Group | Measure-Object CookedValue -Average).Average
        "$counterName Average: $([math]::Round($avgValue, 2))"
    } | Out-File $outputFile -Append

    # Disk Information
    "`n### DISK SPACE ###" | Out-File $outputFile -Append
    Get-WmiObject -Class Win32_LogicalDisk | Select-Object DeviceID,
        @{Name="Size(GB)";Expression={[math]::Round($_.Size/1GB,2)}},
        @{Name="FreeSpace(GB)";Expression={[math]::Round($_.FreeSpace/1GB,2)}},
        @{Name="FreePercent";Expression={[math]::Round(($_.FreeSpace/$_.Size)*100,2)}} |
        Format-Table | Out-File $outputFile -Append

    # Network Adapters
    "`n### NETWORK ADAPTERS ###" | Out-File $outputFile -Append
    Get-NetAdapter | Where-Object Status -eq "Up" | Select-Object Name, InterfaceDescription, LinkSpeed, FullDuplex | Format-Table | Out-File $outputFile -Append

    # Network Connectivity Test
    "`n### NETWORK CONNECTIVITY ###" | Out-File $outputFile -Append
    $netTest = Test-NetConnection -ComputerName google.com -Port 80 -WarningAction SilentlyContinue
    "Google.com connectivity: $($netTest.TcpTestSucceeded)" | Out-File $outputFile -Append
    "Ping result: $($netTest.PingSucceeded) - $($netTest.PingReplyDetails.RoundtripTime)ms" | Out-File $outputFile -Append

    # Graphics Information
    "`n### GRAPHICS HARDWARE ###" | Out-File $outputFile -Append
    Get-WmiObject Win32_VideoController | Select-Object Name, DriverVersion, DriverDate, VideoMemoryType, VideoModeDescription | Format-List | Out-File $outputFile -Append

    # Temperature Files
    "`n### TEMP FILES ANALYSIS ###" | Out-File $outputFile -Append
    $userTemp = Get-ChildItem $env:TEMP -ErrorAction SilentlyContinue | Measure-Object -Property Length -Sum
    $winTemp = Get-ChildItem "C:\Windows\Temp" -ErrorAction SilentlyContinue | Measure-Object -Property Length -Sum
    "User Temp Files: $($userTemp.Count) files, $([math]::Round($userTemp.Sum/1MB, 2)) MB" | Out-File $outputFile -Append
    "Windows Temp Files: $($winTemp.Count) files, $([math]::Round($winTemp.Sum/1MB, 2)) MB" | Out-File $outputFile -Append

    # Startup Programs
    "`n### STARTUP PROGRAMS ###" | Out-File $outputFile -Append
    Get-CimInstance Win32_StartupCommand | Select-Object Name, Command, Location | Format-Table | Out-File $outputFile -Append

    # Windows Update Status
    "`n### WINDOWS UPDATE ###" | Out-File $outputFile -Append
    $updateSession = New-Object -ComObject Microsoft.Update.Session -ErrorAction SilentlyContinue
    if ($updateSession) {
        $updateSearcher = $updateSession.CreateUpdateSearcher()
        $searchResult = $updateSearcher.Search("IsInstalled=0")
        "Pending Windows Updates: $($searchResult.Updates.Count)" | Out-File $outputFile -Append
    } else {
        "Could not check Windows Update status" | Out-File $outputFile -Append
    }

} catch {
    "`nERROR: $($_.Exception.Message)" | Out-File $outputFile -Append
}

# Generate DXDiag separately (takes time)
"`n### GENERATING DXDIAG REPORT ###" | Out-File $outputFile -Append
$dxdiagFile = "$env:USERPROFILE\Desktop\dxdiag_$timestamp.txt"
Start-Process "dxdiag" -ArgumentList "/t `"$dxdiagFile`"" -Wait -WindowStyle Hidden
"DXDiag report saved to: $dxdiagFile" | Out-File $outputFile -Append

"`n### DIAGNOSTICS COMPLETE ###" | Out-File $outputFile -Append
"Report generated: $(Get-Date)" | Out-File $outputFile -Append

Write-Host "`nDiagnostics complete!" -ForegroundColor Green
Write-Host "Main report: $outputFile" -ForegroundColor Yellow
Write-Host "DXDiag report: $dxdiagFile" -ForegroundColor Yellow
Write-Host "`nUpload both files to Claude for analysis." -ForegroundColor Cyan
