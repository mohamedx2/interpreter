package main

import (
	"fmt"
	"interpreter/evaluator"
	"interpreter/lexer"
	"interpreter/parser"
	"interpreter/token"
)

func main() {
	TestBoucleImplementation()
}

func TestBoucleImplementation() {
	fmt.Println("=== Testing BOUCLE implementation ===")

	// Test basic loop
	testCode := `
somme = 0
BOUCLE i DE 1 A 5
  somme = somme + i
FIN
somme
`
	fmt.Println("Code:")
	fmt.Println(testCode)

	// Create fresh environment
	env := evaluator.NewEnvironment()

	// Print all tokens to debug
	fmt.Println("\nTokens:")
	l := lexer.New(testCode)
	for {
		tok := l.NextToken()
		fmt.Printf("  Type: %s, Literal: %s\n", tok.Type, tok.Literal)
		if tok.Type == token.EOF {
			break
		}
	}

	// Parse the program
	l = lexer.New(testCode)
	p := parser.New(l)
	program := p.ParseProgram()

	if program == nil {
		fmt.Println("Failed to parse program")
		return
	}

	fmt.Println("\nAST Structure:")
	for i, stmt := range program.Statements {
		fmt.Printf("Statement %d: %s\n", i+1, stmt.String())
	}

	// Now evaluate step by step
	fmt.Println("\nEvaluating step by step...")

	// First statement: somme = 0
	if len(program.Statements) > 0 {
		result := evaluator.Evaluate(program.Statements[0], env)
		fmt.Printf("Statement 1: somme = 0 => %s\n", result.String())
		fmt.Println("Environment after statement 1:")
		for k, v := range env.GetAll() {
			fmt.Printf("  %s = %s\n", k, v.String())
		}
	}

	// Second statement: BOUCLE loop
	if len(program.Statements) > 1 {
		result := evaluator.Evaluate(program.Statements[1], env)
		fmt.Printf("Statement 2: BOUCLE... => %s\n", result.String())
		fmt.Println("Environment after statement 2:")
		for k, v := range env.GetAll() {
			fmt.Printf("  %s = %s\n", k, v.String())
		}
	}

	// Full evaluation
	fmt.Println("\nEvaluating the whole program...")
	result := evaluator.Evaluate(program, env)
	fmt.Printf("Result: %s\n", result.String())

	fmt.Println("\nFinal Environment:")
	for k, v := range env.GetAll() {
		fmt.Printf("  %s = %s\n", k, v.String())
	}

	// Test with a simpler example (should still work)
	fmt.Println("\n\n=== Testing simpler example ===")
	simpleCode := `
i = 0
i = i + 1
i
`
	l = lexer.New(simpleCode)
	p = parser.New(l)
	program = p.ParseProgram()
	result = evaluator.Evaluate(program, env)
	fmt.Printf("Result: %s\n", result.String())
	fmt.Println("Environment:")
	for k, v := range env.GetAll() {
		fmt.Printf("  %s = %s\n", k, v.String())
	}
}
