package main

import (
	"os"
	"os/user"
	"path/filepath"
	"strings"
)

func main() {
	var err error
	cwd, err := os.Getwd()
	if err != nil {
		panic(err)
	}
	currentUser, err := user.Current()
	if err != nil {
		panic(err)
	}
	homeDir := currentUser.HomeDir
	cwdWithTilde := strings.Replace(cwd, homeDir, "~/", 1)
	hiers := strings.Split(cwdWithTilde, "/")
	hiersLen := len(hiers)
	var abbreved []string
	for idx, h := range hiers {
		var formatted string
		if (idx == hiersLen-1) || h == "" {
			formatted = h
		} else {
			formatted = string(h[0])
		}
		abbreved = append(abbreved, formatted)
	}
	println(filepath.Join(abbreved...))
}
