package core

import (
	"fmt"
	"unicode"
)

type Blueprint struct {
	Version   string     `yaml:"version"`
	Namespace string     `yaml:"namespace"`
	Title     string     `yaml:"title,omitempty"`
	Url       string     `yaml:"url,omitempty"`
	Metadata  []Metadata `yaml:"metadata,omitempty"`
}

func (b *Blueprint) Validate() error {
	if b.Version == "" {
		return fmt.Errorf("A template must have a \"version\" field.")
	}
	if err := b.validateNamespace(); err != nil {
		return err
	}
	return nil

}

func (b *Blueprint) validateNamespace() error {
	if b.Namespace == "" {
		return fmt.Errorf("A blueprint must have a \"namespace\" field.")
	}

	for _, r := range b.Namespace {
		if !unicode.IsLetter(r) || unicode.IsUpper(r) {
			return fmt.Errorf(
				"Invalid namespace \"%v\". Namespaces must contain lowercase letters only.",
				b.Namespace,
			)
		}
	}

	return nil
}

func (b *Blueprint) Description() string {
	return fmt.Sprintf("(%v v%v) %v", b.Namespace, b.Version, b.Title)
}
