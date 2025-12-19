# Changelog

All notable changes to the Hamroun project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [1.0.0] - 2025-12-18

### 🎉 Initial Release

The first stable release of Hamroun French Programming Language!

### Added

#### Interpreter
- **Lexer**: Full tokenization of French keywords and operators
- **Parser**: Complete AST generation for all language constructs
- **Evaluator**: Expression and statement evaluation engine
- **REPL**: Interactive Read-Eval-Print Loop for live coding
- **File Execution**: Support for `.hamroun` file extension

#### Language Features
- **Variables**: Simple variable assignment (`x = 10`)
- **Arithmetic**: `+`, `-`, `*`, `/` operators
- **Comparisons**: `EGAL`, `DIFFERENT`, `PLUS_GRAND`, `PLUS_PETIT`
- **Conditions**: `SI-ALORS-SINON-FIN` constructs
- **Loops**: `BOUCLE i DE 1 A 10` with counter
- **Functions**: `FONCTION` and `PROCEDURE` declarations
- **I/O**: `AFFICHER` and `LIRE` statements
- **Logic**: `ET`, `OU`, `NON` operators
- **Comments**: Single-line comments with `#`

#### VS Code Extension
- **Syntax Highlighting**: Complete TextMate grammar
- **Code Snippets**: 15+ snippets for common patterns
- **Language Configuration**: Auto-closing, brackets, indentation
- **Hover Provider**: Keyword documentation on hover
- **Status Bar**: Active file indicator
- **Custom Theme**: French-themed color scheme
- **File Icons**: Custom `.hamroun` file icons

#### Build System
- **Professional Build Script**: Automated versioned builds
- **Cross-Platform Support**: Windows, Linux, macOS builds
- **Distribution Packages**: ZIP/TAR.GZ archives
- **Extension Builder**: One-command VSIX packaging
- **Icon Generation**: Automated icon creation
- **Version Info**: Embedded version metadata

#### Documentation
- **README_PRO.md**: Comprehensive project documentation
- **CONTRIBUTING.md**: Contribution guidelines
- **CHANGELOG.md**: Version history
- **Language Examples**: Sample programs in `exemples/`
- **Extension README**: VS Code extension documentation
- **Build Instructions**: Complete build and deployment guide

#### Infrastructure
- **Professional Structure**: Organized src/, bin/, dist/ directories
- **Automated Testing**: Unit test framework
- **CI/CD Ready**: Build automation scripts
- **Git Integration**: Proper .gitignore and repository structure
- **License**: MIT License

### Technical Details

#### Dependencies
- **Go**: 1.20+ for interpreter
- **Node.js**: 18+ for VS Code extension
- **TypeScript**: 5.0+ for extension development
- **VSCE**: VS Code Extension Manager

#### Supported Platforms
- Windows 10/11 (AMD64)
- Linux (AMD64, ARM64)
- macOS (Intel, Apple Silicon)

#### Performance
- Fast startup time (<50ms)
- Efficient memory usage
- Optimized binary size (~1.5MB compressed)

### Keywords Reference

| French | English | Category |
|--------|---------|----------|
| SI | IF | Control Flow |
| ALORS | THEN | Control Flow |
| SINON | ELSE | Control Flow |
| FIN | END | Control Flow |
| BOUCLE | LOOP | Iteration |
| DE | FROM | Iteration |
| A | TO | Iteration |
| TANT_QUE | WHILE | Iteration |
| FAIRE | DO | Iteration |
| FONCTION | FUNCTION | Declaration |
| PROCEDURE | PROCEDURE | Declaration |
| RETOURNER | RETURN | Control Flow |
| AFFICHER | PRINT | I/O |
| LIRE | READ | I/O |
| EGAL | EQUAL | Comparison |
| DIFFERENT | NOT EQUAL | Comparison |
| PLUS_GRAND | GREATER | Comparison |
| PLUS_PETIT | LESS | Comparison |
| ET | AND | Logic |
| OU | OR | Logic |
| NON | NOT | Logic |
| VRAI | TRUE | Boolean |
| FAUX | FALSE | Boolean |

### File Structure

```
interpreter/
├── src/                      # Source code
│   ├── ast/                 # AST definitions
│   ├── lexer/               # Lexical analysis
│   ├── parser/              # Syntax parsing
│   ├── evaluator/           # Code evaluation
│   ├── repl/                # Interactive mode
│   └── token/               # Token types
├── bin/                      # Compiled binaries
├── dist/                     # Distribution packages
├── docs/                     # Documentation
├── exemples/                 # Example programs
├── vscode-extension/         # VS Code extension
│   ├── src/                 # Extension code
│   ├── syntaxes/            # Grammar files
│   ├── snippets/            # Code snippets
│   ├── themes/              # Color themes
│   └── images/              # Icons and assets
├── build-professional.ps1    # Build automation
├── build-extension.ps1       # Extension builder
├── README_PRO.md            # Main documentation
├── CONTRIBUTING.md          # Contribution guide
└── CHANGELOG.md             # This file
```

### Known Limitations

- No debugger integration (planned for 1.1.0)
- Limited standard library (expanding in 1.2.0)
- No package manager (planned for 2.0.0)
- REPL doesn't support multi-line input yet

### Migration Guide

This is the initial release, no migration needed.

---

## [Unreleased]

### Planned for 1.1.0
- [ ] Debugger support in VS Code
- [ ] Enhanced error messages
- [ ] Array and list operations
- [ ] String manipulation functions
- [ ] Math library
- [ ] File I/O operations

### Planned for 1.2.0
- [ ] Standard library expansion
- [ ] Module system
- [ ] Import/export functionality
- [ ] Advanced data structures
- [ ] Network operations

### Planned for 2.0.0
- [ ] Package manager (HPM - Hamroun Package Manager)
- [ ] Online playground
- [ ] Language server protocol
- [ ] Compilation to bytecode
- [ ] Performance optimizations
- [ ] GUI development framework

---

## Version History

- **1.0.0** (2025-12-18) - Initial stable release

---

For more information, visit: https://github.com/mohamedx2/interpreter

**Changelog maintained by**: Mohamed Ali Hamroun
