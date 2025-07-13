# Create proper PNG icons for go-winres
Add-Type -AssemblyName System.Drawing

# Create 32x32 icon
$bitmap32 = New-Object System.Drawing.Bitmap(32, 32)
$graphics32 = [System.Drawing.Graphics]::FromImage($bitmap32)
$graphics32.SmoothingMode = [System.Drawing.Drawing2D.SmoothingMode]::AntiAlias

# French flag colors
$blue = [System.Drawing.Color]::FromArgb(0, 85, 164)
$white = [System.Drawing.Color]::White
$red = [System.Drawing.Color]::FromArgb(239, 65, 53)

# Fill with blue background
$graphics32.Clear($blue)

# Draw white and red stripes
$stripWidth = 32 / 3
$graphics32.FillRectangle((New-Object System.Drawing.SolidBrush($white)), $stripWidth, 0, $stripWidth, 32)
$graphics32.FillRectangle((New-Object System.Drawing.SolidBrush($red)), $stripWidth * 2, 0, $stripWidth, 32)

# Add H letter
$font32 = New-Object System.Drawing.Font("Arial", 16, [System.Drawing.FontStyle]::Bold)
$brush = New-Object System.Drawing.SolidBrush([System.Drawing.Color]::Black)
$graphics32.DrawString("H", $font32, $brush, 11, 8)

$bitmap32.Save("winres\icon.png", [System.Drawing.Imaging.ImageFormat]::Png)
$graphics32.Dispose()
$bitmap32.Dispose()

# Create 16x16 icon
$bitmap16 = New-Object System.Drawing.Bitmap(16, 16)
$graphics16 = [System.Drawing.Graphics]::FromImage($bitmap16)
$graphics16.SmoothingMode = [System.Drawing.Drawing2D.SmoothingMode]::AntiAlias

# Fill with blue background
$graphics16.Clear($blue)

# Draw white and red stripes
$stripWidth16 = 16 / 3
$graphics16.FillRectangle((New-Object System.Drawing.SolidBrush($white)), $stripWidth16, 0, $stripWidth16, 16)
$graphics16.FillRectangle((New-Object System.Drawing.SolidBrush($red)), $stripWidth16 * 2, 0, $stripWidth16, 16)

# Add H letter
$font16 = New-Object System.Drawing.Font("Arial", 8, [System.Drawing.FontStyle]::Bold)
$graphics16.DrawString("H", $font16, $brush, 5, 4)

$bitmap16.Save("winres\icon16.png", [System.Drawing.Imaging.ImageFormat]::Png)
$graphics16.Dispose()
$bitmap16.Dispose()

Write-Host "PNG icons created successfully!"
