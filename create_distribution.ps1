# Create distribution packages for Hamroun French Programming Language

Write-Host "📦 CRÉATION DES PACKAGES DE DISTRIBUTION HAMROUN"
Write-Host "==============================================="

# Create distribution directories
$distDir = "dist"
if (Test-Path $distDir) { Remove-Item -Recurse -Force $distDir }
New-Item -ItemType Directory -Name $distDir | Out-Null

# Windows Package
Write-Host "🪟 Creating Windows package..."
$winDir = "$distDir/hamroun-windows"
New-Item -ItemType Directory -Path $winDir | Out-Null
Copy-Item "builds/hamroun-windows-amd64.exe" "$winDir/hamroun.exe"
Copy-Item "builds/README.md" "$winDir/"
Copy-Item "builds/demo.hamroun" "$winDir/"
Copy-Item "builds/simple.hamroun" "$winDir/"

# Create Windows installer script
@"
@echo off
echo 🇫🇷 HAMROUN FRENCH PROGRAMMING LANGUAGE - WINDOWS INSTALLER
echo ==========================================================
echo.
echo Installation en cours...
copy hamroun.exe "%USERPROFILE%\hamroun.exe"
echo.
echo ✅ Installation terminée!
echo.
echo 📚 UTILISATION:
echo    %USERPROFILE%\hamroun.exe fichier.hamroun
echo    %USERPROFILE%\hamroun.exe   (pour le mode interactif)
echo.
echo 🧪 TEST:
echo    %USERPROFILE%\hamroun.exe simple.hamroun
echo.
pause
"@ | Out-File -FilePath "$winDir/install.bat" -Encoding ASCII

Compress-Archive -Path "$winDir/*" -DestinationPath "$distDir/hamroun-windows.zip" -Force

# Linux Package
Write-Host "🐧 Creating Linux package..."
$linuxDir = "$distDir/hamroun-linux"
New-Item -ItemType Directory -Path $linuxDir | Out-Null
Copy-Item "builds/hamroun-linux-amd64" "$linuxDir/hamroun"
Copy-Item "builds/hamroun-linux-arm64" "$linuxDir/hamroun-arm64"
Copy-Item "builds/install.sh" "$linuxDir/"
Copy-Item "builds/README.md" "$linuxDir/"
Copy-Item "builds/demo.hamroun" "$linuxDir/"
Copy-Item "builds/simple.hamroun" "$linuxDir/"

# Create tar.gz for Linux
if (Get-Command tar -ErrorAction SilentlyContinue) {
    cd $distDir
    tar -czf "hamroun-linux.tar.gz" -C hamroun-linux .
    cd ..
} else {
    Compress-Archive -Path "$linuxDir/*" -DestinationPath "$distDir/hamroun-linux.zip" -Force
}

# macOS Package  
Write-Host "🍎 Creating macOS package..."
$macDir = "$distDir/hamroun-macos"
New-Item -ItemType Directory -Path $macDir | Out-Null
Copy-Item "builds/hamroun-darwin-amd64" "$macDir/hamroun-intel"
Copy-Item "builds/hamroun-darwin-arm64" "$macDir/hamroun-apple-silicon"
Copy-Item "builds/create_macos_app.sh" "$macDir/"
Copy-Item "builds/install.sh" "$macDir/"
Copy-Item "builds/README.md" "$macDir/"
Copy-Item "builds/demo.hamroun" "$macDir/"
Copy-Item "builds/simple.hamroun" "$macDir/"

if (Get-Command tar -ErrorAction SilentlyContinue) {
    cd $distDir
    tar -czf "hamroun-macos.tar.gz" -C hamroun-macos .
    cd ..
} else {
    Compress-Archive -Path "$macDir/*" -DestinationPath "$distDir/hamroun-macos.zip" -Force
}

Write-Host ""
Write-Host "✅ PACKAGES CRÉÉS:"
Write-Host "=================="
Get-ChildItem $distDir | ForEach-Object {
    $size = if ($_.PSIsContainer) { "Directory" } else { [math]::Round($_.Length / 1MB, 2).ToString() + " MB" }
    Write-Host "📦 $($_.Name) - $size"
}

Write-Host ""
Write-Host "🌍 DISTRIBUTION READY:"
Write-Host "====================="
Write-Host "📦 hamroun-windows.zip  - Pour Windows (tous versions)"
Write-Host "📦 hamroun-linux.tar.gz - Pour Linux (AMD64 & ARM64)" 
Write-Host "📦 hamroun-macos.tar.gz - Pour macOS (Intel & Apple Silicon)"
Write-Host ""
Write-Host "🇫🇷 Hamroun French Programming Language prêt pour distribution mondiale!"
