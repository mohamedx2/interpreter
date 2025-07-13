package evaluator

import (
	"fmt"
	"interpreter/ast"
)

// Object represents a value in the interpreter
type Object interface {
	Type() ObjectType
	String() string
}

type ObjectType string

const (
	INTEGER_OBJ = "INTEGER"
	BOOLEAN_OBJ = "BOOLEAN"
	NULL_OBJ    = "NULL"
	ERROR_OBJ   = "ERROR"
)

// Integer represents an integer value
type Integer struct {
	Value int64
}

func (i *Integer) Type() ObjectType { return INTEGER_OBJ }
func (i *Integer) String() string   { return fmt.Sprintf("%d", i.Value) }

// Boolean represents a boolean value
type Boolean struct {
	Value bool
}

func (b *Boolean) Type() ObjectType { return BOOLEAN_OBJ }
func (b *Boolean) String() string {
	if b.Value {
		return "vrai"
	}
	return "faux"
}

// Null represents a null value
type Null struct{}

func (n *Null) Type() ObjectType { return NULL_OBJ }
func (n *Null) String() string   { return "null" }

// Error represents an error
type Error struct {
	Message string
}

func (e *Error) Type() ObjectType { return ERROR_OBJ }
func (e *Error) String() string   { return "ERROR: " + e.Message }

// Environment stores variable bindings
type Environment struct {
	store map[string]Object
}

func NewEnvironment() *Environment {
	return &Environment{
		store: make(map[string]Object),
	}
}

func (e *Environment) Get(name string) (Object, bool) {
	obj, ok := e.store[name]
	return obj, ok
}

func (e *Environment) Set(name string, val Object) Object {
	e.store[name] = val
	return val
}

// GetAll returns all key-value pairs in the environment
func (e *Environment) GetAll() map[string]Object {
	return e.store
}

// Update Evaluate function to use environment
func Evaluate(node ast.Node, env *Environment) Object {
	switch node := node.(type) {
	case *ast.Program:
		return evalProgram(node, env)
	case *ast.ExpressionStatement:
		return Evaluate(node.Expression, env)
	case *ast.IntegerLiteral:
		return &Integer{Value: node.Value}
	case *ast.Identifier:
		return evalIdentifier(node, env)
	case *ast.InfixExpression:
		left := Evaluate(node.Left, env)
		right := Evaluate(node.Right, env)
		return evalInfixExpression(node.Operator, left, right)
	case *ast.AssignmentStatement:
		val := Evaluate(node.Value, env)
		env.Set(node.Name.Value, val)
		return val
	case *ast.IfExpression:
		return evalIfExpression(node, env)
	case *ast.BlockStatement:
		return evalBlockStatement(node, env)
	case *ast.WhileLoop:
		return evalWhileLoop(node, env)
	case *ast.SimpleLoop:
		return evalSimpleLoop(node, env)
	}

	return &Null{}
}

func evalProgram(program *ast.Program, env *Environment) Object {
	var result Object = &Null{}

	for _, statement := range program.Statements {
		result = Evaluate(statement, env)

		if isError(result) {
			return result
		}
	}

	return result
}

func evalBlockStatement(block *ast.BlockStatement, env *Environment) Object {
	var result Object = &Null{}

	for _, statement := range block.Statements {
		result = Evaluate(statement, env)

		if isError(result) {
			return result
		}
	}

	return result
}

func evalIdentifier(node *ast.Identifier, env *Environment) Object {
	if val, ok := env.Get(node.Value); ok {
		return val
	}
	return &Error{Message: "identifier not found: " + node.Value}
}

func evalInfixExpression(operator string, left, right Object) Object {
	if isError(left) {
		return left
	}
	if isError(right) {
		return right
	}

	if left.Type() == INTEGER_OBJ && right.Type() == INTEGER_OBJ {
		return evalIntegerInfixExpression(operator, left.(*Integer), right.(*Integer))
	}
	return &Error{Message: fmt.Sprintf("unknown operator: %s %s %s", left.Type(), operator, right.Type())}
}

func evalIntegerInfixExpression(operator string, left, right *Integer) Object {
	switch operator {
	case "+":
		return &Integer{Value: left.Value + right.Value}
	case "-":
		return &Integer{Value: left.Value - right.Value}
	case "*":
		return &Integer{Value: left.Value * right.Value}
	case "/":
		if right.Value == 0 {
			return &Error{Message: "division by zero"}
		}
		return &Integer{Value: left.Value / right.Value}
	case "==", "EGAL":
		return &Boolean{Value: left.Value == right.Value}
	case "!=", "DIFFERENT":
		return &Boolean{Value: left.Value != right.Value}
	case ">", "PLUS_GRAND":
		return &Boolean{Value: left.Value > right.Value}
	case "<", "PLUS_PETIT":
		return &Boolean{Value: left.Value < right.Value}
	default:
		return &Error{Message: fmt.Sprintf("unknown operator: %s", operator)}
	}
}

// Helper function to evaluate if expressions
func evalIfExpression(ie *ast.IfExpression, env *Environment) Object {
	condition := Evaluate(ie.Condition, env)
	if isError(condition) {
		return condition
	}

	if isTruthy(condition) {
		return Evaluate(ie.Consequence, env)
	} else if ie.Alternative != nil {
		return Evaluate(ie.Alternative, env)
	} else {
		return &Null{}
	}
}

func evalWhileLoop(wl *ast.WhileLoop, env *Environment) Object {
	var result Object = &Null{}

	for {
		condition := Evaluate(wl.Condition, env)
		if isError(condition) {
			return condition
		}

		if !isTruthy(condition) {
			break
		}

		result = Evaluate(wl.Body, env)
		if isError(result) {
			return result
		}
	}

	return result
}

func evalSimpleLoop(loop *ast.SimpleLoop, env *Environment) Object {
	// Get start value
	startObj := Evaluate(loop.Start, env)
	if isError(startObj) {
		return startObj
	}

	// Get end value
	endObj := Evaluate(loop.End, env)
	if isError(endObj) {
		return endObj
	}

	// Validate types
	if startObj.Type() != INTEGER_OBJ || endObj.Type() != INTEGER_OBJ {
		return &Error{Message: "loop bounds must be integers"}
	}

	start := startObj.(*Integer).Value
	end := endObj.(*Integer).Value

	// Create result variable
	var result Object = &Null{}

	// Execute loop for each value in range
	for i := start; i <= end; i++ {
		// Set counter variable
		env.Set(loop.Counter.Value, &Integer{Value: i})

		// If body is a block, execute each statement
		if blockStmt, ok := loop.Body.(*ast.BlockStatement); ok {
			for _, stmt := range blockStmt.Statements {
				result = Evaluate(stmt, env)
				if isError(result) {
					return result
				}
			}
		} else {
			// Otherwise evaluate body as single expression
			result = Evaluate(loop.Body, env)
		}
	}

	return result
}

func isTruthy(obj Object) bool {
	switch obj := obj.(type) {
	case *Integer:
		return obj.Value != 0
	case *Boolean:
		return obj.Value
	case *Null:
		return false
	default:
		return true
	}
}

func isError(obj Object) bool {
	if obj != nil {
		return obj.Type() == ERROR_OBJ
	}
	return false
}
