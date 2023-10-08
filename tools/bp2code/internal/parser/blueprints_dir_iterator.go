package parser

import (
	"fmt"
	"io/fs"
	"log"
	"os"
	"path/filepath"
)

type BlueprintsDirectoryIterator struct {
	files    []string
	currFile string

	current []byte
}

func NewDirectoryIterator(dir string) (RawBlueprintsIterator, error) {
	files, err := findBlueprints(dir)
	if err != nil {
		return nil, fmt.Errorf("Failed to parse blueprints directory. %v", err)
	}
	return &BlueprintsDirectoryIterator{files: files}, nil
}

func (it *BlueprintsDirectoryIterator) DescribeCurrent() string {
	if it.currFile == "" {
		return "?"
	}
	return filepath.Base(it.currFile)
}

func (it *BlueprintsDirectoryIterator) Current() []byte {
	return it.current
}

func (it *BlueprintsDirectoryIterator) MoveNext() bool {
	it.current = nil
	it.currFile = ""

	if len(it.files) > 0 {
		it.currFile = it.files[0]
		it.files = it.files[1:]

		bytes, err := os.ReadFile(it.currFile)
		if len(bytes) == 0 {
			log.Printf("Failed to read %v. File is empty. Skipping...\n", it.currFile)
			return it.MoveNext()
		}
		if err != nil {
			log.Printf("Failed to read %v. Skipping...\n", it.currFile)
			return it.MoveNext()
		}

		it.current = bytes
	}
	return it.current != nil
}

func findBlueprints(path string) ([]string, error) {
	bp := []string{}

	err := filepath.WalkDir(path, func(path string, item fs.DirEntry, err error) error {
		if err != nil {
			log.Fatalf("Unable to reach %v. Failure: %v\n", path, err)
		}

		ext := filepath.Ext(path)

		if ext == ".yml" || ext == ".yaml" {
			bp = append(bp, path)
		}

		return nil
	})

	if err != nil {
		return nil, err
	}

	return bp, nil
}
