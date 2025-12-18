# Create distribution packages for Hamroun
Write-Host "Creating distribution packages..."

# Create distribution directories
$distDir = "dist"
if (Test-Path $distDir) { Remove-Item -Recurse -Force $distDir }
New-Item -ItemType Directory -Name $distDir | Out-Null

# Windows Package
Write-Host "Creating Windows package..."
$winDir = "$distDir/hamroun-windows"
New-Item -ItemType Directory -Path $winDir | Out-Null
Copy-Item "builds/hamroun-windows-amd64.exe" "$winDir/hamroun.exe"
Copy-Item "builds/README.md" "$winDir/"
Copy-Item "builds/demo.hamroun" "$winDir/"
Copy-Item "builds/simple.hamroun" "$winDir/"

# Create Windows installer script
$batchContent = @'
@echo off
echo Hamroun French Programming Language - Windows Installer
echo ======================================================
echo.
echo Installation en cours...
copy hamroun.exe "%USERPROFILE%\hamroun.exe"
echo.
echo Installation terminee!
echo.
echo UTILISATION:
echo    %USERPROFILE%\hamroun.exe fichier.hamroun
echo    %USERPROFILE%\hamroun.exe   (pour le mode interactif)
echo.
echo TEST:
echo    %USERPROFILE%\hamroun.exe simple.hamroun
echo.
pause
'@

$batchContent | Out-File -FilePath "$winDir/install.bat" -Encoding ASCII

Compress-Archive -Path "$winDir/*" -DestinationPath "$distDir/hamroun-windows.zip" -Force

# Linux Package
Write-Host "Creating Linux package..."
$linuxDir = "$distDir/hamroun-linux"
New-Item -ItemType Directory -Path $linuxDir | Out-Null
Copy-Item "builds/hamroun-linux-amd64" "$linuxDir/hamroun"
Copy-Item "builds/hamroun-linux-arm64" "$linuxDir/hamroun-arm64"
Copy-Item "builds/install.sh" "$linuxDir/"
Copy-Item "builds/README.md" "$linuxDir/"
Copy-Item "builds/demo.hamroun" "$linuxDir/"
Copy-Item "builds/simple.hamroun" "$linuxDir/"

Compress-Archive -Path "$linuxDir/*" -DestinationPath "$distDir/hamroun-linux.zip" -Force

# macOS Package  
Write-Host "Creating macOS package..."
$macDir = "$distDir/hamroun-macos"
New-Item -ItemType Directory -Path $macDir | Out-Null
Copy-Item "builds/hamroun-darwin-amd64" "$macDir/hamroun-intel"
Copy-Item "builds/hamroun-darwin-arm64" "$macDir/hamroun-apple-silicon"
Copy-Item "builds/create_macos_app.sh" "$macDir/"
Copy-Item "builds/install.sh" "$macDir/"
Copy-Item "builds/README.md" "$macDir/"
Copy-Item "builds/demo.hamroun" "$macDir/"
Copy-Item "builds/simple.hamroun" "$macDir/"

Compress-Archive -Path "$macDir/*" -DestinationPath "$distDir/hamroun-macos.zip" -Force

Write-Host ""
Write-Host "PACKAGES CREATED:"
Write-Host "================="
Get-ChildItem $distDir | ForEach-Object {
    $size = if ($_.PSIsContainer) { "Directory" } else { [math]::Round($_.Length / 1MB, 2).ToString() + " MB" }
    Write-Host "$($_.Name) - $size"
}

Write-Host ""
Write-Host "DISTRIBUTION READY!"
Write-Host "hamroun-windows.zip  - For Windows"
Write-Host "hamroun-linux.zip    - For Linux" 
Write-Host "hamroun-macos.zip    - For macOS"
Write-Host ""
Write-Host "Hamroun French Programming Language ready for worldwide distribution!"
