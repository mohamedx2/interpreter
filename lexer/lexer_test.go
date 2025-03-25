package lexer

import (
	"interpreter/token"
	"testing"
)

func TestNextToken(t *testing.T) {
	input := `5 + 10 - 3
SI x ALORS y SINON z FIN`

	tests := []struct {
		expectedType    token.TokenType
		expectedLiteral string
	}{
		{token.INT, "5"},
		{token.PLUS, "+"},
		{token.INT, "10"},
		{token.MINUS, "-"},
		{token.INT, "3"},
		{token.SI, "SI"},
		{token.IDENT, "x"},
		{token.ALORS, "ALORS"},
		{token.IDENT, "y"},
		{token.SINON, "SINON"},
		{token.IDENT, "z"},
		{token.FIN, "FIN"},
		{token.EOF, ""},
	}

	l := New(input)

	for i, tt := range tests {
		tok := l.NextToken()

		if tok.Type != tt.expectedType {
			t.Fatalf("tests[%d] - tokentype wrong. expected=%q, got=%q",
				i, tt.expectedType, tok.Type)
		}

		if tok.Literal != tt.expectedLiteral {
			t.Fatalf("tests[%d] - literal wrong. expected=%q, got=%q",
				i, tt.expectedLiteral, tok.Literal)
		}
	}
}
