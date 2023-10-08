package parser

import (
	"fmt"
	"log"
	"strings"

	"gopkg.in/yaml.v3"

	"bp2code/internal/core"
)

type BlueprintsParser struct {
	Blueprints []*core.Blueprint

	iterator RawBlueprintsIterator
}

type RawBlueprintsIterator interface {
	Current() []byte
	MoveNext() bool
	DescribeCurrent() string
}

func New(it RawBlueprintsIterator) *BlueprintsParser {
	return &BlueprintsParser{
		Blueprints: []*core.Blueprint{},
		iterator:   it,
	}
}

func (p *BlueprintsParser) Parse() {
	it := p.iterator
	namespaces := map[string]string{}

	for it.MoveNext() {
		bytes := it.Current()
		bp, err := parseBlueprint(bytes)

		if err != nil {
			fmt.Printf("Parsing failure: %v. Skipping...\n", err)
			continue
		}
		if err = bp.Validate(); err != nil {
			fmt.Printf("Invalid blueprint: %q.\n  %v\n  Skipping...\n", it.DescribeCurrent(), err)
			continue
		}
		if namespaces[bp.Namespace] != "" {
			log.Fatalf("Failure: duplicated namespace %q in %q and %q.\n", bp.Namespace, namespaces[bp.Namespace], it.DescribeCurrent())
			continue
		}
		if strings.TrimSpace(bp.Title) == "" {
			bp.Title = core.Capitalize(bp.Namespace)
		}

		p.Blueprints = append(p.Blueprints, bp)
		namespaces[bp.Namespace] = it.DescribeCurrent()
	}
}

func parseBlueprint(bytes []byte) (bp *core.Blueprint, err error) {
	if err = yaml.Unmarshal(bytes, &bp); err != nil {
		return nil, err
	}
	return bp, nil
}
