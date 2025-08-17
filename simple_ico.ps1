# Simple ICO creation script
Add-Type -AssemblyName System.Drawing

try {
    # Load the 32px PNG
    $bitmap = New-Object System.Drawing.Bitmap("hamroun_pro_32.png")
    
    # Convert to icon handle
    $iconHandle = $bitmap.GetHicon()
    $icon = [System.Drawing.Icon]::FromHandle($iconHandle)
    
    # Save as ICO file
    $fileStream = New-Object System.IO.FileStream("hamroun_pro.ico", [System.IO.FileMode]::Create)
    $icon.Save($fileStream)
    $fileStream.Close()
    
    Write-Host "✅ Created hamroun_pro.ico successfully!"
    
    # Cleanup
    $bitmap.Dispose()
    $icon.Dispose()
    $fileStream.Dispose()
    
} catch {
    Write-Host "❌ Error: $($_.Exception.Message)"
}

# Check file size
if (Test-Path "hamroun_pro.ico") {
    $size = (Get-Item "hamroun_pro.ico").Length
    Write-Host "📊 Icon file size: $size bytes"
}
