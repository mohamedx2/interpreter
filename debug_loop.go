package main

import (
	"fmt"
	"interpreter/ast"
	"interpreter/lexer"
	"interpreter/parser"
)

func main() {
	code := `somme = 0
BOUCLE i DE 1 A 5
  somme = somme + i
FIN
somme`

	fmt.Println("=== Loop Parsing Debug ===")
	fmt.Printf("Code:\n%s\n\n", code)

	l := lexer.New(code)
	p := parser.New(l)
	program := p.ParseProgram()

	fmt.Printf("Number of statements: %d\n", len(program.Statements))
	for i, stmt := range program.Statements {
		fmt.Printf("Statement %d: '%s' (Type: %T)\n", i+1, stmt.String(), stmt)

		if exprStmt, ok := stmt.(*ast.ExpressionStatement); ok {
			if exprStmt.Expression != nil {
				fmt.Printf("  Expression: '%s' (Type: %T)\n", exprStmt.Expression.String(), exprStmt.Expression)

				// Check if it's a SimpleLoop
				if simpleLoop, ok := exprStmt.Expression.(*ast.SimpleLoop); ok {
					fmt.Printf("    Loop Counter: %s\n", simpleLoop.Counter.String())
					fmt.Printf("    Loop Start: %s\n", simpleLoop.Start.String())
					fmt.Printf("    Loop End: %s\n", simpleLoop.End.String())
					if simpleLoop.Body != nil {
						fmt.Printf("    Loop Body: %s\n", simpleLoop.Body.String())
					} else {
						fmt.Printf("    Loop Body: nil\n")
					}
				}
			} else {
				fmt.Printf("  Expression: nil\n")
			}
		}
	}
}
