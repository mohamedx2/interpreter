//go:build windows

package main

import (
	_ "embed"
)

//go:embed hamroun.ico
var iconData []byte

// This embeds the icon data into the binary
