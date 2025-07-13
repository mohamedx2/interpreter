package main

import (
	"fmt"
	"interpreter/ast"
	"interpreter/evaluator"
	"interpreter/lexer"
	"interpreter/parser"
	"interpreter/token"
)

func main() {
	fmt.Println("=== Debug Test ===")

	// Create environment and set variables
	env := evaluator.NewEnvironment()
	env.Set("x", &evaluator.Integer{Value: 5})
	env.Set("y", &evaluator.Integer{Value: 6})

	fmt.Println("Environment before test:")
	for k, v := range env.GetAll() {
		fmt.Printf("  %s = %s\n", k, v.String())
	}

	// Test parsing "x + y"
	input := "x + y"
	fmt.Printf("\nTesting input: %s\n", input)

	// Print tokens
	fmt.Println("Tokens:")
	l := lexer.New(input)
	for {
		tok := l.NextToken()
		fmt.Printf("  Type: %s, Literal: %s\n", tok.Type, tok.Literal)
		if tok.Type == token.EOF {
			break
		}
	}
	// Parse
	l = lexer.New(input)
	p := parser.New(l)

	program := p.ParseProgram()

	fmt.Printf("\nParsed AST: %s\n", program.String())
	fmt.Printf("Number of statements: %d\n", len(program.Statements))

	for i, stmt := range program.Statements {
		fmt.Printf("Statement %d: '%s' (Type: %T)\n", i+1, stmt.String(), stmt)
		if exprStmt, ok := stmt.(*ast.ExpressionStatement); ok {
			if exprStmt.Expression != nil {
				fmt.Printf("  Expression: '%s' (Type: %T)\n", exprStmt.Expression.String(), exprStmt.Expression)
			} else {
				fmt.Printf("  Expression: nil\n")
			}
		}
	}

	// Evaluate
	result := evaluator.Evaluate(program, env)
	fmt.Printf("\nResult: %s\n", result.String())
	fmt.Printf("Result type: %s\n", result.Type())
}
