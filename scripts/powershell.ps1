# Install IIS
Install-WindowsFeature -Name Web-Server -IncludeManagementTools

# Create a website
$websiteName = "MyWebsite"
$websitePath = "C:\inetpub\wwwroot\$websiteName"
New-Item -ItemType Directory -Path $websitePath

# Create a default webpage
$defaultPagePath = "$websitePath\index.html"
@"
<!DOCTYPE html>
<html>
<head>
    <title>Welcome to $websiteName</title>
</head>
<body>
    <h1>Welcome to $websiteName</h1>
    <p>This is a simple website created using PowerShell and IIS.</p>
</body>
</html>
"@ | Out-File -FilePath $defaultPagePath

# Configure the website in IIS
$site = New-WebSite -Name $websiteName -PhysicalPath $websitePath -Port 80
$binding = Get-WebBinding -Name $websiteName -Port 80
$binding.AddSslCertificate("0.0.0.0", "MyCertificateThumbprint")
Set-WebBinding -Name $websiteName -BindingInformation $binding.BindingInformation

# Start the website
Start-WebSite -Name $websiteName

