# Create a proper 32x32 icon using .NET
Add-Type -AssemblyName System.Drawing

# Create bitmap
$bitmap = New-Object System.Drawing.Bitmap(32, 32)
$graphics = [System.Drawing.Graphics]::FromImage($bitmap)

# French flag colors
$blue = [System.Drawing.Color]::FromArgb(0, 85, 164)
$white = [System.Drawing.Color]::White 
$red = [System.Drawing.Color]::FromArgb(239, 65, 53)

# Clear and draw flag
$graphics.Clear($blue)
$graphics.FillRectangle((New-Object System.Drawing.SolidBrush($white)), 10, 0, 12, 32)
$graphics.FillRectangle((New-Object System.Drawing.SolidBrush($red)), 22, 0, 10, 32)

# Add H
$font = New-Object System.Drawing.Font("Arial", 16, [System.Drawing.FontStyle]::Bold)
$brush = New-Object System.Drawing.SolidBrush([System.Drawing.Color]::Black)
$graphics.DrawString("H", $font, $brush, 11, 8)

# Save as BMP first (more reliable)
$bitmap.Save("hamroun.bmp", [System.Drawing.Imaging.ImageFormat]::Bmp)

$graphics.Dispose()
$bitmap.Dispose()

Write-Host "BMP created successfully"
