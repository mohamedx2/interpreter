# Cross-compilation script for Hamroun French Programming Language
Write-Host "Cross-compilation pour Hamroun French Programming Language"
Write-Host "=========================================================="

# Create builds directory
if (!(Test-Path "builds")) {
    New-Item -ItemType Directory -Name "builds"
    Write-Host "Created builds directory"
}

# Set Go environment for cross-compilation
$env:CGO_ENABLED = "0"

Write-Host "Building for multiple platforms..."

# Windows AMD64
Write-Host "Building Windows 64-bit..."
$env:GOOS = "windows"
$env:GOARCH = "amd64"
go build -ldflags "-s -w" -o "builds/hamroun-windows-amd64.exe" hamroun.go
if ($LASTEXITCODE -eq 0) { Write-Host "  SUCCESS: hamroun-windows-amd64.exe" }

# Linux AMD64
Write-Host "Building Linux 64-bit..."
$env:GOOS = "linux"
$env:GOARCH = "amd64"
go build -ldflags "-s -w" -o "builds/hamroun-linux-amd64" hamroun.go
if ($LASTEXITCODE -eq 0) { Write-Host "  SUCCESS: hamroun-linux-amd64" }

# Linux ARM64
Write-Host "Building Linux ARM64..."
$env:GOOS = "linux"
$env:GOARCH = "arm64"
go build -ldflags "-s -w" -o "builds/hamroun-linux-arm64" hamroun.go
if ($LASTEXITCODE -eq 0) { Write-Host "  SUCCESS: hamroun-linux-arm64" }

# macOS AMD64 (Intel)
Write-Host "Building macOS Intel..."
$env:GOOS = "darwin"
$env:GOARCH = "amd64"
go build -ldflags "-s -w" -o "builds/hamroun-darwin-amd64" hamroun.go
if ($LASTEXITCODE -eq 0) { Write-Host "  SUCCESS: hamroun-darwin-amd64" }

# macOS ARM64 (Apple Silicon)
Write-Host "Building macOS Apple Silicon..."
$env:GOOS = "darwin"
$env:GOARCH = "arm64"
go build -ldflags "-s -w" -o "builds/hamroun-darwin-arm64" hamroun.go
if ($LASTEXITCODE -eq 0) { Write-Host "  SUCCESS: hamroun-darwin-arm64" }

# Reset environment
Remove-Item Env:GOOS -ErrorAction SilentlyContinue
Remove-Item Env:GOARCH -ErrorAction SilentlyContinue
$env:CGO_ENABLED = "1"

Write-Host ""
Write-Host "BUILD RESULTS:"
Write-Host "=============="
if (Test-Path "builds") {
    Get-ChildItem "builds" | ForEach-Object {
        $size = [math]::Round($_.Length / 1MB, 2)
        Write-Host "$($_.Name) - ${size} MB"
    }
    Write-Host ""
    Write-Host "All builds completed successfully!"
    Write-Host "Files are in the builds/ directory"
}
