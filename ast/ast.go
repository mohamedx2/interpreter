package ast

import (
	"bytes"
	"interpreter/token"
)

type Node interface {
	TokenLiteral() string
	String() string
}

type Statement interface {
	Node
	statementNode()
}

type Expression interface {
	Node
	expressionNode()
}

type Program struct {
	Statements []Statement
}

func (p *Program) TokenLiteral() string {
	if len(p.Statements) > 0 {
		return p.Statements[0].TokenLiteral()
	}
	return ""
}

func (p *Program) String() string {
	var out bytes.Buffer

	for _, s := range p.Statements {
		out.WriteString(s.String())
	}

	return out.String()
}

type Identifier struct {
	Token token.Token
	Value string
}

func (i *Identifier) expressionNode()      {}
func (i *Identifier) TokenLiteral() string { return i.Token.Literal }
func (i *Identifier) String() string       { return i.Value }

type IntegerLiteral struct {
	Token token.Token
	Value int64
}

func (il *IntegerLiteral) expressionNode()      {}
func (il *IntegerLiteral) TokenLiteral() string { return il.Token.Literal }
func (il *IntegerLiteral) String() string       { return il.Token.Literal }

type ExpressionStatement struct {
	Token      token.Token
	Expression Expression
}

func (es *ExpressionStatement) statementNode()       {}
func (es *ExpressionStatement) TokenLiteral() string { return es.Token.Literal }
func (es *ExpressionStatement) String() string {
	if es.Expression == nil {
		return ""
	}
	return es.Expression.String()
}

// Add support for binary expressions
type InfixExpression struct {
	Token    token.Token // The operator token, e.g. +
	Left     Expression
	Operator string
	Right    Expression
}

func (ie *InfixExpression) expressionNode()      {}
func (ie *InfixExpression) TokenLiteral() string { return ie.Token.Literal }
func (ie *InfixExpression) String() string {
	var out bytes.Buffer

	out.WriteString("(")
	out.WriteString(ie.Left.String())
	out.WriteString(" " + ie.Operator + " ")
	out.WriteString(ie.Right.String())
	out.WriteString(")")

	return out.String()
}

// Assignment statement
type AssignmentStatement struct {
	Token token.Token // The '=' token
	Name  *Identifier
	Value Expression
}

func (as *AssignmentStatement) statementNode()       {}
func (as *AssignmentStatement) TokenLiteral() string { return as.Token.Literal }
func (as *AssignmentStatement) String() string {
	var out bytes.Buffer

	out.WriteString(as.Name.String())
	out.WriteString(" = ")

	if as.Value != nil {
		out.WriteString(as.Value.String())
	}

	return out.String()
}

// IfExpression represents an SI-ALORS-SINON expression
type IfExpression struct {
	Token       token.Token // The 'SI' token
	Condition   Expression
	Consequence Expression
	Alternative Expression
}

func (ie *IfExpression) expressionNode()      {}
func (ie *IfExpression) TokenLiteral() string { return ie.Token.Literal }
func (ie *IfExpression) String() string {
	var out bytes.Buffer

	out.WriteString("SI ")
	out.WriteString(ie.Condition.String())
	out.WriteString(" ALORS ")
	out.WriteString(ie.Consequence.String())

	if ie.Alternative != nil {
		out.WriteString(" SINON ")
		out.WriteString(ie.Alternative.String())
	}

	out.WriteString(" FIN")

	return out.String()
}

// ForLoop represents a POUR loop (for loop)
type ForLoop struct {
	Token     token.Token // The 'POUR' token
	Init      Statement   // Initialization (typically an assignment)
	Condition Expression  // Loop condition
	Update    Statement   // Update statement (typically an assignment)
	Body      Statement   // Loop body
}

func (fl *ForLoop) statementNode()       {}
func (fl *ForLoop) TokenLiteral() string { return fl.Token.Literal }
func (fl *ForLoop) String() string {
	var out bytes.Buffer

	out.WriteString("POUR ")
	if fl.Init != nil {
		out.WriteString(fl.Init.String())
	}
	out.WriteString("; ")
	if fl.Condition != nil {
		out.WriteString(fl.Condition.String())
	}
	out.WriteString("; ")
	if fl.Update != nil {
		out.WriteString(fl.Update.String())
	}
	out.WriteString(" ")
	if fl.Body != nil {
		out.WriteString(fl.Body.String())
	}
	out.WriteString(" FIN")

	return out.String()
}

// WhileLoop represents a TANTQUE loop (while loop)
type WhileLoop struct {
	Token     token.Token // The 'TANTQUE' token
	Condition Expression
	Body      Statement
}

func (wl *WhileLoop) statementNode()       {}
func (wl *WhileLoop) TokenLiteral() string { return wl.Token.Literal }
func (wl *WhileLoop) String() string {
	var out bytes.Buffer

	out.WriteString("TANTQUE ")
	out.WriteString(wl.Condition.String())
	out.WriteString(" ")
	if wl.Body != nil {
		out.WriteString(wl.Body.String())
	}
	out.WriteString(" FIN")

	return out.String()
}

// BlockStatement is used to group statements
type BlockStatement struct {
	Token      token.Token // The { token
	Statements []Statement
}

func (bs *BlockStatement) statementNode()       {}
func (bs *BlockStatement) TokenLiteral() string { return bs.Token.Literal }
func (bs *BlockStatement) String() string {
	var out bytes.Buffer

	for _, s := range bs.Statements {
		out.WriteString(s.String())
		out.WriteString("\n")
	}

	return out.String()
}

// SimpleLoop represents a BOUCLE loop (simpler loop construct)
type SimpleLoop struct {
	Token   token.Token // The 'BOUCLE' token
	Counter *Identifier // Loop counter
	Start   Expression  // Start value
	End     Expression  // End value
	Body    Statement   // Loop body
}

func (sl *SimpleLoop) expressionNode()      {}
func (sl *SimpleLoop) TokenLiteral() string { return sl.Token.Literal }
func (sl *SimpleLoop) String() string {
	var out bytes.Buffer

	out.WriteString("BOUCLE ")
	out.WriteString(sl.Counter.String())
	out.WriteString(" DE ")
	out.WriteString(sl.Start.String())
	out.WriteString(" A ")
	out.WriteString(sl.End.String())
	out.WriteString(" { ")

	if sl.Body != nil {
		out.WriteString(sl.Body.String())
	}

	out.WriteString(" } FIN")

	return out.String()
}

// Comment represents a comment in the code
type Comment struct {
	Token token.Token
	Text  string
}

func (c *Comment) statementNode()       {}
func (c *Comment) TokenLiteral() string { return c.Token.Literal }
func (c *Comment) String() string       { return "# " + c.Text }
