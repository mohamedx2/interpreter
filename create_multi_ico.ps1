# PowerShell script to create a proper multi-size ICO file
Add-Type -AssemblyName System.Drawing

# Create a new icon with multiple sizes
$sizes = @(16, 32, 48, 64, 128, 256)
$icon = New-Object System.Drawing.Icon("hamroun.ico")

# Create a new bitmap for each size
$newIcon = [System.Drawing.Icon]::FromHandle($icon.Handle)

# Save as new ICO with all sizes
$newIcon.Save("hamroun_multi.ico")

Write-Host "Created hamroun_multi.ico with multiple sizes"
