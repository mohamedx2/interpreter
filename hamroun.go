package main

import (
	"fmt"
	"interpreter/evaluator"
	"interpreter/lexer"
	"interpreter/parser"
	"interpreter/repl"
	"io/ioutil"
	"os"
	"path/filepath"
	"strings"
	"time"
)

func main() {
	if len(os.Args) < 2 {
		// No file provided, start REPL
		startREPL()
		return
	}

	filename := os.Args[1]

	// Check if file has .hamroun extension
	if !strings.HasSuffix(filename, ".hamroun") {
		printError("Le fichier doit avoir l'extension .hamroun")
		fmt.Printf("💡 Usage: hamroun.exe fichier.hamroun\n")
		os.Exit(1)
	}

	// Check if file exists
	if _, err := os.Stat(filename); os.IsNotExist(err) {
		printError(fmt.Sprintf("Le fichier '%s' n'existe pas", filename))
		os.Exit(1)
	}

	// Read and execute the file
	executeFile(filename)
}

func startREPL() {
	repl.Start(os.Stdin, os.Stdout)
}

func executeFile(filename string) {
	// Read file content
	content, err := ioutil.ReadFile(filename)
	if err != nil {
		printError(fmt.Sprintf("Erreur lors de la lecture du fichier: %s", err))
		os.Exit(1)
	}

	code := string(content)

	// Create lexer and parser
	l := lexer.New(code)
	p := parser.New(l)
	program := p.ParseProgram()

	if program == nil {
		printError(fmt.Sprintf("Impossible d'analyser le fichier %s", filename))
		os.Exit(1)
	}

	// Create environment and evaluate
	env := evaluator.NewEnvironment()

	// Enhanced execution header
	printExecutionHeader(filename)

	start := time.Now()
	result := evaluator.Evaluate(program, env)
	duration := time.Since(start)

	// Enhanced result display
	printResults(result, env, duration)

	printExecutionFooter()
}

func printExecutionHeader(filename string) {
	fmt.Printf("\n╔══════════════════════════════════════════════════════════════╗\n")
	fmt.Printf("║  🚀 EXÉCUTION: %-45s  ║\n", filepath.Base(filename))
	fmt.Printf("║  📅 %s                                     ║\n", time.Now().Format("15:04:05 - 02/01/2006"))
	fmt.Printf("╚══════════════════════════════════════════════════════════════╝\n\n")
}

func printResults(result evaluator.Object, env *evaluator.Environment, duration time.Duration) {
	// Show result if it's not null or error
	if result.Type() == evaluator.ERROR_OBJ {
		fmt.Printf("❌ ERREUR D'EXÉCUTION:\n")
		fmt.Printf("   %s\n\n", result.String()[7:]) // Remove "ERROR: " prefix
	} else if result.Type() != evaluator.NULL_OBJ {
		fmt.Printf("✅ RÉSULTAT FINAL:\n")
		fmt.Printf("   📊 %s\n\n", result.String())
	}

	// Show final environment in a beautiful table
	vars := env.GetAll()
	validVars := make(map[string]evaluator.Object)

	for name, value := range vars {
		if value.Type() != evaluator.ERROR_OBJ {
			validVars[name] = value
		}
	}

	if len(validVars) > 0 {
		fmt.Printf("💾 ÉTAT FINAL DES VARIABLES:\n")
		fmt.Printf("┌─────────────────────────┬─────────────────────────┬─────────────────┐\n")
		fmt.Printf("│ Nom                     │ Valeur                  │ Type            │\n")
		fmt.Printf("├─────────────────────────┼─────────────────────────┼─────────────────┤\n")

		for name, value := range validVars {
			typeName := getTypeName(value.Type())
			nameStr := truncateString(name, 23)
			valueStr := truncateString(value.String(), 23)
			fmt.Printf("│ %-23s │ %-23s │ %-15s │\n", nameStr, valueStr, typeName)
		}
		fmt.Printf("└─────────────────────────┴─────────────────────────┴─────────────────┘\n\n")
	}

	// Show execution stats
	fmt.Printf("⚡ STATISTIQUES D'EXÉCUTION:\n")
	fmt.Printf("   ⏱️  Temps d'exécution: %v\n", duration)
	fmt.Printf("   📊 Variables créées: %d\n", len(validVars))

	if result.Type() == evaluator.ERROR_OBJ {
		fmt.Printf("   ❌ Statut: ERREUR\n")
	} else {
		fmt.Printf("   ✅ Statut: SUCCÈS\n")
	}
}

func printExecutionFooter() {
	fmt.Printf("\n╔══════════════════════════════════════════════════════════════╗\n")
	fmt.Printf("║                    🎉 EXÉCUTION TERMINÉE                     ║\n")
	fmt.Printf("╚══════════════════════════════════════════════════════════════╝\n")
}

func printError(message string) {
	fmt.Printf("\n❌ ERREUR: %s\n\n", message)
}

func getTypeName(objType evaluator.ObjectType) string {
	switch objType {
	case evaluator.INTEGER_OBJ:
		return "Entier"
	case evaluator.BOOLEAN_OBJ:
		return "Booléen"
	case evaluator.NULL_OBJ:
		return "Null"
	case evaluator.ERROR_OBJ:
		return "Erreur"
	default:
		return string(objType)
	}
}

func truncateString(s string, maxLen int) string {
	if len(s) <= maxLen {
		return s
	}
	return s[:maxLen-3] + "..."
}
