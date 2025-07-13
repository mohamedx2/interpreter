# PowerShell script to create a simple ICO file for Hamroun
# This creates a basic 32x32 icon with French flag colors

Add-Type -AssemblyName System.Drawing

# Create a 32x32 bitmap
$bitmap = New-Object System.Drawing.Bitmap(32, 32)
$graphics = [System.Drawing.Graphics]::FromImage($bitmap)

# French flag colors
$blue = [System.Drawing.Color]::FromArgb(0, 85, 164)    # Blue
$white = [System.Drawing.Color]::White                  # White  
$red = [System.Drawing.Color]::FromArgb(239, 65, 53)    # Red

# Draw French flag pattern
$graphics.FillRectangle((New-Object System.Drawing.SolidBrush($blue)), 0, 0, 10, 32)
$graphics.FillRectangle((New-Object System.Drawing.SolidBrush($white)), 10, 0, 12, 32)
$graphics.FillRectangle((New-Object System.Drawing.SolidBrush($red)), 22, 0, 10, 32)

# Add a simple "H" in the center for Hamroun
$font = New-Object System.Drawing.Font("Arial", 14, [System.Drawing.FontStyle]::Bold)
$textBrush = New-Object System.Drawing.SolidBrush([System.Drawing.Color]::Black)
$graphics.DrawString("H", $font, $textBrush, 12, 8)

# Save as PNG first
$bitmap.Save("c:\Users\hamro\Documents\work\interpreter\hamroun_temp.png")

$graphics.Dispose()
$bitmap.Dispose()

Write-Host "Icon base created as hamroun_temp.png"
Write-Host "Converting to ICO format..."

# Convert PNG to ICO using .NET
$icon = [System.Drawing.Icon]::FromHandle($bitmap.GetHicon())
$fileStream = [System.IO.File]::Create("c:\Users\hamro\Documents\work\interpreter\hamroun.ico")
$icon.Save($fileStream)
$fileStream.Close()

Write-Host "Icon created successfully as hamroun.ico"
