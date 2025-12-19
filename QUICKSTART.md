# Quick Start Guide for Developers

## 🚀 Getting Started in 5 Minutes

### 1. Install Dependencies

```powershell
# Verify Go installation
go version

# Should show: go version go1.20 or higher
```

### 2. Build the Interpreter

```powershell
# Quick build
go build -o hamroun.exe hamroun.go

# Or use the professional build script
.\build-professional.ps1
```

### 3. Test It Out

```powershell
# Run a sample program
.\hamroun.exe exemples\demo.hamroun

# Or start the REPL
.\hamroun.exe
```

### 4. Install VS Code Extension

```powershell
# Build and install extension
.\build-extension.ps1
```

## 📝 Common Commands

```powershell
# Build interpreter
.\build-professional.ps1

# Build with version
.\build-professional.ps1 -Version "1.1.0"

# Cross-platform build
.\build-professional.ps1 -CrossPlatform

# Build VS Code extension
.\build-extension.ps1

# Run tests
go test ./...

# Format code
gofmt -w .
```

## 🎨 Development Workflow

1. **Edit code** in `src/` directories
2. **Build** with `.\build-professional.ps1`
3. **Test** your changes
4. **Update documentation** if needed
5. **Commit** with conventional commit messages

## 📚 Key Files

- `hamroun.go` - Main entry point
- `src/lexer/` - Tokenization
- `src/parser/` - AST generation
- `src/evaluator/` - Code execution
- `vscode-extension/` - VS Code extension

## 🔧 Troubleshooting

### Build Fails
```powershell
# Clean and rebuild
go clean
go build -o hamroun.exe hamroun.go
```

### Extension Issues
```powershell
# Reinstall dependencies
cd vscode-extension
Remove-Item -Recurse node_modules
npm install
npm run compile
```

### Icon Not Showing
```powershell
# Rebuild with icon
go-winres make
go build -o hamroun.exe hamroun.go
```

## 🎯 Next Steps

- Read [README_PRO.md](README_PRO.md) for full documentation
- Check [CONTRIBUTING.md](CONTRIBUTING.md) for contribution guidelines
- Explore [exemples/](exemples/) for code samples
- Join discussions on GitHub

---

**Happy Coding! 🇫🇷**
