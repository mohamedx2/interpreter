# PowerShell script to create a professional Hamroun language icon
Add-Type -AssemblyName System.Drawing
Add-Type -AssemblyName System.Windows.Forms

# Create a professional icon design
$sizes = @(16, 24, 32, 48, 64, 128, 256)
$iconFiles = @()

foreach ($size in $sizes) {
    # Create bitmap with the specified size
    $bitmap = New-Object System.Drawing.Bitmap($size, $size)
    $graphics = [System.Drawing.Graphics]::FromImage($bitmap)
    
    # Enable anti-aliasing for smoother graphics
    $graphics.SmoothingMode = [System.Drawing.Drawing2D.SmoothingMode]::AntiAlias
    $graphics.TextRenderingHint = [System.Drawing.Text.TextRenderingHint]::AntiAlias
    
    # Professional color scheme
    $darkBlue = [System.Drawing.Color]::FromArgb(25, 55, 109)      # Professional dark blue
    $lightBlue = [System.Drawing.Color]::FromArgb(70, 130, 200)    # Accent blue  
    $white = [System.Drawing.Color]::White
    $french_blue = [System.Drawing.Color]::FromArgb(0, 85, 164)    # French flag blue
    $french_red = [System.Drawing.Color]::FromArgb(239, 65, 53)    # French flag red
    
    # Create gradient background
    $rect = New-Object System.Drawing.Rectangle(0, 0, $size, $size)
    $brush = New-Object System.Drawing.Drawing2D.LinearGradientBrush($rect, $darkBlue, $lightBlue, 45)
    $graphics.FillRectangle($brush, $rect)
    
    # Add subtle border
    $borderPen = New-Object System.Drawing.Pen($french_blue, [Math]::Max(1, $size / 32))
    $graphics.DrawRectangle($borderPen, 0, 0, $size - 1, $size - 1)
    
    # Calculate proportional sizes
    $fontSize = [Math]::Max(6, $size / 6)
    $symbolSize = [Math]::Max(8, $size / 4)
    
    # Add French programming symbol - combine { } with FR
    $font = New-Object System.Drawing.Font("Segoe UI", $fontSize, [System.Drawing.FontStyle]::Bold)
    $symbolFont = New-Object System.Drawing.Font("Consolas", $symbolSize, [System.Drawing.FontStyle]::Bold)
    
    # Add programming brackets
    $whiteBrush = New-Object System.Drawing.SolidBrush($white)
    $frenchBrush = New-Object System.Drawing.SolidBrush($french_red)
    
    # Position calculations
    $centerX = $size / 2
    $centerY = $size / 2
    
    if ($size -ge 32) {
        # For larger icons, add more detail
        
        # Add opening bracket {
        $bracketRect = New-Object System.Drawing.RectangleF(($size * 0.1), ($size * 0.2), ($size * 0.2), ($size * 0.6))
        $graphics.DrawString("{", $symbolFont, $whiteBrush, $bracketRect)
        
        # Add FR text in center
        $frRect = New-Object System.Drawing.RectangleF(($size * 0.35), ($size * 0.35), ($size * 0.3), ($size * 0.3))
        $graphics.DrawString("FR", $font, $frenchBrush, $frRect)
        
        # Add closing bracket }
        $closeBracketRect = New-Object System.Drawing.RectangleF(($size * 0.7), ($size * 0.2), ($size * 0.2), ($size * 0.6))
        $graphics.DrawString("}", $symbolFont, $whiteBrush, $closeBracketRect)
        
        # Add small "H" for Hamroun at the bottom
        if ($size -ge 48) {
            $smallFont = New-Object System.Drawing.Font("Segoe UI", ($fontSize * 0.6), [System.Drawing.FontStyle]::Bold)
            $hRect = New-Object System.Drawing.RectangleF(($size * 0.4), ($size * 0.75), ($size * 0.2), ($size * 0.2))
            $graphics.DrawString("H", $smallFont, $white, $hRect)
        }
    } else {
        # For smaller icons, simplified design
        # Just show {FR}
        $simpleRect = New-Object System.Drawing.RectangleF(($size * 0.1), ($size * 0.25), ($size * 0.8), ($size * 0.5))
        $graphics.DrawString("{FR}", $font, $whiteBrush, $simpleRect)
    }
    
    # Save as PNG first
    $bitmap.Save("hamroun_pro_$size.png", [System.Drawing.Imaging.ImageFormat]::Png)
    $iconFiles += "hamroun_pro_$size.png"
    
    # Cleanup
    $graphics.Dispose()
    $bitmap.Dispose()
    $brush.Dispose()
    $borderPen.Dispose()
    $font.Dispose()
    $symbolFont.Dispose()
    $whiteBrush.Dispose()
    $frenchBrush.Dispose()
}

Write-Host "✅ Created professional icon PNGs: $($iconFiles -join ', ')"
Write-Host "🔄 Now converting to ICO format..."
