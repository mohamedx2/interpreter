# PowerShell script to create extension icon
Add-Type -AssemblyName System.Drawing

# Create 128x128 icon for VS Code extension
$size = 128
$bitmap = New-Object System.Drawing.Bitmap($size, $size)
$graphics = [System.Drawing.Graphics]::FromImage($bitmap)
$graphics.SmoothingMode = [System.Drawing.Drawing2D.SmoothingMode]::AntiAlias
$graphics.TextRenderingHint = [System.Drawing.Text.TextRenderingHint]::AntiAlias

# French flag colors
$blue = [System.Drawing.Color]::FromArgb(0, 85, 164)
$white = [System.Drawing.Color]::White
$red = [System.Drawing.Color]::FromArgb(239, 65, 53)

# Gradient background (blue)
$rect = New-Object System.Drawing.Rectangle(0, 0, $size, $size)
$brush = New-Object System.Drawing.Drawing2D.LinearGradientBrush(
    $rect,
    [System.Drawing.Color]::FromArgb(0, 85, 164),
    [System.Drawing.Color]::FromArgb(0, 120, 215),
    [System.Drawing.Drawing2D.LinearGradientMode]::Vertical
)
$graphics.FillRectangle($brush, $rect)

# Draw {FR} text
$font = New-Object System.Drawing.Font("Segoe UI", 36, [System.Drawing.FontStyle]::Bold)
$text = "{FR}"
$textSize = $graphics.MeasureString($text, $font)
$textX = ($size - $textSize.Width) / 2
$textY = ($size - $textSize.Height) / 2

# Draw text shadow
$shadowBrush = New-Object System.Drawing.SolidBrush([System.Drawing.Color]::FromArgb(100, 0, 0, 0))
$graphics.DrawString($text, $font, $shadowBrush, $textX + 2, $textY + 2)

# Draw text
$textBrush = New-Object System.Drawing.SolidBrush($white)
$graphics.DrawString($text, $font, $textBrush, $textX, $textY)

# Add small red accent
$accentPen = New-Object System.Drawing.Pen($red, 3)
$graphics.DrawRectangle($accentPen, 10, 10, $size - 20, $size - 20)

# Save as PNG
$outputPath = Join-Path $PSScriptRoot "images\icon.png"
$bitmap.Save($outputPath, [System.Drawing.Imaging.ImageFormat]::Png)

# Cleanup
$graphics.Dispose()
$bitmap.Dispose()

Write-Host "✅ Extension icon created: $outputPath"
