package main

import (
	"fmt"
	"interpreter/lexer"
	"interpreter/parser"
	"interpreter/token"
)

func main() {
	code := `BOUCLE i DE 1 A 5
  somme = somme + i
FIN`

	fmt.Println("=== Simple Loop Parse Debug ===")
	fmt.Printf("Code:\n%s\n\n", code)

	// First, let's see what tokens we get
	fmt.Println("Tokens:")
	l := lexer.New(code)
	for {
		tok := l.NextToken()
		fmt.Printf("Type: %-12s Literal: '%s'\n", tok.Type, tok.Literal)
		if tok.Type == token.EOF {
			break
		}
	}

	// Now let's try parsing
	fmt.Println("\nParsing:")
	l = lexer.New(code)
	p := parser.New(l)

	program := p.ParseProgram()

	fmt.Printf("\nNumber of statements: %d\n", len(program.Statements))
	for i, stmt := range program.Statements {
		fmt.Printf("Statement %d: '%s' (Type: %T)\n", i+1, stmt.String(), stmt)
	}
}
