@echo off
echo ===========================================
echo 🔍 VÉRIFICATION DE L'ICÔNE HAMROUN.EXE
echo ===========================================
echo.
echo 📁 Répertoire actuel:
cd
echo.
echo 📊 Taille du fichier hamroun.exe:
dir hamroun.exe | find ".exe"
echo.
echo 🔧 Fichiers de ressources (.syso):
dir *.syso
echo.
echo 📋 Test d'exécution:
echo .\hamroun.exe --version
.\hamroun.exe --help
echo.
echo ✅ Vérification terminée!
echo 👀 Regardez dans l'Explorateur Windows pour voir l'icône
pause
