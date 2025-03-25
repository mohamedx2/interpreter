package parser

import (
	"interpreter/ast"
	"interpreter/lexer"
	"interpreter/token"
	"strconv"
)

// Add precedence constants
const (
	_ int = iota
	LOWEST
	EQUALS      // ==
	LESSGREATER // > or <
	SUM         // +
	PRODUCT     // *
	PREFIX      // -X or !X
	CALL        // myFunction(X)
)

// Precedence table
var precedences = map[token.TokenType]int{
	token.PLUS:       SUM,
	token.MINUS:      SUM,
	token.SLASH:      PRODUCT,
	token.ASTERISK:   PRODUCT,
	token.EGAL:       EQUALS,
	token.DIFFERENT:  EQUALS,
	token.PLUS_GRAND: LESSGREATER,
	token.PLUS_PETIT: LESSGREATER,
}

type Parser struct {
	l *lexer.Lexer

	curToken  token.Token
	peekToken token.Token

	prefixParseFns map[token.TokenType]prefixParseFn
	infixParseFns  map[token.TokenType]infixParseFn
}

type prefixParseFn func() ast.Expression
type infixParseFn func(ast.Expression) ast.Expression

func New(l *lexer.Lexer) *Parser {
	p := &Parser{l: l}

	// Initialize maps
	p.prefixParseFns = make(map[token.TokenType]prefixParseFn)
	p.registerPrefix(token.IDENT, p.parseIdentifier)
	p.registerPrefix(token.INT, p.parseIntegerLiteral)
	p.registerPrefix(token.SI, p.parseIfExpression)
	p.registerPrefix(token.LPAREN, p.parseGroupedExpression)
	p.registerPrefix(token.BOUCLE, p.parseSimpleLoop)

	p.infixParseFns = make(map[token.TokenType]infixParseFn)
	p.registerInfix(token.PLUS, p.parseInfixExpression)
	p.registerInfix(token.MINUS, p.parseInfixExpression)
	p.registerInfix(token.SLASH, p.parseInfixExpression)
	p.registerInfix(token.ASTERISK, p.parseInfixExpression)
	p.registerInfix(token.EGAL, p.parseInfixExpression)
	p.registerInfix(token.DIFFERENT, p.parseInfixExpression)
	p.registerInfix(token.PLUS_GRAND, p.parseInfixExpression)
	p.registerInfix(token.PLUS_PETIT, p.parseInfixExpression)

	// Read two tokens to initialize both curToken and peekToken
	p.nextToken()
	p.nextToken()

	return p
}

func (p *Parser) registerPrefix(tokenType token.TokenType, fn prefixParseFn) {
	p.prefixParseFns[tokenType] = fn
}

func (p *Parser) registerInfix(tokenType token.TokenType, fn infixParseFn) {
	p.infixParseFns[tokenType] = fn
}

func (p *Parser) parseIdentifier() ast.Expression {
	return &ast.Identifier{Token: p.curToken, Value: p.curToken.Literal}
}

func (p *Parser) parseIntegerLiteral() ast.Expression {
	lit := &ast.IntegerLiteral{Token: p.curToken}

	value, err := strconv.ParseInt(p.curToken.Literal, 0, 64)
	if err != nil {
		return nil
	}

	lit.Value = value
	return lit
}

func (p *Parser) parseInfixExpression(left ast.Expression) ast.Expression {
	expression := &ast.InfixExpression{
		Token:    p.curToken,
		Operator: p.curToken.Literal,
		Left:     left,
	}

	precedence := p.curPrecedence()
	p.nextToken()
	expression.Right = p.parseExpression(precedence)

	return expression
}

func (p *Parser) nextToken() {
	p.curToken = p.peekToken
	p.peekToken = p.l.NextToken()
}

func (p *Parser) ParseProgram() *ast.Program {
	program := &ast.Program{}
	program.Statements = []ast.Statement{}

	for p.curToken.Type != token.EOF {
		if stmt := p.parseStatement(); stmt != nil {
			program.Statements = append(program.Statements, stmt)
		}
		p.nextToken()
	}

	return program
}

func (p *Parser) parseStatement() ast.Statement {
	switch p.curToken.Type {
	case token.IDENT:
		if p.peekTokenIs(token.ASSIGN) {
			return p.parseAssignmentStatement()
		}
		fallthrough
	case token.BOUCLE:
		// Handle BOUCLE directly as a statement
		return &ast.ExpressionStatement{
			Token:      p.curToken,
			Expression: p.parseSimpleLoop(),
		}
	default:
		return p.parseExpressionStatement()
	}
}

func (p *Parser) parseAssignmentStatement() *ast.AssignmentStatement {
	stmt := &ast.AssignmentStatement{
		Token: p.curToken,
		Name:  &ast.Identifier{Token: p.curToken, Value: p.curToken.Literal},
	}

	if !p.expectPeek(token.ASSIGN) {
		return nil
	}

	p.nextToken() // skip the =

	stmt.Value = p.parseExpression(LOWEST)

	if p.peekTokenIs(token.SEMICOLON) {
		p.nextToken()
	}

	return stmt
}

func (p *Parser) parseExpressionStatement() *ast.ExpressionStatement {
	stmt := &ast.ExpressionStatement{Token: p.curToken}

	stmt.Expression = p.parseExpression(LOWEST)

	// Skip optional semicolons and newlines
	for p.peekTokenIs(token.SEMICOLON) {
		p.nextToken()
	}

	return stmt
}

// Handle parsing block statements
func (p *Parser) parseBlockStatement() *ast.BlockStatement {
	block := &ast.BlockStatement{Token: p.curToken}
	block.Statements = []ast.Statement{}

	p.nextToken()

	for !p.curTokenIs(token.FIN) && !p.curTokenIs(token.EOF) {
		stmt := p.parseStatement()
		if stmt != nil {
			block.Statements = append(block.Statements, stmt)
		}
		p.nextToken()
	}

	return block
}

// Add parsing for while loops
func (p *Parser) parseWhileLoop() *ast.WhileLoop {
	loop := &ast.WhileLoop{Token: p.curToken}

	p.nextToken()
	loop.Condition = p.parseExpression(LOWEST)

	// Skip to the body
	p.nextToken()
	loop.Body = p.parseBlockStatement()

	if !p.expectPeek(token.FIN) {
		return nil
	}

	return loop
}

func (p *Parser) parseExpression(precedence int) ast.Expression {
	prefix := p.prefixParseFns[p.curToken.Type]
	if prefix == nil {
		return nil
	}
	leftExp := prefix()

	for !p.peekTokenIs(token.SEMICOLON) && precedence < p.peekPrecedence() {
		infix := p.infixParseFns[p.peekToken.Type]
		if infix == nil {
			return leftExp
		}

		p.nextToken()

		leftExp = infix(leftExp)
	}

	return leftExp
}

func (p *Parser) curTokenIs(t token.TokenType) bool {
	return p.curToken.Type == t
}

func (p *Parser) peekTokenIs(t token.TokenType) bool {
	return p.peekToken.Type == t
}

func (p *Parser) peekPrecedence() int {
	if p, ok := precedences[p.peekToken.Type]; ok {
		return p
	}
	return LOWEST
}

func (p *Parser) curPrecedence() int {
	if p, ok := precedences[p.curToken.Type]; ok {
		return p
	}
	return LOWEST
}

func (p *Parser) expectPeek(t interface{}) bool {
	switch t := t.(type) {
	case token.TokenType:
		if p.peekTokenIs(t) {
			p.nextToken()
			return true
		}
	case string:
		if p.peekToken.Literal == t {
			p.nextToken()
			return true
		}
	}
	return false
}

// Add function to parse if expressions
func (p *Parser) parseIfExpression() ast.Expression {
	expression := &ast.IfExpression{Token: p.curToken}

	// Parse condition
	p.nextToken()
	expression.Condition = p.parseExpression(LOWEST)

	// Parse consequence
	if !p.expectPeek(token.ALORS) {
		return nil
	}

	p.nextToken()
	expression.Consequence = p.parseExpression(LOWEST)

	// Parse alternative if SINON is present
	if p.peekTokenIs(token.SINON) {
		p.nextToken()
		p.nextToken() // Skip SINON token
		expression.Alternative = p.parseExpression(LOWEST)
	}

	// Expect FIN token at the end
	if !p.expectPeek(token.FIN) {
		return nil
	}

	return expression
}

// Add function to parse grouped expressions
func (p *Parser) parseGroupedExpression() ast.Expression {
	p.nextToken()

	exp := p.parseExpression(LOWEST)

	if !p.expectPeek(token.RPAREN) {
		return nil
	}

	return exp
}

func (p *Parser) parseSimpleLoop() ast.Expression {
	// Create the SimpleLoop node
	loop := &ast.SimpleLoop{Token: p.curToken}

	// Parse counter identifier
	if !p.expectPeek(token.IDENT) {
		return nil
	}
	loop.Counter = &ast.Identifier{Token: p.curToken, Value: p.curToken.Literal}

	// Parse "DE" keyword
	if !p.expectPeek(token.DE) {
		return nil
	}

	// Parse start value
	p.nextToken() // Move past DE
	loop.Start = p.parseExpression(LOWEST)

	// Parse "A" keyword
	if !p.expectPeek(token.A) {
		return nil
	}

	// Parse end value
	p.nextToken() // Move past A
	loop.End = p.parseExpression(LOWEST)

	// Create a new block statement for the body
	blockStmt := &ast.BlockStatement{
		Token:      p.curToken,
		Statements: []ast.Statement{},
	}

	// Skip any semicolons
	for p.peekTokenIs(token.SEMICOLON) {
		p.nextToken()
	}
	p.nextToken() // Move to the first statement in the loop body

	// Parse statements until FIN
	for !p.curTokenIs(token.FIN) && !p.curTokenIs(token.EOF) {
		stmt := p.parseStatement()
		if stmt != nil {
			blockStmt.Statements = append(blockStmt.Statements, stmt)
		}
		p.nextToken()
	}

	loop.Body = blockStmt

	return loop
}
