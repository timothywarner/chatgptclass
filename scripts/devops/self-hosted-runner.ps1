# Configure self-hosted (Windows) runner
# Reference: https://timw.info/zpe

# Create a folder under the drive root
mkdir c:\actions-runner ; cd c:\actions-runner

function calculateDaysBetweenDates {
  param(
    [Parameter(Mandatory=$true)][DateTime]$startDate,
    [Parameter(Mandatory=$true)][DateTime]$endDate
  )
  $days = New-TimeSpan -Start $startDate -End $endDate
  return $days.Days
}

# Download the latest runner package
Invoke-WebRequest -Uri https://github.com/actions/runner/releases/download/v2.311.0/actions-runner-win-x64-2.311.0.zip -OutFile actions-runner-win-x64-2.311.0.zip

# Optional: Validate the hash
$ if((Get-FileHash -Path actions-runner-win-x64-2.311.0.zip -Algorithm SHA256).Hash.ToUpper() -ne 'e629628ce25c1a7032d845f12dfe3dced630ca13a878b037dde77f5683b039dd'.ToUpper()) { throw 'Computed checksum did not match' }

# Extract the installer
Add-Type -AssemblyName System.IO.Compression.FileSystem ; [System.IO.Compression.ZipFile]::ExtractToDirectory("$PWD/actions-runner-win-x64-2.311.0.zip", "$PWD")

# Create the runner and start the configuration experience
./config.cmd --url https://github.com/timothywarner/actions-cert-prep --token ADAK7RYK5IY4BC5GMVII7KDFTQWIW

# Run it!
./run.cmd