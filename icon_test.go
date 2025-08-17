package main

import (
	"fmt"
	"os"
	"syscall"
	"unsafe"
)

var (
	shell32           = syscall.NewLazyDLL("shell32.dll")
	procExtractIconEx = shell32.NewProc("ExtractIconExW")
)

func checkIcon(filename string) {
	fmt.Printf("🔍 Vérification de l'icône pour: %s\n", filename)

	// Convert filename to UTF-16
	filenamePtr, _ := syscall.UTF16PtrFromString(filename)

	var largeIcon, smallIcon uintptr

	// Try to extract icon
	ret, _, _ := procExtractIconEx.Call(
		uintptr(unsafe.Pointer(filenamePtr)),
		0, // icon index
		uintptr(unsafe.Pointer(&largeIcon)),
		uintptr(unsafe.Pointer(&smallIcon)),
		1, // number of icons
	)

	if ret > 0 {
		fmt.Printf("✅ Icône détectée! Large: %v, Small: %v\n", largeIcon, smallIcon)
	} else {
		fmt.Printf("❌ Aucune icône détectée (ret: %v)\n", ret)
	}
}

func main() {
	if len(os.Args) < 2 {
		fmt.Println("Usage: icon_test.exe fichier.exe")
		return
	}

	checkIcon(os.Args[1])
}
