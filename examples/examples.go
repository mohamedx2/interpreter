package main

import (
	"fmt"
	"interpreter/evaluator"
	"interpreter/lexer"
	"interpreter/parser"
	"strings"
)

func main() {
	// Create a shared environment for all examples
	env := evaluator.NewEnvironment()

	// Simple arithmetic example
	testExample("5 + 10", "Simple addition", env)

	// French keywords example
	testExample("SI 5 ALORS 10 SINON 0 FIN", "Conditional statement", env)

	// Variable example
	testExample("x = 5", "Variable assignment", env)
	testExample("x", "Variable retrieval", env)

	// More complex examples
	testExample("SI x ALORS y + 5 SINON z - 3 FIN", "Complex conditional", env)
	testExample("(5 + 10) * 2", "Complex arithmetic", env)

	// Multiple statements with shared environment
	multiExample := "x = 10\ny = 20\nx + y"
	fmt.Printf("\n--- Testing: Multiple statements ---\n")
	fmt.Printf("Input:\n%s\n", formatMultiline(multiExample))
	testMultiStatements(multiExample, env)

	// Test built-in functions and more complex operations
	testExample("x = 5\nx * x", "Expression with prior variable", env)

	// Test comparisons
	testExample("5 EGAL 5", "Comparison equals", env)
	testExample("5 DIFFERENT 10", "Comparison not equals", env)
	testExample("10 PLUS_GRAND 5", "Comparison greater than", env)
	testExample("5 PLUS_PETIT 10", "Comparison less than", env)

	// Test loop
	testExample(`
# Exemple de boucle
BOUCLE i DE 1 A 5
  i * 2
FIN
`, "Simple loop", env)
}

func formatMultiline(input string) string {
	lines := strings.Split(input, "\n")
	var result strings.Builder
	for _, line := range lines {
		result.WriteString("  " + line + "\n")
	}
	return result.String()
}

func testExample(input string, description string, env *evaluator.Environment) {
	fmt.Printf("\n--- Testing: %s ---\n", description)
	fmt.Printf("Input: %s\n", input)

	l := lexer.New(input)
	p := parser.New(l)
	program := p.ParseProgram()

	fmt.Printf("Parsed AST: %s\n", program.String())

	// Run the evaluator
	result := evaluator.Evaluate(program, env)
	fmt.Printf("Evaluated Result: %s\n", result.String())

	// Print tokens
	fmt.Println("Tokens:")
	l = lexer.New(input) // Reset lexer
	for {
		tok := l.NextToken()
		fmt.Printf("  Type: %s, Literal: %s\n", tok.Type, tok.Literal)
		if tok.Type == "EOF" {
			break
		}
	}
	fmt.Println("-------------------")
}

func testMultiStatements(input string, env *evaluator.Environment) {
	l := lexer.New(input)
	p := parser.New(l)
	program := p.ParseProgram()

	fmt.Println("Parsed AST:")
	for i, stmt := range program.Statements {
		fmt.Printf("  %d: %s\n", i+1, stmt.String())
	}

	// Run the evaluator
	result := evaluator.Evaluate(program, env)
	fmt.Printf("Evaluated Result: %s\n", result.String())

	// Show final environment state
	fmt.Println("Environment after execution:")
	for k, v := range env.GetAll() {
		fmt.Printf("  %s = %s\n", k, v.String())
	}

	// Print tokens
	fmt.Println("Tokens:")
	l = lexer.New(input) // Reset lexer
	for {
		tok := l.NextToken()
		fmt.Printf("  Type: %s, Literal: %s\n", tok.Type, tok.Literal)
		if tok.Type == "EOF" {
			break
		}
	}
	fmt.Println("-------------------")
}
