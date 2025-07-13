# Create a minimal ICO file
$icoHeader = @(0,0,1,0,1,0,16,16,0,0,1,0,32,0,64,4,0,0,22,0,0,0)
$imageHeader = @(40,0,0,0,16,0,0,0,32,0,0,0,1,0,32,0,0,0,0,0,64,4,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0)

# Create a simple 16x16 blue icon with 'H'
$imageData = @()
for ($y = 0; $y -lt 16; $y++) {
    for ($x = 0; $x -lt 16; $x++) {
        if (($x -eq 2 -or $x -eq 13) -and ($y -ge 2 -and $y -le 13)) {
            # Vertical lines of 'H'
            $imageData += @(255,255,255,255) # White
        } elseif (($y -eq 7 -or $y -eq 8) -and ($x -ge 2 -and $x -le 13)) {
            # Horizontal line of 'H'
            $imageData += @(255,255,255,255) # White
        } else {
            # Blue background
            $imageData += @(255,0,85,164) # Blue (BGRA format)
        }
    }
}

# And mask (all transparent)
$andMask = @()
for ($i = 0; $i -lt 32; $i++) {
    $andMask += 0
}

# Combine all data
$allData = $icoHeader + $imageHeader + $imageData + $andMask

# Convert to bytes and save
$bytes = [byte[]]$allData
[System.IO.File]::WriteAllBytes("hamroun.ico", $bytes)

Write-Host "Icon created successfully!"
