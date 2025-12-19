# Hamroun Language Support for VS Code

Professional Visual Studio Code extension for the **Hamroun** French programming language.

## Features

### 🎨 Syntax Highlighting
- Full syntax highlighting for all Hamroun keywords
- French language constructs: `SI`, `ALORS`, `SINON`, `BOUCLE`, `FIN`
- Operators: `EGAL`, `DIFFERENT`, `PLUS_GRAND`, `PLUS_PETIT`
- Comments, strings, numbers, and identifiers

### 📝 Code Snippets
Type these prefixes and press Tab:
- `si` - SI-ALORS-SINON condition
- `sia` - SI-ALORS simple condition  
- `boucle` - BOUCLE DE-A loop
- `tant` - TANT_QUE loop
- `fonction` - Function declaration
- `procedure` - Procedure declaration
- `var` - Variable assignment
- `aff` - AFFICHER statement
- `prog` - Program template

### ⚙️ Language Configuration
- Auto-closing brackets and quotes
- Comment toggling with `Ctrl+/`
- Smart indentation
- Code folding for blocks

## Installation

### From VSIX File
1. Download the `.vsix` file
2. Open VS Code
3. Go to Extensions (`Ctrl+Shift+X`)
4. Click `...` → "Install from VSIX..."
5. Select the downloaded file

### From Source
```bash
cd vscode-extension
npm install
npm run compile
npm run package
code --install-extension hamroun-language-1.0.0.vsix
```

## Usage

1. Create a file with `.hamroun` extension
2. Start coding with syntax highlighting and snippets!

### Example Code

```hamroun
# Programme simple
x = 10
y = 20

SI x PLUS_PETIT y ALORS
    AFFICHER "x est plus petit que y"
SINON
    AFFICHER "x est plus grand ou égal à y"
FIN

BOUCLE i DE 1 A 5
    somme = somme + i
FIN

AFFICHER somme
```

## Requirements

- VS Code 1.80.0 or higher

## Extension Settings

This extension contributes the following settings:
- File associations for `.hamroun` files
- Syntax highlighting themes
- Code snippets

## Known Issues

None currently. Please report issues on [GitHub](https://github.com/mohamedx2/interpreter/issues).

## Release Notes

### 1.0.0
- Initial release
- Syntax highlighting for all Hamroun keywords
- 15+ code snippets
- Language configuration with auto-closing pairs
- Professional French programming support

## About Hamroun

Hamroun is a French programming language interpreter created by Mohamed Ali Hamroun. It features:
- French keywords and syntax
- Arithmetic operations
- Conditional statements (SI-ALORS-SINON)
- Loops (BOUCLE, TANT_QUE)
- Functions and procedures
- Variables and data types

## Links

- [GitHub Repository](https://github.com/mohamedx2/interpreter)
- [Author Website](https://mohamedalihamroun.me)
- [Report Issues](https://github.com/mohamedx2/interpreter/issues)

## License

MIT License - See LICENSE file for details

---

**Enjoy coding in French! 🇫🇷**
