# Contributing to Hamroun

Thank you for your interest in contributing to Hamroun! This document provides guidelines and instructions for contributing.

## 🎯 Code of Conduct

- Be respectful and inclusive
- Provide constructive feedback
- Focus on what is best for the community
- Show empathy towards other community members

## 🚀 How to Contribute

### Reporting Bugs

Before creating bug reports, please check existing issues. When creating a bug report, include:

- **Description**: Clear and concise description of the bug
- **Steps to Reproduce**: Minimal steps to reproduce the behavior
- **Expected Behavior**: What you expected to happen
- **Actual Behavior**: What actually happened
- **Environment**: OS, Go version, Hamroun version
- **Code Sample**: Minimal code that reproduces the issue

### Suggesting Enhancements

Enhancement suggestions are tracked as GitHub issues. When creating an enhancement suggestion, include:

- **Clear title and description**
- **Use case**: Why would this enhancement be useful
- **Examples**: Code examples if applicable
- **Implementation ideas**: If you have thoughts on how to implement it

### Pull Requests

1. **Fork the repository**
   ```bash
   git clone https://github.com/YOUR_USERNAME/interpreter.git
   cd interpreter
   ```

2. **Create a branch**
   ```bash
   git checkout -b feature/your-feature-name
   ```

3. **Make your changes**
   - Write clean, documented code
   - Follow existing code style
   - Add tests for new features
   - Update documentation

4. **Test your changes**
   ```bash
   go test ./...
   ```

5. **Commit your changes**
   ```bash
   git add .
   git commit -m "feat: add amazing feature"
   ```

6. **Push to your fork**
   ```bash
   git push origin feature/your-feature-name
   ```

7. **Create a Pull Request**
   - Provide a clear description
   - Link any related issues
   - Include screenshots if applicable

## 📝 Development Guidelines

### Code Style

- Follow Go standard formatting (`gofmt`)
- Use meaningful variable and function names
- Write comments for complex logic
- Keep functions focused and small

### Commit Messages

Follow the [Conventional Commits](https://www.conventionalcommits.org/) specification:

- `feat:` New feature
- `fix:` Bug fix
- `docs:` Documentation changes
- `style:` Code style changes (formatting, etc.)
- `refactor:` Code refactoring
- `test:` Adding or updating tests
- `chore:` Maintenance tasks

Examples:
```
feat: add support for POUR loops
fix: resolve parser error with nested conditions
docs: update README with new examples
```

### Testing

- Write unit tests for new features
- Ensure all tests pass before submitting PR
- Aim for good test coverage
- Test edge cases and error conditions

### Documentation

- Update README.md for user-facing changes
- Add code comments for complex logic
- Update language documentation for new features
- Include examples in documentation

## 🏗️ Project Structure

```
interpreter/
├── ast/           # Abstract Syntax Tree definitions
├── lexer/         # Lexical analyzer
├── parser/        # Syntax parser
├── evaluator/     # Code evaluator/interpreter
├── repl/          # Read-Eval-Print Loop
├── token/         # Token definitions
├── exemples/      # Example programs
└── vscode-extension/  # VS Code extension
```

## 🔧 Setting Up Development Environment

### Prerequisites

- Go 1.20 or higher
- Git
- VS Code (recommended)
- Node.js 18+ (for VS Code extension development)

### Setup Steps

1. **Clone the repository**
   ```bash
   git clone https://github.com/mohamedx2/interpreter.git
   cd interpreter
   ```

2. **Install dependencies**
   ```bash
   go mod download
   ```

3. **Build the project**
   ```bash
   go build -o hamroun hamroun.go
   ```

4. **Run tests**
   ```bash
   go test ./...
   ```

5. **Set up VS Code extension** (optional)
   ```bash
   cd vscode-extension
   npm install
   npm run compile
   ```

## 🧪 Testing Guidelines

### Writing Tests

```go
func TestFeatureName(t *testing.T) {
    // Arrange
    input := "test input"
    expected := "expected output"
    
    // Act
    result := YourFunction(input)
    
    // Assert
    if result != expected {
        t.Errorf("Expected %s, got %s", expected, result)
    }
}
```

### Running Tests

```bash
# All tests
go test ./...

# Specific package
go test ./lexer

# With coverage
go test -cover ./...

# Verbose output
go test -v ./...
```

## 📦 Building and Distribution

### Local Build

```powershell
# Standard build
.\build-professional.ps1

# With version
.\build-professional.ps1 -Version "1.1.0"

# Cross-platform
.\build-professional.ps1 -CrossPlatform
```

### Extension Build

```powershell
.\build-extension.ps1
```

## 🐛 Debugging

### Using VS Code

1. Open the project in VS Code
2. Set breakpoints in your code
3. Press F5 to start debugging
4. Use the Debug Console for evaluation

### Manual Debugging

```go
// Add debug prints
fmt.Printf("Debug: variable = %v\n", variable)

// Use debug files
go run debug.go
```

## 🌟 Areas for Contribution

### High Priority

- [ ] Improve error messages
- [ ] Add more standard library functions
- [ ] Enhance REPL functionality
- [ ] Add debugger support
- [ ] Improve documentation

### Medium Priority

- [ ] Performance optimizations
- [ ] Additional operators
- [ ] File I/O operations
- [ ] Network operations
- [ ] JSON/XML parsing

### Low Priority

- [ ] GUI tools
- [ ] Package manager
- [ ] Online playground
- [ ] Mobile interpreter

## 📧 Contact

- **Issues**: [GitHub Issues](https://github.com/mohamedx2/interpreter/issues)
- **Discussions**: [GitHub Discussions](https://github.com/mohamedx2/interpreter/discussions)
- **Email**: contact@mohamedalihamroun.me

## 📄 License

By contributing, you agree that your contributions will be licensed under the MIT License.

## 🙏 Thank You

Thank you for contributing to Hamroun! Your efforts help make programming more accessible to French speakers worldwide.

---

**Happy Coding! 🇫🇷**
