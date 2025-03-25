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

	// Example of loop with sum calculation
	code := `
# Calcul de la somme des nombres de 1 à 5
somme = 0
BOUCLE i DE 1 A 5
  somme = somme + i
FIN
somme
`

	fmt.Println("==== Example: Calculating sum with loop ====")
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
