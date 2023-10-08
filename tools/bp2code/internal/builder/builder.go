package builder

import (
	"bytes"
	"strings"
	"text/template"

	"bp2code/internal/core"
)

type templateData struct {
	Bp    *core.Blueprint
	Class string
}

const modelTemplate = `// GENERATED FILE - DO NOT MODIFY
// Blueprint: {{.Bp.Description}}

final class {{.Class}} {
  static const String namespace = '{{.Bp.Namespace}}';
{{- if .Bp.Version}}
  static const String version = '{{.Bp.Version}}';
{{- end}}
  static const String title = '{{- if .Bp.Title}}{{.Bp.Title}}{{else}}{{.Bp.Namespace}}{{- end}}';

  const {{.Class}}._(this.tag, this.label);

  final String tag;
  final String label;

  String get uid => '$namespace:$tag';

  static const List<{{.Class}}> values = <{{.Class}}>[
{{- range .Bp.Metadata}}
    {{$.Class}}._('{{.Tag}}', '{{.Label}}'),
{{- end}}
  ];
{{range $index, $_ := .Bp.Metadata}}
  static {{$.Class}} get {{.Tag}} => values[{{$index}}];
{{- end}}
}
`

type BlueprintOutput struct {
	SuggestedFileName string
	Models            *bytes.Buffer
}

func Build(blueprints []*core.Blueprint) []*BlueprintOutput {
	var outputs []*BlueprintOutput

	for _, bp := range blueprints {
		// DEBUG
		if strings.ToLower(bp.Namespace) != "test" {
			continue
		}
		o := &BlueprintOutput{
			SuggestedFileName: bp.Namespace + ".dart",
		}
		o.Models = buildModel(bp)
		outputs = append(outputs, o)
	}

	return outputs
}

func buildModel(bp *core.Blueprint) *bytes.Buffer {
	var b bytes.Buffer

	data := &templateData{
		Bp:    bp,
		Class: core.Capitalize(bp.Namespace) + "Metadata",
	}

	template.Must(template.New("").Parse(modelTemplate)).Execute(&b, data)
	return &b
}

func buildController(bp *core.Blueprint) {}

func buildView(bp *core.Blueprint) {}
