import * as vscode from 'vscode';

export function activate(context: vscode.ExtensionContext) {
    console.log('Hamroun Language Support is now active!');

    // Register a command to show welcome message
    let disposable = vscode.commands.registerCommand('hamroun.showWelcome', () => {
        vscode.window.showInformationMessage('Bienvenue dans Hamroun! 🇫🇷');
    });

    context.subscriptions.push(disposable);

    // Register hover provider for keywords
    const hoverProvider = vscode.languages.registerHoverProvider('hamroun', {
        provideHover(document, position, token) {
            const range = document.getWordRangeAtPosition(position);
            const word = document.getText(range);

            const keywords: { [key: string]: string } = {
                'SI': 'Condition: SI <condition> ALORS ... SINON ... FIN',
                'ALORS': 'Début du bloc SI',
                'SINON': 'Bloc alternatif de la condition',
                'FIN': 'Fin de bloc (condition, boucle, fonction)',
                'BOUCLE': 'Boucle: BOUCLE <variable> DE <début> A <fin>',
                'DE': 'Valeur de départ de la boucle',
                'A': 'Valeur de fin de la boucle',
                'TANT_QUE': 'Boucle conditionnelle: TANT_QUE <condition> FAIRE',
                'FAIRE': 'Début du bloc TANT_QUE',
                'FONCTION': 'Déclaration de fonction avec retour',
                'PROCEDURE': 'Déclaration de procédure sans retour',
                'RETOURNER': 'Retourner une valeur depuis une fonction',
                'AFFICHER': 'Afficher une valeur à l\'écran',
                'LIRE': 'Lire une entrée utilisateur',
                'EGAL': 'Opérateur de comparaison: égal à',
                'DIFFERENT': 'Opérateur de comparaison: différent de',
                'PLUS_GRAND': 'Opérateur de comparaison: plus grand que',
                'PLUS_PETIT': 'Opérateur de comparaison: plus petit que',
                'ET': 'Opérateur logique: ET',
                'OU': 'Opérateur logique: OU',
                'NON': 'Opérateur logique: NON',
                'VRAI': 'Valeur booléenne: vrai',
                'FAUX': 'Valeur booléenne: faux',
                'ENTIER': 'Type de données: nombre entier',
                'REEL': 'Type de données: nombre réel',
                'TEXTE': 'Type de données: chaîne de caractères',
                'BOOLEEN': 'Type de données: vrai ou faux',
                'TABLEAU': 'Structure de données: tableau',
                'LISTE': 'Structure de données: liste'
            };

            if (word && keywords[word]) {
                return new vscode.Hover(keywords[word]);
            }
        }
    });

    context.subscriptions.push(hoverProvider);

    // Status bar item
    const statusBarItem = vscode.window.createStatusBarItem(vscode.StatusBarAlignment.Right, 100);
    statusBarItem.text = "$(file-code) Hamroun";
    statusBarItem.tooltip = "Langage de Programmation Français";
    
    // Show status bar when a .hamroun file is open
    context.subscriptions.push(vscode.window.onDidChangeActiveTextEditor(editor => {
        if (editor && editor.document.languageId === 'hamroun') {
            statusBarItem.show();
        } else {
            statusBarItem.hide();
        }
    }));

    // Show immediately if a .hamroun file is already open
    if (vscode.window.activeTextEditor?.document.languageId === 'hamroun') {
        statusBarItem.show();
    }

    context.subscriptions.push(statusBarItem);
}

export function deactivate() {}
