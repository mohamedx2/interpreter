package repl

import (
	"bufio"
	"fmt"
	"interpreter/evaluator"
	"interpreter/lexer"
	"interpreter/parser"
	"io"
	"strings"
)

const PROMPT = ">> "

func Start(in io.Reader, out io.Writer) {
	scanner := bufio.NewScanner(in)
	env := evaluator.NewEnvironment()

	for {
		fmt.Fprintf(out, PROMPT)
		if !scanner.Scan() {
			return
		}

		line := scanner.Text()
		l := lexer.New(line)
		p := parser.New(l)

		program := p.ParseProgram()
		if program != nil {
			if len(program.Statements) > 0 {
				// Show both AST and evaluated result
				result := evaluator.Evaluate(program, env)
				io.WriteString(out, program.String())
				io.WriteString(out, " = ")
				io.WriteString(out, result.String())
				io.WriteString(out, "\n")

				// Show environment if it's not empty and has changed
				if len(env.GetAll()) > 0 {
					vars := []string{}
					for k, v := range env.GetAll() {
						vars = append(vars, fmt.Sprintf("%s = %s", k, v.String()))
					}
					if len(vars) > 0 {
						io.WriteString(out, "Variables: ")
						io.WriteString(out, strings.Join(vars, ", "))
						io.WriteString(out, "\n")
					}
				}
			} else {
				io.WriteString(out, "No valid statements found\n")
			}
		} else {
			io.WriteString(out, "Failed to parse input\n")
		}
	}
}
