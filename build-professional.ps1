# Professional Build Automation Script for Hamroun
# Version: 1.0.0
# Author: Mohamed Ali Hamroun

param(
    [string]$Version = "1.0.0",
    [switch]$CrossPlatform = $false,
    [switch]$WithIcon = $true,
    [switch]$CreateDist = $true
)

Write-Host "HAMROUN PROFESSIONAL BUILD SYSTEM" -ForegroundColor Cyan
Write-Host "=====================================" -ForegroundColor Cyan
Write-Host "Version: $Version" -ForegroundColor White
Write-Host ""

$ErrorActionPreference = "Stop"
$startTime = Get-Date

# Define directories
$rootDir = $PSScriptRoot
$srcDir = Join-Path $rootDir "src"
$binDir = Join-Path $rootDir "bin"
$distDir = Join-Path $rootDir "dist"

# Create directories
Write-Host "Creating directory structure..." -ForegroundColor Yellow
@($binDir, $distDir) | ForEach-Object {
    if (-not (Test-Path $_)) {
        New-Item -ItemType Directory -Path $_ | Out-Null
        Write-Host "   Created: $_" -ForegroundColor Gray
    }
}

# Set Go environment
$env:CGO_ENABLED = "0"

# Build Windows version
Write-Host "`nBuilding Windows version..." -ForegroundColor Yellow
$env:GOOS = "windows"
$env:GOARCH = "amd64"

$windowsExe = Join-Path $binDir "hamroun-v$Version-windows-amd64.exe"

if ($WithIcon -and (Test-Path "hamroun_pro.syso")) {
    Write-Host "   Including embedded icon..." -ForegroundColor Gray
}

go build -ldflags "-s -w -X main.Version=$Version" -o $windowsExe hamroun.go

if ($LASTEXITCODE -eq 0) {
    $size = [math]::Round((Get-Item $windowsExe).Length / 1MB, 2)
    Write-Host "   Windows build complete: $size MB" -ForegroundColor Green
} else {
    Write-Host "   Windows build failed" -ForegroundColor Red
    exit 1
}

# Cross-platform builds
if ($CrossPlatform) {
    Write-Host "`nBuilding cross-platform versions..." -ForegroundColor Yellow
    
    # Linux AMD64
    Write-Host "   Linux AMD64..." -ForegroundColor Gray
    $env:GOOS = "linux"
    $env:GOARCH = "amd64"
    go build -ldflags "-s -w -X main.Version=$Version" -o (Join-Path $binDir "hamroun-v$Version-linux-amd64") hamroun.go
    
    # Linux ARM64
    Write-Host "   Linux ARM64..." -ForegroundColor Gray
    $env:GOARCH = "arm64"
    go build -ldflags "-s -w -X main.Version=$Version" -o (Join-Path $binDir "hamroun-v$Version-linux-arm64") hamroun.go
    
    # macOS AMD64
    Write-Host "   macOS AMD64..." -ForegroundColor Gray
    $env:GOOS = "darwin"
    $env:GOARCH = "amd64"
    go build -ldflags "-s -w -X main.Version=$Version" -o (Join-Path $binDir "hamroun-v$Version-darwin-amd64") hamroun.go
    
    # macOS ARM64
    Write-Host "   macOS ARM64..." -ForegroundColor Gray
    $env:GOARCH = "arm64"
    go build -ldflags "-s -w -X main.Version=$Version" -o (Join-Path $binDir "hamroun-v$Version-darwin-arm64") hamroun.go
    
    Write-Host "   Cross-platform builds complete" -ForegroundColor Green
}

# Create distribution packages
if ($CreateDist) {
    Write-Host "`nCreating distribution packages..." -ForegroundColor Yellow
    
    # Windows package
    $winDistDir = Join-Path $distDir "hamroun-v$Version-windows"
    if (Test-Path $winDistDir) { Remove-Item -Recurse -Force $winDistDir }
    New-Item -ItemType Directory -Path $winDistDir | Out-Null
    
    Copy-Item $windowsExe -Destination (Join-Path $winDistDir "hamroun.exe")
    Copy-Item "README.md" -Destination $winDistDir -ErrorAction SilentlyContinue
    Copy-Item "LICENSE" -Destination $winDistDir -ErrorAction SilentlyContinue
    Copy-Item -Path "exemples" -Destination $winDistDir -Recurse -ErrorAction SilentlyContinue
    
    # Create README for distribution
    $readmeLines = @(
        "# Hamroun French Programming Language v$Version",
        "",
        "## Installation",
        "1. Add hamroun.exe to your PATH",
        "2. Run: hamroun.exe fichier.hamroun",
        "",
        "## Examples",
        "See the exemples/ folder for sample programs.",
        "",
        "## Documentation",
        "Visit: https://github.com/mohamedx2/interpreter",
        "",
        "## Support",
        "Report issues: https://github.com/mohamedx2/interpreter/issues",
        "",
        "---",
        "Copyright 2025 Mohamed Ali Hamroun"
    )
    $readmeLines | Out-File -FilePath (Join-Path $winDistDir "README.txt") -Encoding UTF8
    
    # Create ZIP archive
    $zipFile = Join-Path $distDir "hamroun-v$Version-windows.zip"
    if (Test-Path $zipFile) { Remove-Item -Force $zipFile }
    
    Compress-Archive -Path "$winDistDir\*" -DestinationPath $zipFile
    $zipSize = [math]::Round((Get-Item $zipFile).Length / 1MB, 2)
    Write-Host "   Windows package: $zipSize MB" -ForegroundColor Green
    
    if ($CrossPlatform) {
        # Linux package
        $linuxDistDir = Join-Path $distDir "hamroun-v$Version-linux"
        if (Test-Path $linuxDistDir) { Remove-Item -Recurse -Force $linuxDistDir }
        New-Item -ItemType Directory -Path $linuxDistDir | Out-Null
        
        Copy-Item (Join-Path $binDir "hamroun-v$Version-linux-amd64") -Destination (Join-Path $linuxDistDir "hamroun")
        Copy-Item "README.md" -Destination $linuxDistDir -ErrorAction SilentlyContinue
        Copy-Item -Path "exemples" -Destination $linuxDistDir -Recurse -ErrorAction SilentlyContinue
        
        $tarFile = Join-Path $distDir "hamroun-v$Version-linux.tar.gz"
        tar -czf $tarFile -C $distDir (Split-Path $linuxDistDir -Leaf)
        Write-Host "   Linux package created" -ForegroundColor Green
        
        # macOS package
        $macDistDir = Join-Path $distDir "hamroun-v$Version-macos"
        if (Test-Path $macDistDir) { Remove-Item -Recurse -Force $macDistDir }
        New-Item -ItemType Directory -Path $macDistDir | Out-Null
        
        Copy-Item (Join-Path $binDir "hamroun-v$Version-darwin-amd64") -Destination (Join-Path $macDistDir "hamroun")
        Copy-Item "README.md" -Destination $macDistDir -ErrorAction SilentlyContinue
        Copy-Item -Path "exemples" -Destination $macDistDir -Recurse -ErrorAction SilentlyContinue
        
        $tarFile = Join-Path $distDir "hamroun-v$Version-macos.tar.gz"
        tar -czf $tarFile -C $distDir (Split-Path $macDistDir -Leaf)
        Write-Host "   macOS package created" -ForegroundColor Green
    }
}

# Generate build info
$buildInfoLines = @(
    "Hamroun Build Information",
    "========================",
    "",
    "Build Date: $(Get-Date -Format 'yyyy-MM-dd HH:mm:ss')",
    "Version: $Version",
    "Builder: $env:USERNAME@$env:COMPUTERNAME",
    "",
    "Binaries:"
)

Get-ChildItem $binDir -File | ForEach-Object {
    $size = [math]::Round($_.Length / 1MB, 2)
    $buildInfoLines += "  - $($_.Name): $size MB"
}

$buildInfoLines | Out-File -FilePath (Join-Path $binDir "BUILD_INFO.txt") -Encoding UTF8

# Summary
$duration = (Get-Date) - $startTime
Write-Host ""
Write-Host "BUILD COMPLETE!" -ForegroundColor Green
Write-Host "=====================================" -ForegroundColor Cyan
Write-Host "Duration: $([math]::Round($duration.TotalSeconds, 2)) seconds" -ForegroundColor White
Write-Host "Binaries: $binDir" -ForegroundColor White
if ($CreateDist) {
    Write-Host "Packages: $distDir" -ForegroundColor White
}
Write-Host ""
Write-Host "Ready for distribution!" -ForegroundColor Green
