#Requires -RunAsAdministrator
<#
.SYNOPSIS
    Surface Laptop 3 Ultimate Performance Optimization Script

.DESCRIPTION
    Comprehensive performance optimization for Surface Laptop 3 running Windows 11
    Targets: Windows Defender, Startup, Services, Memory Management, Power Settings

.AUTHOR
    Customized for Tim's Surface Laptop 3 - AMD Ryzen 7 Edition

.NOTES
    Version: 1.0
    Date: May 28, 2025
    Some changes require restart to take full effect
#>

# Script configuration
$Script:ChangesMade = @()
$Script:RestartRequired = $false
$ErrorActionPreference = "Stop"

# Color-coded output functions
function Write-Status {
    param([string]$Message)
    Write-Host "[$([DateTime]::Now.ToString('HH:mm:ss'))] " -NoNewline -ForegroundColor DarkGray
    Write-Host $Message -ForegroundColor Cyan
}

function Write-Success {
    param([string]$Message)
    Write-Host "✓ " -NoNewline -ForegroundColor Green
    Write-Host $Message
    $Script:ChangesMade += $Message
}

function Write-Warning {
    param([string]$Message)
    Write-Host "⚠ " -NoNewline -ForegroundColor Yellow
    Write-Host $Message
}

function Write-Error {
    param([string]$Message)
    Write-Host "✗ " -NoNewline -ForegroundColor Red
    Write-Host $Message
}

# Check for admin privileges
function Test-Administrator {
    $currentUser = [Security.Principal.WindowsIdentity]::GetCurrent()
    $principal = New-Object Security.Principal.WindowsPrincipal($currentUser)
    return $principal.IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)
}

if (-not (Test-Administrator)) {
    Write-Error "This script must be run as Administrator!"
    exit 1
}

Write-Host @"
╔═══════════════════════════════════════════════════════════════╗
║     Surface Laptop 3 Ultimate Performance Optimizer v1.0      ║
║                  AMD Ryzen 7 Edition - 32GB RAM               ║
╚═══════════════════════════════════════════════════════════════╝
"@ -ForegroundColor Magenta

Write-Status "Starting comprehensive system optimization..."

# ==============================================================================
# SECTION 1: Windows Defender Optimization
# ==============================================================================
Write-Host "`n━━━ WINDOWS DEFENDER OPTIMIZATION ━━━" -ForegroundColor Yellow

try {
    Write-Status "Configuring Windows Defender exclusions..."

    # Add performance-critical exclusions
    $exclusionPaths = @(
        "$env:USERPROFILE\AppData\Local\Temp",
        "$env:WINDIR\Temp",
        "$env:USERPROFILE\Downloads",
        "$env:USERPROFILE\Documents\GitHub",
        "$env:USERPROFILE\.vscode",
        "$env:USERPROFILE\AppData\Roaming\npm",
        "$env:USERPROFILE\AppData\Local\Programs\Python",
        "C:\Program Files\nodejs",
        "C:\ProgramData\chocolatey"
    )

    $exclusionProcesses = @(
        "chrome.exe", "msedgewebview2.exe", "msedge.exe",
        "node.exe", "npm.exe", "python.exe", "pythonw.exe",
        "code.exe", "cursor.exe", "devenv.exe",
        "git.exe", "gh.exe", "bash.exe"
    )

    foreach ($path in $exclusionPaths) {
        if (Test-Path $path) {
            Add-MpPreference -ExclusionPath $path -ErrorAction SilentlyContinue
            Write-Success "Added exclusion: $path"
        }
    }

    foreach ($process in $exclusionProcesses) {
        Add-MpPreference -ExclusionProcess $process -ErrorAction SilentlyContinue
        Write-Success "Excluded process: $process"
    }

    # Reduce real-time scanning impact
    Set-MpPreference -ScanAvgCPULoadFactor 25
    Set-MpPreference -DisableCpuThrottleOnIdleScans $false
    Set-MpPreference -EnableLowCpuPriority $true

    # Disable cloud-based protection (major CPU saver)
    Set-MpPreference -MAPSReporting 0
    Set-MpPreference -SubmitSamplesConsent 2
    Set-MpPreference -DisableBlockAtFirstSeen $true

    Write-Success "Windows Defender optimized for performance"

} catch {
    Write-Warning "Some Defender settings couldn't be modified: $_"
}

# ==============================================================================
# SECTION 2: Startup Cleanup
# ==============================================================================
Write-Host "`n━━━ STARTUP OPTIMIZATION ━━━" -ForegroundColor Yellow

try {
    Write-Status "Cleaning duplicate startup entries..."

    # Remove duplicate GoogleDriveFS entries
    $googleDriveEntries = Get-CimInstance Win32_StartupCommand | Where-Object {$_.Name -like "*GoogleDriveFS*"}
    if ($googleDriveEntries.Count -gt 1) {
        $googleDriveEntries | Select-Object -Skip 1 | ForEach-Object {
            Remove-CimInstance -InputObject $_ -ErrorAction SilentlyContinue
            Write-Success "Removed duplicate GoogleDriveFS entry"
        }
    }

    # Remove duplicate OneDrive entries
    $oneDriveEntries = Get-CimInstance Win32_StartupCommand | Where-Object {$_.Name -like "*OneDrive*"}
    if ($oneDriveEntries.Count -gt 1) {
        $oneDriveEntries | Select-Object -Skip 1 | ForEach-Object {
            Remove-CimInstance -InputObject $_ -ErrorAction SilentlyContinue
            Write-Success "Removed duplicate OneDrive entry"
        }
    }

    # Disable Windows startup delay
    $regPath = "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Serialize"
    if (-not (Test-Path $regPath)) {
        New-Item -Path $regPath -Force | Out-Null
    }
    Set-ItemProperty -Path $regPath -Name "StartupDelayInMSec" -Value 0 -Type DWord
    Write-Success "Disabled startup delay"

} catch {
    Write-Warning "Startup optimization partially failed: $_"
}

# ==============================================================================
# SECTION 3: Service Optimization
# ==============================================================================
Write-Host "`n━━━ SERVICE OPTIMIZATION ━━━" -ForegroundColor Yellow

$servicesToDisable = @{
    "WSearch" = "Windows Search (using too much CPU)"
    "SysMain" = "Superfetch (causes disk thrashing)"
    "DiagTrack" = "Diagnostics Tracking"
    "dmwappushservice" = "Device Management Push Service"
    "diagnosticshub.standardcollector.service" = "Diagnostics Hub"
    "DPS" = "Diagnostic Policy Service"
    "MapsBroker" = "Downloaded Maps Manager"
    "lfsvc" = "Geolocation Service"
    "NetTcpPortSharing" = "Net.Tcp Port Sharing"
    "RemoteRegistry" = "Remote Registry"
    "WMPNetworkSvc" = "Windows Media Player Network"
}

foreach ($service in $servicesToDisable.GetEnumerator()) {
    try {
        $svc = Get-Service -Name $service.Key -ErrorAction SilentlyContinue
        if ($svc -and $svc.Status -eq 'Running') {
            Stop-Service -Name $service.Key -Force -ErrorAction SilentlyContinue
        }
        if ($svc) {
            Set-Service -Name $service.Key -StartupType Disabled -ErrorAction SilentlyContinue
            Write-Success "Disabled $($service.Value)"
        }
    } catch {
        Write-Warning "Couldn't disable $($service.Key)"
    }
}

# ==============================================================================
# SECTION 4: Memory Management
# ==============================================================================
Write-Host "`n━━━ MEMORY OPTIMIZATION ━━━" -ForegroundColor Yellow

try {
    # Disable memory compression (you have 32GB, don't need it)
    Disable-MMAgent -MemoryCompression -ErrorAction SilentlyContinue
    Write-Success "Disabled memory compression"

    # Optimize page file
    $pageFile = Get-CimInstance -Class Win32_PageFileSetting -ErrorAction SilentlyContinue
    if ($pageFile) {
        $pageFile | Remove-CimInstance
    }

    # Set fixed page file size (initial: 4GB, max: 8GB)
    $system = Get-CimInstance Win32_ComputerSystem
    $system.AutomaticManagedPagefile = $false
    $system.Put()

    Set-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management" -Name "PagingFiles" -Value "C:\pagefile.sys 4096 8192"
    Write-Success "Optimized page file settings"

    # Set system to favor foreground apps
    Set-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Control\PriorityControl" -Name "Win32PrioritySeparation" -Value 38
    Write-Success "Set system to favor foreground applications"

    # Disable NDU (Network Data Usage monitoring - known memory leak)
    Set-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Services\Ndu" -Name "Start" -Value 4
    Write-Success "Disabled NDU memory leak"

    $Script:RestartRequired = $true

} catch {
    Write-Warning "Memory optimization partially failed: $_"
}

# ==============================================================================
# SECTION 5: Power Profile Optimization
# ==============================================================================
Write-Host "`n━━━ POWER PROFILE OPTIMIZATION ━━━" -ForegroundColor Yellow

try {
    # Create ultimate performance profile
    $output = powercfg -duplicatescheme 8c5e7fda-e8bf-4a96-9a85-a6e23a8c635c 2>&1
    if ($output -match "([a-fA-F0-9]{8}-[a-fA-F0-9]{4}-[a-fA-F0-9]{4}-[a-fA-F0-9]{4}-[a-fA-F0-9]{12})") {
        $newSchemeGuid = $matches[1]

        powercfg -changename $newSchemeGuid "Surface Max Performance" "Optimized for Surface Laptop 3"

        # CPU performance settings
        powercfg -setacvalueindex $newSchemeGuid SUB_PROCESSOR PERFINCTHRESHOLD 10
        powercfg -setacvalueindex $newSchemeGuid SUB_PROCESSOR PERFDECTHRESHOLD 8
        powercfg -setacvalueindex $newSchemeGuid SUB_PROCESSOR PERFBOOSTMODE 2
        powercfg -setacvalueindex $newSchemeGuid SUB_PROCESSOR PROCTHROTTLEMAX 100
        powercfg -setacvalueindex $newSchemeGuid SUB_PROCESSOR PROCTHROTTLEMIN 100

        # Disable CPU parking
        powercfg -setacvalueindex $newSchemeGuid SUB_PROCESSOR CPMINCORES 100

        # PCI Express power management
        powercfg -setacvalueindex $newSchemeGuid SUB_PCIEXPRESS ASPM 0

        # Activate the new profile
        powercfg -setactive $newSchemeGuid
        Write-Success "Created and activated Surface Max Performance power profile"
    }

    # Disable USB selective suspend
    powercfg -setacvalueindex SCHEME_CURRENT 2a737441-1930-4402-8d77-b2bebba308a3 48e6b7a6-50f5-4782-a5d4-53bb8f07e226 0

    # Disable hibernation
    powercfg -h off
    Write-Success "Disabled hibernation (freed ~32GB disk space)"

} catch {
    Write-Warning "Power profile optimization partially failed: $_"
}

# ==============================================================================
# SECTION 6: Edge WebView2 Optimization
# ==============================================================================
Write-Host "`n━━━ EDGE WEBVIEW2 OPTIMIZATION ━━━" -ForegroundColor Yellow

try {
    $regPath = "HKLM:\SOFTWARE\Policies\Microsoft\Edge\WebView2"
    if (-not (Test-Path $regPath)) {
        New-Item -Path $regPath -Force | Out-Null
    }

    # Limit WebView2 process spawning
    Set-ItemProperty -Path $regPath -Name "MaxProcessesPerOrigin" -Value 1
    Set-ItemProperty -Path $regPath -Name "BrowserExecutableFolder" -Value "${env:ProgramFiles(x86)}\Microsoft\EdgeWebView\Application"

    Write-Success "Limited Edge WebView2 process spawning"

} catch {
    Write-Warning "WebView2 optimization failed: $_"
}

# ==============================================================================
# SECTION 7: Visual Effects and UI Optimization
# ==============================================================================
Write-Host "`n━━━ VISUAL EFFECTS OPTIMIZATION ━━━" -ForegroundColor Yellow

try {
    # Set visual effects for best performance
    Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\VisualEffects" -Name "VisualFXSetting" -Value 2

    # Disable specific animations
    Set-ItemProperty -Path "HKCU:\Control Panel\Desktop" -Name "UserPreferencesMask" -Value ([byte[]](0x90,0x12,0x03,0x80,0x10,0x00,0x00,0x00))
    Set-ItemProperty -Path "HKCU:\Control Panel\Desktop\WindowMetrics" -Name "MinAnimate" -Value "0"

    # Disable transparency
    Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Themes\Personalize" -Name "EnableTransparency" -Value 0

    Write-Success "Optimized visual effects for performance"

} catch {
    Write-Warning "Visual effects optimization partially failed: $_"
}

# ==============================================================================
# SECTION 8: Storage Optimization
# ==============================================================================
Write-Host "`n━━━ STORAGE OPTIMIZATION ━━━" -ForegroundColor Yellow

try {
    # Disable Storage Sense
    Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\StorageSense\Parameters\StoragePolicy" -Name "01" -Value 0 -ErrorAction SilentlyContinue

    # Optimize drives
    Write-Status "Running TRIM on SSDs (this may take a moment)..."
    Optimize-Volume -DriveLetter C -ReTrim -ErrorAction SilentlyContinue
    if (Test-Path "G:\") {
        Optimize-Volume -DriveLetter G -ReTrim -ErrorAction SilentlyContinue
    }

    Write-Success "Storage optimization completed"

} catch {
    Write-Warning "Storage optimization partially failed: $_"
}

# ==============================================================================
# SECTION 9: Network Optimization
# ==============================================================================
Write-Host "`n━━━ NETWORK OPTIMIZATION ━━━" -ForegroundColor Yellow

try {
    # Disable network throttling
    Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile" -Name "NetworkThrottlingIndex" -Value 0xffffffff

    # Optimize network adapter settings
    $adapters = Get-NetAdapter | Where-Object {$_.Status -eq "Up"}
    foreach ($adapter in $adapters) {
        # Disable power management for network adapters
        $deviceId = (Get-PnpDevice | Where-Object {$_.FriendlyName -eq $adapter.InterfaceDescription}).InstanceId
        if ($deviceId) {
            $powerMgmt = "HKLM:\SYSTEM\CurrentControlSet\Enum\$deviceId\Device Parameters\Power Management"
            if (Test-Path $powerMgmt) {
                Set-ItemProperty -Path $powerMgmt -Name "EnhancedPowerManagementEnabled" -Value 0 -ErrorAction SilentlyContinue
            }
        }
    }

    Write-Success "Network optimization completed"

} catch {
    Write-Warning "Network optimization partially failed: $_"
}

# ==============================================================================
# SECTION 10: Final Registry Tweaks
# ==============================================================================
Write-Host "`n━━━ FINAL SYSTEM TWEAKS ━━━" -ForegroundColor Yellow

try {
    # Disable Cortana
    $cortanaPath = "HKLM:\SOFTWARE\Policies\Microsoft\Windows\Windows Search"
    if (-not (Test-Path $cortanaPath)) {
        New-Item -Path $cortanaPath -Force | Out-Null
    }
    Set-ItemProperty -Path $cortanaPath -Name "AllowCortana" -Value 0

    # Disable GameDVR
    Set-ItemProperty -Path "HKCU:\System\GameConfigStore" -Name "GameDVR_Enabled" -Value 0
    Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\GameDVR" -Name "AllowGameDVR" -Value 0

    # Reduce shutdown time
    Set-ItemProperty -Path "HKCU:\Control Panel\Desktop" -Name "WaitToKillAppTimeout" -Value "2000"
    Set-ItemProperty -Path "HKCU:\Control Panel\Desktop" -Name "HungAppTimeout" -Value "2000"
    Set-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Control" -Name "WaitToKillServiceTimeout" -Value "2000"

    Write-Success "Applied final system tweaks"

} catch {
    Write-Warning "Some final tweaks failed: $_"
}

# ==============================================================================
# SECTION 11: Clean Temporary Files
# ==============================================================================
Write-Host "`n━━━ TEMPORARY FILE CLEANUP ━━━" -ForegroundColor Yellow

try {
    Write-Status "Cleaning temporary files..."

    $tempPaths = @(
        "$env:TEMP\*",
        "$env:WINDIR\Temp\*",
        "$env:WINDIR\Prefetch\*",
        "$env:LOCALAPPDATA\Microsoft\Windows\Explorer\thumbcache_*.db"
    )

    $cleanedSize = 0
    foreach ($path in $tempPaths) {
        $items = Get-ChildItem -Path $path -Force -ErrorAction SilentlyContinue
        foreach ($item in $items) {
            try {
                $cleanedSize += $item.Length
                Remove-Item -Path $item.FullName -Force -Recurse -ErrorAction SilentlyContinue
            } catch {}
        }
    }

    $cleanedMB = [math]::Round($cleanedSize / 1MB, 2)
    Write-Success "Cleaned $cleanedMB MB of temporary files"

} catch {
    Write-Warning "Temp file cleanup partially failed: $_"
}

# ==============================================================================
# COMPLETION SUMMARY
# ==============================================================================
Write-Host "`n╔═══════════════════════════════════════════════════════════════╗" -ForegroundColor Green
Write-Host   "║              OPTIMIZATION COMPLETE - SUMMARY                  ║" -ForegroundColor Green
Write-Host   "╚═══════════════════════════════════════════════════════════════╝" -ForegroundColor Green

Write-Host "`nChanges Applied:" -ForegroundColor Cyan
$Script:ChangesMade | ForEach-Object { Write-Host "  • $_" -ForegroundColor Gray }

Write-Host "`nRecommended Next Steps:" -ForegroundColor Yellow
Write-Host "  1. Update AMD Graphics Drivers (31.0.24019.1010 or newer)" -ForegroundColor White
Write-Host "  2. Run Windows Update and install any pending updates" -ForegroundColor White
Write-Host "  3. Consider using Process Lasso for further CPU optimization" -ForegroundColor White

if ($Script:RestartRequired) {
    Write-Host "`n⚠ RESTART REQUIRED for all changes to take effect!" -ForegroundColor Red

    $restart = Read-Host "`nRestart now? (Y/N)"
    if ($restart -eq 'Y') {
        Write-Host "Restarting in 10 seconds..." -ForegroundColor Yellow
        Start-Sleep -Seconds 10
        Restart-Computer -Force
    }
} else {
    Write-Host "`n✓ All optimizations applied successfully!" -ForegroundColor Green
}

# Create optimization report
$reportPath = "$env:USERPROFILE\Desktop\SurfaceOptimization_$(Get-Date -Format 'yyyyMMdd_HHmmss').txt"
$Script:ChangesMade | Out-File -FilePath $reportPath
Write-Host "`nOptimization report saved to: $reportPath" -ForegroundColor Cyan
