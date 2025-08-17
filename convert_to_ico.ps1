# Convert PNG files to ICO format
Add-Type -AssemblyName System.Drawing

$pngFiles = @(
    "hamroun_pro_16.png",
    "hamroun_pro_24.png", 
    "hamroun_pro_32.png",
    "hamroun_pro_48.png",
    "hamroun_pro_64.png",
    "hamroun_pro_128.png",
    "hamroun_pro_256.png"
)

Write-Host "🔄 Converting PNGs to multi-resolution ICO..."

# Method 1: Use the largest PNG as base
$largestPng = "hamroun_pro_256.png"
if (Test-Path $largestPng) {
    $image = [System.Drawing.Image]::FromFile((Resolve-Path $largestPng).Path)
    $icon = [System.Drawing.Icon]::FromHandle($image.GetHbitmap())
    
    # Save as ICO
    $fs = [System.IO.FileStream]::new("hamroun_pro.ico", [System.IO.FileMode]::Create)
    $icon.Save($fs)
    $fs.Close()
    
    Write-Host "✅ Created hamroun_pro.ico from $largestPng"
    
    # Cleanup
    $image.Dispose()
    $icon.Dispose()
}

# Method 2: Create a simple ICO using .NET
try {
    $bitmap = [System.Drawing.Bitmap]::new("hamroun_pro_32.png")
    $iconHandle = $bitmap.GetHicon()
    $icon = [System.Drawing.Icon]::FromHandle($iconHandle)
    
    $fileStream = [System.IO.FileStream]::new("hamroun_pro_simple.ico", [System.IO.FileMode]::Create)
    $icon.Save($fileStream)
    $fileStream.Close()
    
    Write-Host "✅ Created hamroun_pro_simple.ico"
    
    $bitmap.Dispose()
    $icon.Dispose()
} catch {
    Write-Host "❌ Error creating simple ICO: $_"
}

Write-Host "🎨 Professional icon files created!"
Write-Host "📁 Available files:"
Get-ChildItem "hamroun_pro*.ico" | ForEach-Object { Write-Host "   - $($_.Name)" }
