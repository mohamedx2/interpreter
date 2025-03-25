package main

import (
	"fmt"
	"interpreter/evaluator"
	"interpreter/lexer"
	"interpreter/parser"
)

func main() {
	fmt.Println("=== Testing Simple Loop ===")

	code := `
somme = 0
BOUCLE i DE 1 A 5
  somme = somme + i
FIN
somme
`

	env := evaluator.NewEnvironment()

	// Parse and evaluate line by line to debug
	fmt.Println("\nExecuting line by line:")

	// Line 1: somme = 0
	line1 := "somme = 0"
	fmt.Printf("Line: %s\n", line1)
	l := lexer.New(line1)
	p := parser.New(l)
	program := p.ParseProgram()
	result := evaluator.Evaluate(program, env)
	fmt.Printf("Result: %s\n", result.String())
	fmt.Println("Environment:")
	for k, v := range env.GetAll() {
		fmt.Printf("  %s = %s\n", k, v.String())
	}

	// Line 2-4: BOUCLE
	loopCode := "BOUCLE i DE 1 A 5\n  somme = somme + i\nFIN"
	fmt.Printf("\nLine: %s\n", loopCode)
	l = lexer.New(loopCode)
	p = parser.New(l)
	program = p.ParseProgram()
	result = evaluator.Evaluate(program, env)
	fmt.Printf("Result: %s\n", result.String())
	fmt.Println("Environment after loop:")
	for k, v := range env.GetAll() {
		fmt.Printf("  %s = %s\n", k, v.String())
	}

	// Line 5: somme
	line5 := "somme"
	fmt.Printf("\nLine: %s\n", line5)
	l = lexer.New(line5)
	p = parser.New(l)
	program = p.ParseProgram()
	result = evaluator.Evaluate(program, env)
	fmt.Printf("Result: %s\n", result.String())

	// Full program execution
	fmt.Println("\n=== Full Program Execution ===")
	env = evaluator.NewEnvironment() // Start fresh
	l = lexer.New(code)
	p = parser.New(l)
	program = p.ParseProgram()
	fmt.Println("AST:")
	for i, stmt := range program.Statements {
		fmt.Printf("Statement %d: %s\n", i+1, stmt.String())
	}
	result = evaluator.Evaluate(program, env)
	fmt.Printf("\nFinal result: %s\n", result.String())
	fmt.Println("Final environment:")
	for k, v := range env.GetAll() {
		fmt.Printf("  %s = %s\n", k, v.String())
	}
}
