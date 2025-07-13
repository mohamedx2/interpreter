package main

import (
	"fmt"
	"interpreter/lexer"
	"interpreter/token"
)

func main() {
	code := `BOUCLE i DE 1 A 5
  somme = somme + i
FIN`

	fmt.Println("=== Token Analysis ===")
	fmt.Printf("Code:\n%s\n\n", code)

	l := lexer.New(code)
	for {
		tok := l.NextToken()
		fmt.Printf("Type: %-12s Literal: '%s'\n", tok.Type, tok.Literal)
		if tok.Type == token.EOF {
			break
		}
	}
}
