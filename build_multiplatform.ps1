# Cross-compilation script for Hamroun French Programming Language
# Compiles for Windows, Linux, and macOS

Write-Host "🌍 COMPILATION MULTI-PLATEFORME HAMROUN"
Write-Host "========================================"
Write-Host ""

# Create builds directory
if (!(Test-Path "builds")) {
    New-Item -ItemType Directory -Name "builds"
    Write-Host "📁 Créé le répertoire builds/"
}

# Set Go environment for cross-compilation
$env:CGO_ENABLED = "0"

Write-Host "🔧 Compilation en cours..."
Write-Host ""

# Windows AMD64 (current platform)
Write-Host "🪟 Windows 64-bit..."
$env:GOOS = "windows"
$env:GOARCH = "amd64"
go build -ldflags "-s -w" -o "builds/hamroun-windows-amd64.exe" hamroun.go
if ($LASTEXITCODE -eq 0) {
    Write-Host "   ✅ hamroun-windows-amd64.exe"
} else {
    Write-Host "   ❌ Erreur compilation Windows"
}

# Windows 32-bit
Write-Host "🪟 Windows 32-bit..."
$env:GOOS = "windows"
$env:GOARCH = "386"
go build -ldflags "-s -w" -o "builds/hamroun-windows-386.exe" hamroun.go
if ($LASTEXITCODE -eq 0) {
    Write-Host "   ✅ hamroun-windows-386.exe"
} else {
    Write-Host "   ❌ Erreur compilation Windows 32-bit"
}

# Linux AMD64
Write-Host "🐧 Linux 64-bit..."
$env:GOOS = "linux"
$env:GOARCH = "amd64"
go build -ldflags "-s -w" -o "builds/hamroun-linux-amd64" hamroun.go
if ($LASTEXITCODE -eq 0) {
    Write-Host "   ✅ hamroun-linux-amd64"
} else {
    Write-Host "   ❌ Erreur compilation Linux"
}

# Linux ARM64 (for Raspberry Pi, ARM servers)
Write-Host "🐧 Linux ARM64..."
$env:GOOS = "linux"
$env:GOARCH = "arm64"
go build -ldflags "-s -w" -o "builds/hamroun-linux-arm64" hamroun.go
if ($LASTEXITCODE -eq 0) {
    Write-Host "   ✅ hamroun-linux-arm64"
} else {
    Write-Host "   ❌ Erreur compilation Linux ARM64"
}

# macOS AMD64 (Intel Macs)
Write-Host "🍎 macOS Intel 64-bit..."
$env:GOOS = "darwin"
$env:GOARCH = "amd64"
go build -ldflags "-s -w" -o "builds/hamroun-darwin-amd64" hamroun.go
if ($LASTEXITCODE -eq 0) {
    Write-Host "   ✅ hamroun-darwin-amd64"
} else {
    Write-Host "   ❌ Erreur compilation macOS Intel"
}

# macOS ARM64 (Apple Silicon M1/M2/M3)
Write-Host "🍎 macOS Apple Silicon (M1/M2/M3)..."
$env:GOOS = "darwin"
$env:GOARCH = "arm64"
go build -ldflags "-s -w" -o "builds/hamroun-darwin-arm64" hamroun.go
if ($LASTEXITCODE -eq 0) {
    Write-Host "   ✅ hamroun-darwin-arm64"
} else {
    Write-Host "   ❌ Erreur compilation macOS Apple Silicon"
}

# FreeBSD AMD64
Write-Host "🐡 FreeBSD 64-bit..."
$env:GOOS = "freebsd"
$env:GOARCH = "amd64"
go build -ldflags "-s -w" -o "builds/hamroun-freebsd-amd64" hamroun.go
if ($LASTEXITCODE -eq 0) {
    Write-Host "   ✅ hamroun-freebsd-amd64"
} else {
    Write-Host "   ❌ Erreur compilation FreeBSD"
}

# Reset environment
Remove-Item Env:GOOS -ErrorAction SilentlyContinue
Remove-Item Env:GOARCH -ErrorAction SilentlyContinue
$env:CGO_ENABLED = "1"

Write-Host ""
Write-Host "📊 RÉSULTATS DE COMPILATION:"
Write-Host "============================="

if (Test-Path "builds") {
    $builds = Get-ChildItem "builds" | Sort-Object Name
    foreach ($build in $builds) {
        $size = [math]::Round($build.Length / 1MB, 2)
        Write-Host "📦 $($build.Name) - ${size} MB"
    }
    
    Write-Host ""
    Write-Host "🎉 Compilation terminée!"
    Write-Host "📁 Tous les exécutables sont dans le dossier builds/"
    Write-Host ""
    Write-Host "🚀 UTILISATION:"
    Write-Host "   Linux/macOS: ./hamroun-[platform] fichier.hamroun"
    Write-Host "   Windows:     hamroun-[platform].exe fichier.hamroun"
    Write-Host ""
    Write-Host "🌍 Hamroun French Programming Language disponible sur:"
    Write-Host "   Windows (32-bit et 64-bit)"
    Write-Host "   Linux (AMD64 et ARM64)"
    Write-Host "   macOS (Intel et Apple Silicon)"
    Write-Host "   FreeBSD"
} else {
    Write-Host "Aucun exécutable généré"
}
