#!/bin/bash
# Installation script for Hamroun French Programming Language on Linux/macOS

echo "🇫🇷 HAMROUN FRENCH PROGRAMMING LANGUAGE INSTALLER"
echo "================================================="
echo ""

# Detect architecture
ARCH=$(uname -m)
OS=$(uname -s)

case $ARCH in
    x86_64)
        ARCH_SUFFIX="amd64"
        ;;
    arm64|aarch64)
        ARCH_SUFFIX="arm64"
        ;;
    *)
        echo "❌ Architecture non supportée: $ARCH"
        exit 1
        ;;
esac

case $OS in
    Linux)
        OS_SUFFIX="linux"
        INSTALL_DIR="/usr/local/bin"
        ;;
    Darwin)
        OS_SUFFIX="darwin"
        INSTALL_DIR="/usr/local/bin"
        ;;
    *)
        echo "❌ Système d'exploitation non supporté: $OS"
        exit 1
        ;;
esac

BINARY_NAME="hamroun-${OS_SUFFIX}-${ARCH_SUFFIX}"
echo "📦 Installation de: $BINARY_NAME"
echo "📁 Répertoire d'installation: $INSTALL_DIR"
echo ""

# Check if binary exists
if [ ! -f "$BINARY_NAME" ]; then
    echo "❌ Erreur: $BINARY_NAME introuvable"
    echo "💡 Assurez-vous que les fichiers compilés sont dans ce répertoire"
    exit 1
fi

# Check if we have write permission
if [ ! -w "$INSTALL_DIR" ]; then
    echo "🔐 Privilèges administrateur requis pour l'installation"
    echo "🚀 Exécution avec sudo..."
    sudo cp "$BINARY_NAME" "$INSTALL_DIR/hamroun"
    sudo chmod +x "$INSTALL_DIR/hamroun"
else
    cp "$BINARY_NAME" "$INSTALL_DIR/hamroun"
    chmod +x "$INSTALL_DIR/hamroun"
fi

if [ $? -eq 0 ]; then
    echo "✅ Installation réussie!"
    echo ""
    echo "🎉 Hamroun French Programming Language est maintenant installé!"
    echo ""
    echo "📚 UTILISATION:"
    echo "   hamroun fichier.hamroun    # Exécuter un programme"
    echo "   hamroun                    # Lancer le REPL interactif"
    echo ""
    echo "🇫🇷 MOTS-CLÉS FRANÇAIS:"
    echo "   SI/ALORS/SINON            # Conditions"
    echo "   BOUCLE/DE/A               # Boucles"
    echo "   EGAL/DIFFERENT            # Comparaisons"
    echo ""
    echo "📝 EXEMPLE:"
    echo '   echo "nombre = 42" > test.hamroun'
    echo "   hamroun test.hamroun"
    echo ""
    
    # Test installation
    if command -v hamroun &> /dev/null; then
        echo "🧪 Test de l'installation..."
        echo "Version installée:"
        hamroun --help 2>/dev/null || echo "Programme installé avec succès"
    fi
else
    echo "❌ Erreur d'installation"
    exit 1
fi
