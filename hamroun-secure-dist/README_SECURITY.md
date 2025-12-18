#  HAMROUN - SÉCURITÉ ET ANTIVIRUS

##  POURQUOI VOTRE ANTIVIRUS PEUT DÉTECTER UN VIRUS

### C'est un **FAUX POSITIF** très courant avec les nouveaux logiciels

**Raisons techniques :**
1. **Exécutable non signé** - Pas de certificat numérique coûteux
2. **Nouveau binaire** - Antivirus ne reconnaît pas encore la signature
3. **Langage Go** - Les binaires Go sont parfois flagués
4. **Heuristiques agressives** - Détection basée sur le comportement

##  COMMENT VÉRIFIER QUE C'EST SÉCURISÉ

### 1. Vérification du hash SHA256
- Ouvrez PowerShell
- Tapez : \Get-FileHash hamroun.exe -Algorithm SHA256\
- Comparez avec \SECURITY_VERIFICATION.txt\

### 2. Sources vérifiables
- **Code source :** https://github.com/mohamedx2
- **Développeur :** Mohamed Ali Hamroun
- **Site web :** https://mohamedalihamroun.me

##  SOLUTIONS IMMÉDIATES

### Option 1 - Ajouter une exception
1. Ouvrez Windows Defender
2. Virus & threat protection
3. Manage settings (sous Virus & threat protection settings)
4. Add or remove exclusions
5. Ajoutez le dossier hamroun

### Option 2 - Débloquer le fichier
1. Clic droit sur \hamroun.exe\
2. Propriétés
3. Cochez "Débloquer" (si présent)
4. OK

### Option 3 - Utiliser la version 32-bit
\hamroun-32bit.exe\ peut être moins flaggé

##  TEST RAPIDE

\\\cmd
# Test que ça fonctionne
hamroun.exe simple.hamroun

# Ou version 32-bit
hamroun-32bit.exe simple.hamroun
\\\

##  SUPPORT

Si vous avez des doutes :
- GitHub Issues : https://github.com/mohamedx2
- Email via site web : mohamedalihamroun.me

---
**Ce logiciel est 100% sûr** - Le code source est ouvert et vérifiable !
