# PowerShell script to build and package VS Code extension

Write-Host "🔨 Building Hamroun VS Code Extension" -ForegroundColor Cyan
Write-Host "=====================================" -ForegroundColor Cyan

# Navigate to extension directory
$extensionDir = Join-Path $PSScriptRoot "vscode-extension"
Set-Location $extensionDir

# Check if Node.js is installed
Write-Host "`n📦 Checking dependencies..." -ForegroundColor Yellow
$nodeVersion = node --version 2>$null
if ($LASTEXITCODE -ne 0) {
    Write-Host "❌ Node.js is not installed. Please install Node.js first." -ForegroundColor Red
    Write-Host "   Download from: https://nodejs.org/" -ForegroundColor Yellow
    exit 1
}
Write-Host "✅ Node.js: $nodeVersion" -ForegroundColor Green

# Check if npm is installed
$npmVersion = npm --version 2>$null
if ($LASTEXITCODE -ne 0) {
    Write-Host "❌ npm is not installed." -ForegroundColor Red
    exit 1
}
Write-Host "✅ npm: $npmVersion" -ForegroundColor Green

# Install dependencies if needed
if (-not (Test-Path "node_modules")) {
    Write-Host "`n📥 Installing dependencies..." -ForegroundColor Yellow
    npm install
    if ($LASTEXITCODE -ne 0) {
        Write-Host "❌ Failed to install dependencies" -ForegroundColor Red
        exit 1
    }
    Write-Host "✅ Dependencies installed" -ForegroundColor Green
}

# Install vsce if not present
Write-Host "`n🔧 Checking VSCE (VS Code Extension Manager)..." -ForegroundColor Yellow
$vsceInstalled = (npm list -g @vscode/vsce 2>$null) -match "@vscode/vsce"
if (-not $vsceInstalled) {
    Write-Host "📥 Installing VSCE globally..." -ForegroundColor Yellow
    npm install -g @vscode/vsce
    if ($LASTEXITCODE -ne 0) {
        Write-Host "⚠️  Failed to install VSCE globally. Trying local install..." -ForegroundColor Yellow
        npm install @vscode/vsce --save-dev
    }
}
Write-Host "✅ VSCE is ready" -ForegroundColor Green

# Compile TypeScript
Write-Host "`n🔨 Compiling TypeScript..." -ForegroundColor Yellow
npm run compile
if ($LASTEXITCODE -ne 0) {
    Write-Host "❌ TypeScript compilation failed" -ForegroundColor Red
    exit 1
}
Write-Host "✅ TypeScript compiled" -ForegroundColor Green

# Package extension
Write-Host "`n📦 Packaging extension..." -ForegroundColor Yellow
npm run package
if ($LASTEXITCODE -ne 0) {
    Write-Host "❌ Extension packaging failed" -ForegroundColor Red
    exit 1
}

# Find the generated VSIX file
$vsixFile = Get-ChildItem -Path $extensionDir -Filter "*.vsix" | Select-Object -First 1

if ($vsixFile) {
    Write-Host "`n✅ Extension packaged successfully!" -ForegroundColor Green
    Write-Host "📁 File: $($vsixFile.Name)" -ForegroundColor Cyan
    Write-Host "📍 Location: $($vsixFile.FullName)" -ForegroundColor Cyan
    Write-Host "📊 Size: $([math]::Round($vsixFile.Length / 1KB, 2)) KB" -ForegroundColor Cyan
    
    Write-Host "`n📝 Installation Instructions:" -ForegroundColor Yellow
    Write-Host "   1. Open VS Code" -ForegroundColor White
    Write-Host "   2. Press Ctrl+Shift+X (Extensions)" -ForegroundColor White
    Write-Host "   3. Click '...' → 'Install from VSIX...'" -ForegroundColor White
    Write-Host "   4. Select: $($vsixFile.FullName)" -ForegroundColor White
    
    Write-Host "`n💡 Or install from command line:" -ForegroundColor Yellow
    Write-Host "   code --install-extension $($vsixFile.Name)" -ForegroundColor Cyan
    
    # Ask if user wants to install now
    Write-Host "`n🚀 Install extension now? (Y/N): " -NoNewline -ForegroundColor Yellow
    $install = Read-Host
    if ($install -eq "Y" -or $install -eq "y") {
        Write-Host "`n📦 Installing extension..." -ForegroundColor Yellow
        code --install-extension $vsixFile.FullName
        if ($LASTEXITCODE -eq 0) {
            Write-Host "✅ Extension installed successfully!" -ForegroundColor Green
            Write-Host "🔄 Please reload VS Code to activate the extension." -ForegroundColor Yellow
        } else {
            Write-Host "❌ Installation failed. Please install manually." -ForegroundColor Red
        }
    }
    
} else {
    Write-Host "`n❌ No VSIX file found" -ForegroundColor Red
    exit 1
}

Write-Host "`n✨ Build complete!" -ForegroundColor Green
