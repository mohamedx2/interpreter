#!/bin/bash

# Build the interpreter
echo "Building the interpreter..."
go build -o interpreter

# Run the examples
echo -e "\nRunning examples:"

echo -e "\nExample 1: Simple arithmetic"
echo "5 + 10" | ./interpreter

echo -e "\nExample 2: Variable assignment"
echo "x = 5" | ./interpreter

echo -e "\nExample 3: Conditional"
echo "SI 5 ALORS 10 SINON 0 FIN" | ./interpreter

echo -e "\nExample 4: Complex"
echo "SI x ALORS y + 5 SINON z - 3 FIN" | ./interpreter

echo -e "\nTesting complete!"
