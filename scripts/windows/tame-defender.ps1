# Run as Admin - Add performance exclusions
Add-MpPreference -ExclusionPath "C:\Users\tim\AppData\Local\Temp"
Add-MpPreference -ExclusionPath "C:\Windows\Temp"
Add-MpPreference -ExclusionPath "C:\Users\tim\Downloads"
Add-MpPreference -ExclusionProcess "chrome.exe"
Add-MpPreference -ExclusionProcess "msedgewebview2.exe"
Add-MpPreference -ExclusionProcess "node.exe"
Add-MpPreference -ExclusionProcess "python.exe"
Add-MpPreference -ExclusionProcess "code.exe"

# Reduce real-time scanning aggressiveness
Set-MpPreference -ScanAvgCPULoadFactor 25
Set-MpPreference -DisableCpuThrottleOnIdleScans $false

# Disable cloud-based protection (major CPU hog)
Set-MpPreference -MAPSReporting 0
Set-MpPreference -SubmitSamplesConsent 2
