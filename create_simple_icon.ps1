# Simple PowerShell script to create a basic ICO file
Add-Type -AssemblyName System.Drawing

# Create a 32x32 bitmap
$size = 32
$bitmap = New-Object System.Drawing.Bitmap($size, $size)

# Create graphics object
$graphics = [System.Drawing.Graphics]::FromImage($bitmap)
$graphics.SmoothingMode = [System.Drawing.Drawing2D.SmoothingMode]::AntiAlias

# French flag colors
$blue = [System.Drawing.Color]::FromArgb(0, 85, 164)
$white = [System.Drawing.Color]::White
$red = [System.Drawing.Color]::FromArgb(239, 65, 53)

# Fill background
$graphics.Clear($white)

# Draw French flag stripes
$stripWidth = $size / 3
$graphics.FillRectangle((New-Object System.Drawing.SolidBrush($blue)), 0, 0, $stripWidth, $size)
$graphics.FillRectangle((New-Object System.Drawing.SolidBrush($red)), $stripWidth * 2, 0, $stripWidth, $size)

# Add "H" for Hamroun
$font = New-Object System.Drawing.Font("Arial", 18, [System.Drawing.FontStyle]::Bold)
$brush = New-Object System.Drawing.SolidBrush([System.Drawing.Color]::Black)
$format = New-Object System.Drawing.StringFormat
$format.Alignment = [System.Drawing.StringAlignment]::Center
$format.LineAlignment = [System.Drawing.StringAlignment]::Center
$rect = New-Object System.Drawing.Rectangle(0, 0, $size, $size)
$graphics.DrawString("H", $font, $brush, $rect, $format)

# Save as PNG first
$bitmap.Save("c:\Users\hamro\Documents\work\interpreter\hamroun.png", [System.Drawing.Imaging.ImageFormat]::Png)

$graphics.Dispose()
$bitmap.Dispose()

Write-Host "Icon created as hamroun.png"
