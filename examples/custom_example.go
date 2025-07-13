package main

import (
	"fmt"
	"interpreter/evaluator"
	"interpreter/lexer"
	"interpreter/parser"
)

func main() {
	// Create environment
	env := evaluator.NewEnvironment()

	// Test different features
	testArithmetic(env)
	testConditionals(env)
	testLoops(env)
	testComparisons(env)
}

func testArithmetic(env *evaluator.Environment) {
	fmt.Println("=== Testing Arithmetic ===")
	code := `
x = 10
y = 5
x + y
x - y
x * y
x / y
`

	fmt.Println("Code:")
	fmt.Println(code)

	l := lexer.New(code)
	p := parser.New(l)
	program := p.ParseProgram()

	result := evaluator.Evaluate(program, env)
	fmt.Println("\nResult:", result.String())

	// Show variables
	fmt.Println("\nEnvironment after execution:")
	for k, v := range env.GetAll() {
		fmt.Printf("  %s = %s\n", k, v.String())
	}
}

func testConditionals(env *evaluator.Environment) {
	fmt.Println("=== Testing Conditionals ===")
	code := `
x = 10
SI x PLUS_GRAND 5 ALORS x * 2 SINON x / 2 FIN
`

	fmt.Println("Code:")
	fmt.Println(code)

	l := lexer.New(code)
	p := parser.New(l)
	program := p.ParseProgram()

	result := evaluator.Evaluate(program, env)
	fmt.Println("\nResult:", result.String())

	// Show variables
	fmt.Println("\nEnvironment after execution:")
	for k, v := range env.GetAll() {
		fmt.Printf("  %s = %s\n", k, v.String())
	}
}

func testLoops(env *evaluator.Environment) {
	fmt.Println("=== Testing Loops ===")
	code := `
total = 0
BOUCLE i DE 1 A 10
  total = total + i
FIN
total
`

	fmt.Println("Code:")
	fmt.Println(code)

	l := lexer.New(code)
	p := parser.New(l)
	program := p.ParseProgram()

	result := evaluator.Evaluate(program, env)
	fmt.Println("\nResult:", result.String())

	// Show variables
	fmt.Println("\nEnvironment after execution:")
	for k, v := range env.GetAll() {
		fmt.Printf("  %s = %s\n", k, v.String())
	}
}

func testComparisons(env *evaluator.Environment) {
	fmt.Println("=== Testing Comparisons ===")
	code := `
5 EGAL 5
10 DIFFERENT 5
10 PLUS_GRAND 5
3 PLUS_PETIT 10
`

	fmt.Println("Code:")
	fmt.Println(code)

	l := lexer.New(code)
	p := parser.New(l)
	program := p.ParseProgram()

	result := evaluator.Evaluate(program, env)
	fmt.Println("\nResult:", result.String())

	// Show variables
	fmt.Println("\nEnvironment after execution:")
	for k, v := range env.GetAll() {
		fmt.Printf("  %s = %s\n", k, v.String())
	}
}
