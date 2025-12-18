#!/bin/bash
# macOS App Bundle Creator for Hamroun

echo "🍎 Creating macOS App Bundle for Hamroun..."

# Detect architecture
ARCH=$(uname -m)
case $ARCH in
    x86_64) BINARY="hamroun-darwin-amd64" ;;
    arm64) BINARY="hamroun-darwin-arm64" ;;
    *) echo "❌ Unsupported architecture: $ARCH"; exit 1 ;;
esac

# Create app bundle structure
APP_NAME="Hamroun.app"
APP_DIR="$APP_NAME/Contents"
MACOS_DIR="$APP_DIR/MacOS"
RESOURCES_DIR="$APP_DIR/Resources"

echo "📁 Creating app bundle structure..."
mkdir -p "$MACOS_DIR"
mkdir -p "$RESOURCES_DIR"

# Copy binary
if [ -f "$BINARY" ]; then
    cp "$BINARY" "$MACOS_DIR/hamroun"
    chmod +x "$MACOS_DIR/hamroun"
    echo "✅ Binary copied: $BINARY"
else
    echo "❌ Binary not found: $BINARY"
    exit 1
fi

# Create Info.plist
cat > "$APP_DIR/Info.plist" << 'EOF'
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
<dict>
    <key>CFBundleExecutable</key>
    <string>hamroun</string>
    <key>CFBundleIdentifier</key>
    <string>com.hamroun.interpreter</string>
    <key>CFBundleName</key>
    <string>Hamroun</string>
    <key>CFBundleDisplayName</key>
    <string>Hamroun French Programming Language</string>
    <key>CFBundleVersion</key>
    <string>1.0.0</string>
    <key>CFBundleShortVersionString</key>
    <string>1.0</string>
    <key>CFBundlePackageType</key>
    <string>APPL</string>
    <key>CFBundleSignature</key>
    <string>HMRN</string>
    <key>LSMinimumSystemVersion</key>
    <string>10.15</string>
    <key>NSHighResolutionCapable</key>
    <true/>
    <key>CFBundleDocumentTypes</key>
    <array>
        <dict>
            <key>CFBundleTypeExtensions</key>
            <array>
                <string>hamroun</string>
            </array>
            <key>CFBundleTypeName</key>
            <string>Hamroun Source File</string>
            <key>CFBundleTypeRole</key>
            <string>Editor</string>
            <key>LSTypeIsPackage</key>
            <false/>
        </dict>
    </array>
</dict>
</plist>
EOF

# Create launcher script that opens Terminal
cat > "$MACOS_DIR/hamroun-launcher" << 'EOF'
#!/bin/bash
# Hamroun Terminal Launcher
cd "$(dirname "$0")"
osascript -e 'tell application "Terminal" to do script "'"$(pwd)/hamroun"'; exit"'
EOF

chmod +x "$MACOS_DIR/hamroun-launcher"

# Create icns file from existing icon (if available)
if command -v sips &> /dev/null && [ -f "../hamroun_pro.ico" ]; then
    echo "🎨 Converting icon to macOS format..."
    sips -s format png ../hamroun_pro.ico --out "$RESOURCES_DIR/icon.png" 2>/dev/null
    if [ -f "$RESOURCES_DIR/icon.png" ]; then
        # Create iconset
        mkdir "$RESOURCES_DIR/icon.iconset"
        sips -z 16 16 "$RESOURCES_DIR/icon.png" --out "$RESOURCES_DIR/icon.iconset/icon_16x16.png"
        sips -z 32 32 "$RESOURCES_DIR/icon.png" --out "$RESOURCES_DIR/icon.iconset/icon_32x32.png"
        sips -z 64 64 "$RESOURCES_DIR/icon.png" --out "$RESOURCES_DIR/icon.iconset/icon_64x64.png"
        sips -z 128 128 "$RESOURCES_DIR/icon.png" --out "$RESOURCES_DIR/icon.iconset/icon_128x128.png"
        sips -z 256 256 "$RESOURCES_DIR/icon.png" --out "$RESOURCES_DIR/icon.iconset/icon_256x256.png"
        
        # Create icns
        iconutil -c icns "$RESOURCES_DIR/icon.iconset" -o "$RESOURCES_DIR/icon.icns"
        rm -rf "$RESOURCES_DIR/icon.iconset" "$RESOURCES_DIR/icon.png"
        echo "✅ Icon created"
    fi
fi

echo ""
echo "🎉 macOS App Bundle created: $APP_NAME"
echo ""
echo "📝 To install:"
echo "   1. Copy $APP_NAME to /Applications/"
echo "   2. Double-click to run, or use:"
echo "      $APP_NAME/Contents/MacOS/hamroun fichier.hamroun"
echo ""
echo "🇫🇷 Hamroun French Programming Language for macOS ready!"
EOF
