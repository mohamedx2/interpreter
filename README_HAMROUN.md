# Langage de Programmation Français - Extension .hamroun

## Installation et Utilisation

### Exécuter des fichiers .hamroun
```bash
hamroun.exe fichier.hamroun
```

### Mode interactif (REPL)
```bash
hamroun.exe
```

## Syntaxe du Langage

### Variables et Arithmétique
```hamroun
# Déclaration de variables
x = 10
y = 5

# Opérations arithmétiques
somme = x + y          # Addition
difference = x - y     # Soustraction
produit = x * y        # Multiplication
quotient = x / y       # Division
```

### Conditions
```hamroun
age = 18

# Structure conditionnelle
SI age PLUS_GRAND 17 ALORS resultat = 1 SINON resultat = 0 FIN

# Opérateurs de comparaison
# EGAL         - égalité
# DIFFERENT    - différence
# PLUS_GRAND   - plus grand que
# PLUS_PETIT   - plus petit que
```

### Boucles
```hamroun
# Boucle simple
total = 0
BOUCLE i DE 1 A 10
  total = total + i
FIN

# Calcul de factorielle
factorielle = 1
BOUCLE j DE 1 A 5
  factorielle = factorielle * j
FIN
```

### Commentaires
```hamroun
# Ceci est un commentaire
x = 5  # Commentaire en fin de ligne
```

## Exemples de Fichiers

### arithmetique.hamroun
Calculs de base avec variables

### boucles.hamroun
Démonstration des boucles (factorielle et somme)

### conditions.hamroun
Structures conditionnelles

### premier.hamroun
Programme complet pour tester les nombres premiers

## Mots-clés du Langage

| Français | Description |
|----------|-------------|
| `SI` | If (condition) |
| `ALORS` | Then |
| `SINON` | Else |
| `FIN` | End |
| `BOUCLE` | Loop |
| `DE` | From |
| `A` | To |
| `EGAL` | Equal (==) |
| `DIFFERENT` | Not equal (!=) |
| `PLUS_GRAND` | Greater than (>) |
| `PLUS_PETIT` | Less than (<) |

## Types de Données

- **Entiers** : `1`, `42`, `-5`
- **Booléens** : `vrai` (true), `faux` (false)
- **Null** : `null`

## Erreurs Communes

1. **Extension incorrecte** : Les fichiers doivent avoir l'extension `.hamroun`
2. **Indentation** : Utilisez des lignes simples, l'indentation n'est pas supportée dans les blocs
3. **Chaînes de caractères** : Pas encore supportées, utilisez des nombres

## Construction

Pour construire l'exécutable :
```bash
go build -o hamroun.exe hamroun.go
```
