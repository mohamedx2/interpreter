package main

import (
	"fmt"
	"interpreter/evaluator"
	"interpreter/lexer"
	"interpreter/parser"
)

func main() {
	// Test several loop examples
	testLoopExample(`
somme = 0
BOUCLE i DE 1 A 5
  somme = somme + i
FIN
somme`, "Sum of numbers 1 to 5")

	testLoopExample(`
produit = 1
BOUCLE i DE 1 A 5
  produit = produit * i
FIN
produit`, "Factorial of 5")

	testLoopExample(`
BOUCLE i DE 1 A 3
  i * 2
FIN`, "Simple loop returning last value")
}

func testLoopExample(code string, description string) {
	fmt.Printf("\n===== Testing: %s =====\n", description)
	fmt.Printf("Code:\n%s\n\n", code)

	env := evaluator.NewEnvironment()
	l := lexer.New(code)
	p := parser.New(l)
	program := p.ParseProgram()

	if program == nil {
		fmt.Println("Failed to parse code")
		return
	}

	result := evaluator.Evaluate(program, env)
	fmt.Printf("Result: %s\n\n", result.String())

	fmt.Println("Environment after execution:")
	for k, v := range env.GetAll() {
		fmt.Printf("  %s = %s\n", k, v.String())
	}

	fmt.Println("=========================")
}
