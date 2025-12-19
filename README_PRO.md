# 🇫🇷 Hamroun - Professional French Programming Language

<div align="center">

![Hamroun Logo](vscode-extension/images/icon.png)

**A modern, intuitive programming language with French syntax**

[![License: MIT](https://img.shields.io/badge/License-MIT-blue.svg)](LICENSE)
[![Version](https://img.shields.io/badge/version-1.0.0-green.svg)](https://github.com/mohamedx2/interpreter)
[![Go Version](https://img.shields.io/badge/Go-1.20+-00ADD8.svg)](https://golang.org/)

[Features](#features) • [Installation](#installation) • [VS Code Extension](#vs-code-extension) • [Documentation](#documentation) • [Examples](#examples)

</div>

---

## 🎯 Overview

Hamroun is a French programming language designed to make coding accessible and intuitive for French speakers. With a clean syntax inspired by French language constructs, Hamroun provides a natural way to express programming concepts.

### ✨ Key Features

- 🇫🇷 **French Keywords**: `SI`, `ALORS`, `BOUCLE`, `FONCTION`
- 🚀 **Fast Interpreter**: Built in Go for performance
- 📝 **Clean Syntax**: Readable and maintainable code
- 🎨 **VS Code Extension**: Full IDE support with syntax highlighting
- 🌍 **Cross-Platform**: Windows, Linux, and macOS support
- 📚 **Rich Standard Library**: Built-in functions for common tasks

## 📦 Installation

### Windows

```powershell
# Download the latest release
Invoke-WebRequest -Uri "https://github.com/mohamedx2/interpreter/releases/latest/hamroun-windows.zip" -OutFile "hamroun.zip"

# Extract
Expand-Archive -Path "hamroun.zip" -DestinationPath "C:\Hamroun"

# Add to PATH
[Environment]::SetEnvironmentVariable("Path", $env:Path + ";C:\Hamroun", "User")
```

### Linux / macOS

```bash
# Download and install
curl -L https://github.com/mohamedx2/interpreter/releases/latest/hamroun-linux.tar.gz | tar xz
sudo mv hamroun /usr/local/bin/

# Verify installation
hamroun --version
```

### Build from Source

```bash
git clone https://github.com/mohamedx2/interpreter.git
cd interpreter
go build -o hamroun hamroun.go
```

## 🎨 VS Code Extension

Get full IDE support with our professional VS Code extension!

### Features

- ✅ Syntax highlighting for all Hamroun keywords
- ✅ 15+ code snippets
- ✅ Auto-completion and IntelliSense
- ✅ Error detection
- ✅ Code folding and formatting
- ✅ French-themed color scheme

### Installation

1. **From VSIX** (Recommended):
   ```bash
   cd vscode-extension
   npm install
   npm run package
   code --install-extension hamroun-language-1.0.0.vsix
   ```

2. **From Marketplace** (Coming Soon):
   - Open VS Code
   - Search for "Hamroun Language Support"
   - Click Install

## 📖 Language Syntax

### Variables

```hamroun
# Simple variables
x = 10
nom = "Hamroun"
prix = 99.99
actif = VRAI
```

### Conditions

```hamroun
age = 25

SI age PLUS_GRAND 18 ALORS
    AFFICHER "Majeur"
SINON
    AFFICHER "Mineur"
FIN
```

### Loops

```hamroun
# For loop
BOUCLE i DE 1 A 10
    AFFICHER i
FIN

# While loop
compteur = 0
TANT_QUE compteur PLUS_PETIT 5 FAIRE
    AFFICHER compteur
    compteur = compteur + 1
FIN
```

### Functions

```hamroun
FONCTION calculer_somme(a, b)
    resultat = a + b
    RETOURNER resultat
FIN

total = calculer_somme(10, 20)
AFFICHER total
```

### Operators

| French | Symbol | English |
|--------|--------|---------|
| `EGAL` | `==` | Equal |
| `DIFFERENT` | `!=` | Not equal |
| `PLUS_GRAND` | `>` | Greater than |
| `PLUS_PETIT` | `<` | Less than |
| `ET` | `&&` | And |
| `OU` | `||` | Or |
| `NON` | `!` | Not |

## 🚀 Quick Start

### Hello World

```hamroun
# hello.hamroun
AFFICHER "Bonjour le monde!"
```

Run it:
```bash
hamroun hello.hamroun
```

### Calculator Example

```hamroun
# calculatrice.hamroun
a = 10
b = 5

somme = a + b
difference = a - b
produit = a * b
quotient = a / b

AFFICHER "Somme: " + somme
AFFICHER "Différence: " + difference
AFFICHER "Produit: " + produit
AFFICHER "Quotient: " + quotient
```

### More Examples

See the [exemples/](exemples/) directory for more sample programs:
- `arithmetique.hamroun` - Arithmetic operations
- `conditions.hamroun` - Conditional statements
- `boucles.hamroun` - Loop examples
- `demo.hamroun` - Complete demo

## 🏗️ Project Structure

```
interpreter/
├── src/                    # Source code
│   ├── ast/               # Abstract Syntax Tree
│   ├── lexer/             # Lexical analyzer
│   ├── parser/            # Parser
│   ├── evaluator/         # Interpreter
│   ├── repl/              # REPL implementation
│   └── token/             # Token definitions
├── bin/                    # Compiled binaries
├── dist/                   # Distribution packages
├── docs/                   # Documentation
├── exemples/              # Example programs
├── vscode-extension/      # VS Code extension
│   ├── syntaxes/          # TextMate grammar
│   ├── snippets/          # Code snippets
│   ├── themes/            # Color themes
│   └── src/               # Extension code
├── build-professional.ps1 # Build automation
└── build-extension.ps1    # Extension builder
```

## 🔧 Development

### Building the Interpreter

```powershell
# Standard build
.\build-professional.ps1

# Cross-platform build
.\build-professional.ps1 -CrossPlatform

# With version
.\build-professional.ps1 -Version "1.1.0"
```

### Building the Extension

```powershell
# Build and package extension
.\build-extension.ps1
```

### Running Tests

```bash
# Run all tests
go test ./...

# Run specific package tests
go test ./lexer
go test ./parser
go test ./evaluator
```

## 📚 Documentation

- [Language Reference](docs/language-reference.md)
- [Standard Library](docs/standard-library.md)
- [VS Code Extension Guide](vscode-extension/README.md)
- [Contributing Guide](CONTRIBUTING.md)
- [Changelog](CHANGELOG.md)

## 🤝 Contributing

We welcome contributions! Please see our [Contributing Guide](CONTRIBUTING.md) for details.

### Quick Contribution Steps

1. Fork the repository
2. Create your feature branch (`git checkout -b feature/AmazingFeature`)
3. Commit your changes (`git commit -m 'Add some AmazingFeature'`)
4. Push to the branch (`git push origin feature/AmazingFeature`)
5. Open a Pull Request

## 🐛 Known Issues

- None currently reported

Report issues at: https://github.com/mohamedx2/interpreter/issues

## 📝 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## 👨‍💻 Author

**Mohamed Ali Hamroun**

- Website: [mohamedalihamroun.me](https://mohamedalihamroun.me)
- GitHub: [@mohamedx2](https://github.com/mohamedx2)
- LinkedIn: [mohamedalihamroun](https://linkedin.com/in/mohamedalihamroun)

## 🙏 Acknowledgments

- Inspired by the French programming education community
- Built with Go and TypeScript
- Icons created with French flag colors (🔵 Bleu • ⚪ Blanc • 🔴 Rouge)

## 📊 Statistics

![GitHub stars](https://img.shields.io/github/stars/mohamedx2/interpreter?style=social)
![GitHub forks](https://img.shields.io/github/forks/mohamedx2/interpreter?style=social)
![GitHub issues](https://img.shields.io/github/issues/mohamedx2/interpreter)

---

<div align="center">

**Made with ❤️ in France 🇫🇷**

[⬆ Back to top](#-hamroun---professional-french-programming-language)

</div>
