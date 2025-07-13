# Create a 16x16 version
Add-Type -AssemblyName System.Drawing

$bitmap = New-Object System.Drawing.Bitmap(16, 16)
$graphics = [System.Drawing.Graphics]::FromImage($bitmap)

$blue = [System.Drawing.Color]::FromArgb(0, 85, 164)
$white = [System.Drawing.Color]::White 
$red = [System.Drawing.Color]::FromArgb(239, 65, 53)

$graphics.Clear($blue)
$graphics.FillRectangle((New-Object System.Drawing.SolidBrush($white)), 5, 0, 6, 16)
$graphics.FillRectangle((New-Object System.Drawing.SolidBrush($red)), 11, 0, 5, 16)

$font = New-Object System.Drawing.Font("Arial", 8, [System.Drawing.FontStyle]::Bold)
$brush = New-Object System.Drawing.SolidBrush([System.Drawing.Color]::Black)
$graphics.DrawString("H", $font, $brush, 5, 4)

$bitmap.Save("winres\icon16.png", [System.Drawing.Imaging.ImageFormat]::Png)

$graphics.Dispose()
$bitmap.Dispose()

Write-Host "16x16 icon created"
