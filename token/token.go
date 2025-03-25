package token

type TokenType string

type Token struct {
	Type    TokenType
	Literal string
}

const (
	ILLEGAL = "ILLEGAL"
	EOF     = "EOF"

	// Identifiers + literals
	IDENT = "IDENT"
	INT   = "INT"

	// Operators
	PLUS     = "+"
	MINUS    = "-"
	ASTERISK = "*"
	SLASH    = "/"
	ASSIGN   = "="

	// Comparison operators
	EGAL       = "EGAL"      // ==
	DIFFERENT  = "DIFFERENT" // !=
	PLUS_GRAND = ">"         // >
	PLUS_PETIT = "<"         // <

	// French Operators
	ET      = "ET"      // AND
	OU      = "OU"      // OR
	NON     = "NON"     // NOT
	ALORS   = "ALORS"   // THEN
	SI      = "SI"      // IF
	SINON   = "SINON"   // ELSE
	POUR    = "POUR"    // FOR
	TANTQUE = "TANTQUE" // WHILE
	RETOUR  = "RETOUR"  // RETURN
	FIN     = "FIN"     // END
	BOUCLE  = "BOUCLE"  // Loop
	DE      = "DE"      // From (for loops)
	A       = "A"       // To (for loops)

	// Comment
	COMMENT = "#"

	// Delimiters
	LPAREN    = "("
	RPAREN    = ")"
	SEMICOLON = ";"
)
