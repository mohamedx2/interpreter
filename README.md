# French Programming Language Interpreter

This is an interpreter for a simple programming language with French keywords, built in Go. The interpreter supports arithmetic operations, conditional statements, loops, variable assignments, and comparisons using French language constructs.

## Features

### ✅ Working Features
- **French language keywords** (SI, ALORS, SINON, BOUCLE, etc.)
- **Integer literals and identifiers**
- **Basic arithmetic operations** (+, -, *, /)
- **Variable assignments** (x = 5)
- **Conditional statements** (SI-ALORS-SINON-FIN)
- **Comparison operations** (EGAL, DIFFERENT, PLUS_GRAND, PLUS_PETIT)
- **Boolean values** (vrai/faux)
- **Comments** using # symbol
- **Interactive REPL**
- **Grouped expressions** with parentheses

### 🚧 In Development
- **Loop constructs** (BOUCLE - partially implemented)
- **Multiple statement execution**
- **Variable scope in loops**

## Running the interpreter

```bash
# Run the interactive REPL
go run main.go

# Run all examples and tests
go run examples/examples.go

# Run custom examples
go run examples/custom_example.go

# Run simple loop tests
go run examples/simple_loop.go
```

## Language Syntax

### Variable Assignment
```french
x = 5
nom = "Jean"
```

### Arithmetic Operations
```french
somme = 5 + 10        # Addition
difference = 20 - 5   # Subtraction
produit = 4 * 6       # Multiplication
quotient = 15 / 3     # Division
complexe = (5 + 10) * 2  # Grouped operations
```

### Conditional Statements
```french
# Simple conditional
SI 5 ALORS 10 SINON 0 FIN

# With variables
x = 10
SI x PLUS_GRAND 5 ALORS x * 2 SINON x / 2 FIN
```

### Comparison Operations
```french
5 EGAL 5           # Returns: vrai (true)
5 DIFFERENT 10     # Returns: vrai (true)
10 PLUS_GRAND 5    # Returns: vrai (true)
5 PLUS_PETIT 10    # Returns: vrai (true)
```

### Comments
```french
# Ceci est un commentaire
x = 5  # Commentaire en fin de ligne
```

### Loop Constructs (In Development)
```french
# Simple loop structure
BOUCLE i DE 1 A 5
  i * 2
FIN
```

## Keywords Reference

| French Keyword | English Equivalent | Usage |
|----------------|-------------------|-------|
| `SI` | If | Conditional statements |
| `ALORS` | Then | Conditional consequence |
| `SINON` | Else | Conditional alternative |
| `FIN` | End | Closes blocks |
| `BOUCLE` | Loop | Loop construct |
| `DE` | From | Loop start |
| `A` | To | Loop end |
| `EGAL` | Equal | Equality comparison |
| `DIFFERENT` | Not equal | Inequality comparison |
| `PLUS_GRAND` | Greater than | Greater than comparison |
| `PLUS_PETIT` | Less than | Less than comparison |
| `POUR` | For | For loop (planned) |
| `TANTQUE` | While | While loop (planned) |
| `RETOUR` | Return | Return statement (planned) |

## Example Programs

### Calculator
```french
# Calculatrice simple
a = 15
b = 3
somme = a + b
difference = a - b
produit = a * b
quotient = a / b
```

### Conditional Logic
```french
# Déterminer le maximum
x = 10
y = 5
maximum = SI x PLUS_GRAND y ALORS x SINON y FIN
```

### Working with Comparisons
```french
# Tests de comparaison
test1 = 5 EGAL 5        # vrai
test2 = 10 DIFFERENT 5  # vrai
test3 = 10 PLUS_GRAND 5 # vrai
test4 = 3 PLUS_PETIT 10 # vrai
```

## Interactive REPL

Start the REPL with `go run main.go` and try:

```
>> x = 10
>> y = 5
>> x + y
>> SI x PLUS_GRAND y ALORS x SINON y FIN
>> (x + y) * 2
```

## Test Results

The interpreter successfully handles:
- ✅ Simple arithmetic: `5 + 10` → `15`
- ✅ Conditionals: `SI 5 ALORS 10 SINON 0 FIN` → `10`
- ✅ Variable assignment: `x = 5` → `5`
- ✅ Complex arithmetic: `(5 + 10) * 2` → `30`
- ✅ Comparisons: `5 EGAL 5` → `vrai`
- ✅ Boolean operations: `10 PLUS_GRAND 5` → `vrai`

## Architecture

The interpreter consists of four main components:

1. **Lexer** (`lexer/lexer.go`) - Tokenizes French source code
2. **Parser** (`parser/parser.go`) - Builds Abstract Syntax Tree (AST)
3. **AST** (`ast/ast.go`) - Defines language constructs
4. **Evaluator** (`evaluator/evaluator.go`) - Executes the AST

## Contributing

The interpreter is actively being developed. Current focus areas:
- Completing loop implementation
- Adding string literals
- Implementing function definitions
- Adding more built-in functions

## License

Open source - feel free to contribute!
