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

const PROMPT = "🇫🇷 >> "
const CONTINUATION_PROMPT = "   ... "

func Start(in io.Reader, out io.Writer) {
	scanner := bufio.NewScanner(in)
	env := evaluator.NewEnvironment()

	// Welcome banner
	printWelcomeBanner(out)

	for {
		fmt.Fprintf(out, PROMPT)
		if !scanner.Scan() {
			return
		}

		line := strings.TrimSpace(scanner.Text())

		// Handle special commands
		if line == "AIDE" || line == "aide" || line == "help" {
			printHelp(out)
			continue
		}

		if line == "SORTIR" || line == "sortir" || line == "exit" || line == "quit" {
			printGoodbye(out)
			return
		}

		if line == "EFFACER" || line == "effacer" || line == "clear" {
			env = evaluator.NewEnvironment()
			fmt.Fprintf(out, "✨ Environnement effacé\n\n")
			continue
		}

		if line == "VARIABLES" || line == "variables" || line == "vars" {
			showVariables(out, env)
			continue
		}

		if line == "" {
			continue
		}

		// Parse and evaluate
		l := lexer.New(line)
		p := parser.New(l)
		program := p.ParseProgram()

		if program != nil && len(program.Statements) > 0 {
			result := evaluator.Evaluate(program, env)

			// Enhanced output formatting
			if result.Type() == evaluator.ERROR_OBJ {
				fmt.Fprintf(out, "❌ Erreur: %s\n", result.String()[7:]) // Remove "ERROR: " prefix
			} else {
				// Show AST in a cleaner way for complex expressions
				astStr := program.String()
				if result.Type() != evaluator.NULL_OBJ {
					if len(astStr) > 50 {
						fmt.Fprintf(out, "📊 Résultat: %s\n", result.String())
					} else {
						fmt.Fprintf(out, "📊 %s = %s\n", astStr, result.String())
					}
				}
			}

			// Show environment changes in a prettier format
			showEnvironmentChanges(out, env)
		} else {
			fmt.Fprintf(out, "❌ Expression invalide\n")
		}

		fmt.Fprintf(out, "\n")
	}
}

func printWelcomeBanner(out io.Writer) {
	banner := `
╔══════════════════════════════════════════════════════════════╗
║              🇫🇷 LANGAGE DE PROGRAMMATION FRANÇAIS 🇫🇷              ║
║                          Version 1.0                        ║
╚══════════════════════════════════════════════════════════════╝

💡 Tapez 'AIDE' pour voir les commandes disponibles
🚪 Tapez 'SORTIR' pour quitter
📁 Utilisez 'hamroun.exe fichier.hamroun' pour exécuter un fichier

`
	fmt.Fprintf(out, banner)
}

func printHelp(out io.Writer) {
	help := `
╔══════════════════════════════════════════════════════════════╗
║                        📚 AIDE - COMMANDS                     ║
╚══════════════════════════════════════════════════════════════╝

🔢 ARITHMÉTIQUE:
   x = 5          → Assigner une variable
   x + y          → Addition
   x - y          → Soustraction  
   x * y          → Multiplication
   x / y          → Division

🔀 CONDITIONS:
   SI x PLUS_GRAND 5 ALORS y = 1 SINON y = 0 FIN
   
   Opérateurs: EGAL, DIFFERENT, PLUS_GRAND, PLUS_PETIT

🔄 BOUCLES:
   BOUCLE i DE 1 A 10
     total = total + i
   FIN

💻 COMMANDES SYSTÈME:
   AIDE          → Afficher cette aide
   VARIABLES     → Voir toutes les variables
   EFFACER       → Effacer toutes les variables
   SORTIR        → Quitter le programme

📖 EXEMPLES:
   x = 10
   y = x * 2
   SI y PLUS_GRAND 15 ALORS resultat = 1 SINON resultat = 0 FIN

`
	fmt.Fprintf(out, help)
}

func printGoodbye(out io.Writer) {
	goodbye := `
╔══════════════════════════════════════════════════════════════╗
║                    👋 AU REVOIR ET MERCI !                   ║
║                                                              ║
║           Continuez à programmer en français ! 🇫🇷             ║
╚══════════════════════════════════════════════════════════════╝

`
	fmt.Fprintf(out, goodbye)
}

func showVariables(out io.Writer, env *evaluator.Environment) {
	vars := env.GetAll()
	if len(vars) == 0 {
		fmt.Fprintf(out, "📭 Aucune variable définie\n")
		return
	}

	fmt.Fprintf(out, "\n📊 VARIABLES ACTUELLES:\n")
	fmt.Fprintf(out, "┌─────────────────┬─────────────────┬─────────────────┐\n")
	fmt.Fprintf(out, "│ Nom             │ Valeur          │ Type            │\n")
	fmt.Fprintf(out, "├─────────────────┼─────────────────┼─────────────────┤\n")

	for name, value := range vars {
		if value.Type() != evaluator.ERROR_OBJ {
			typeName := ""
			switch value.Type() {
			case evaluator.INTEGER_OBJ:
				typeName = "Entier"
			case evaluator.BOOLEAN_OBJ:
				typeName = "Booléen"
			case evaluator.NULL_OBJ:
				typeName = "Null"
			default:
				typeName = string(value.Type())
			}
			fmt.Fprintf(out, "│ %-15s │ %-15s │ %-15s │\n", name, value.String(), typeName)
		}
	}
	fmt.Fprintf(out, "└─────────────────┴─────────────────┴─────────────────┘\n")
}

func showEnvironmentChanges(out io.Writer, env *evaluator.Environment) {
	vars := env.GetAll()
	if len(vars) == 0 {
		return
	}

	// Show only non-error variables in a compact format
	validVars := make([]string, 0)
	for name, value := range vars {
		if value.Type() != evaluator.ERROR_OBJ {
			validVars = append(validVars, fmt.Sprintf("%s=%s", name, value.String()))
		}
	}

	if len(validVars) > 0 {
		if len(validVars) <= 3 {
			fmt.Fprintf(out, "💾 Variables: %s", strings.Join(validVars, ", "))
		} else {
			fmt.Fprintf(out, "💾 Variables: %s... (+%d autres)",
				strings.Join(validVars[:3], ", "), len(validVars)-3)
		}
	}
}
