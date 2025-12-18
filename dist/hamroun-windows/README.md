# Hamroun French Programming Language - Cross-Platform Distribution

🇫🇷 **HAMROUN - LE LANGAGE DE PROGRAMMATION FRANÇAIS**

## 📦 Téléchargements Disponibles

| Plateforme | Architecture | Fichier | Taille |
|------------|-------------|---------|--------|
| 🪟 Windows | x64 | `hamroun-windows-amd64.exe` | 1.65 MB |
| 🐧 Linux | x64 | `hamroun-linux-amd64` | 1.52 MB |
| 🐧 Linux | ARM64 | `hamroun-linux-arm64` | 1.56 MB |
| 🍎 macOS | Intel | `hamroun-darwin-amd64` | 1.55 MB |
| 🍎 macOS | Apple Silicon | `hamroun-darwin-arm64` | 1.56 MB |

## 🚀 Installation

### Linux / macOS
```bash
# Rendre le script exécutable
chmod +x install.sh

# Installer (peut nécessiter sudo)
./install.sh

# Utiliser
hamroun fichier.hamroun
```

### Windows
```cmd
# Copier dans un répertoire du PATH ou utiliser directement
hamroun-windows-amd64.exe fichier.hamroun
```

## 📚 Guide de Démarrage Rapide

### 1. Premier Programme
```hamroun
# Créer test.hamroun
nombre = 42
resultat = nombre + 8
resultat
```

### 2. Exécution
```bash
# Linux/macOS
hamroun test.hamroun

# Windows
hamroun-windows-amd64.exe test.hamroun
```

### 3. Mode Interactif (REPL)
```bash
# Lancer sans fichier
hamroun

# Commandes disponibles:
# AIDE      - Affiche l'aide
# VARIABLES - Affiche les variables
# SORTIR    - Quitter
```

## 🇫🇷 Syntaxe Française

### Conditions
```hamroun
age = 18
SI age EGAL 18 ALORS
  message = "Majorité"
SINON
  message = "Mineur"
FIN
```

### Boucles
```hamroun
BOUCLE i DE 1 A 5
  resultat = i * 2
FIN
```

### Comparaisons
- `EGAL` - égal
- `DIFFERENT` - différent  
- `PLUS_GRAND` - plus grand
- `PLUS_PETIT` - plus petit

## 🌍 Compatibilité

✅ **Testé sur:**
- Windows 10/11 (32-bit & 64-bit)
- Ubuntu 20.04+ LTS
- macOS 11+ (Intel & Apple Silicon)
- Debian 11+
- CentOS 8+
- Raspberry Pi OS (ARM64)

## 💼 Fonctionnalités

- ✅ **Syntaxe 100% française**
- ✅ **Interface utilisateur française**
- ✅ **REPL interactif avec emojis**
- ✅ **Messages d'erreur en français**
- ✅ **Extension .hamroun**
- ✅ **Icône professionnelle**
- ✅ **Cross-platform**

## 🛠️ Pour les Développeurs

### Compilation depuis les sources
```bash
# Cloner le projet
git clone https://github.com/mohamedx2/interpreter.git
cd interpreter

# Compiler pour votre plateforme
go build -o hamroun hamroun.go

# Cross-compilation
./build_cross_platform.ps1  # Windows
```

### Structure du Projet
```
interpreter/
├── hamroun.go          # Point d'entrée principal
├── lexer/              # Analyseur lexical
├── parser/             # Analyseur syntaxique  
├── evaluator/          # Évaluateur d'expressions
├── repl/               # Interface interactive
├── ast/                # Arbre syntaxique abstrait
├── token/              # Définitions des tokens
└── exemples/           # Programmes d'exemple
```

---

**Hamroun French Programming Language** - Le premier langage de programmation entièrement en français! 🇫🇷✨
