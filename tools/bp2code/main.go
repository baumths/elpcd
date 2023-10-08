package main

import (
	"fmt"
	"log"
	"os"
	"path"

	"bp2code/internal/builder"
	"bp2code/internal/parser"
)

func main() {
	cwd, err := os.Getwd()
	if err != nil {
		log.Fatalf("Could not find CWD: %v", err)
	}

	it, err := parser.NewDirectoryIterator(path.Join(cwd, "blueprints"))
	if err != nil {
		log.Fatalln(err)
	}

	parser := parser.New(it)
	parser.Parse()

	for _, bo := range builder.Build(parser.Blueprints) {
		log.Printf("Successfuly generated %v:\n", bo.SuggestedFileName)
		fmt.Printf(bo.Models.String())
	}
}
