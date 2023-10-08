package core

import (
	"fmt"
	"strings"
)

type Metadata struct {
	Tag   string `yaml:"tag"`
	Label string `yaml:"label"`

	Type     string `yaml:"type,omitempty"`
	Required bool   `yaml:"required,omitempty"`

	Default string   `yaml:"default,omitempty"`
	Values  []string `yaml:"values,omitempty"`
}

func (m *Metadata) Validate() error {
	if strings.TrimSpace(m.Tag) == "" {
		return fmt.Errorf("Metadata must have a \"tag\" field.")
	}
	if strings.TrimSpace(m.Label) == "" {
		return fmt.Errorf("Metadata must have a \"label\" field.")
	}
	return nil
}
