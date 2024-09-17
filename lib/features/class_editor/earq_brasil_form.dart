import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../localization.dart';
import '../settings/settings_controller.dart';
import 'class_editor.dart';
import 'earq_brasil_metadata.dart';

/// Remove once the new `Flex.spacing` reaches stable.
const _formFieldsGap = SizedBox.square(dimension: 16);

class EarqBrasilForm extends StatelessWidget {
  const EarqBrasilForm({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        if (constraints.maxWidth >= 700) {
          return const Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(child: DescriptionSection()),
              _formFieldsGap,
              Expanded(child: TemporalitySection()),
            ],
          );
        }
        return const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            DescriptionSection(),
            _formFieldsGap,
            TemporalitySection(),
          ],
        );
      },
    );
  }
}

class DescriptionSection extends StatelessWidget {
  const DescriptionSection({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final editor = context.read<ClassEditor>();

    return FocusTraversalGroup(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            l10n.earqBrasilFormDescricaoSectionHeader,
            style: Theme.of(context).textTheme.titleLarge,
          ),
          _formFieldsGap,
          EarqBrasilFormField(
            label: l10n.earqBrasilNomeLabel,
            helperText: l10n.earqBrasilNomeDefinition,
            initialValue: editor.valueOf(EarqBrasilMetadata.nome),
            onChanged: (value) =>
                editor.updateValueOf(EarqBrasilMetadata.nome, value),
          ),
          _formFieldsGap,
          const HierarchySection(),
          _formFieldsGap,
          EarqBrasilFormField(
            label: l10n.earqBrasilAberturaLabel,
            helperText: l10n.earqBrasilAberturaDefinition,
            initialValue: editor.valueOf(EarqBrasilMetadata.abertura),
            onChanged: (value) =>
                editor.updateValueOf(EarqBrasilMetadata.abertura, value),
          ),
          _formFieldsGap,
          EarqBrasilFormField(
            label: l10n.earqBrasilDesativacaoLabel,
            helperText: l10n.earqBrasilDesativacaoDefinition,
            initialValue: editor.valueOf(EarqBrasilMetadata.desativacao),
            onChanged: (value) =>
                editor.updateValueOf(EarqBrasilMetadata.desativacao, value),
          ),
          _formFieldsGap,
          EarqBrasilFormField(
            label: l10n.earqBrasilReativacaoLabel,
            helperText: l10n.earqBrasilReativacaoDefinition,
            initialValue: editor.valueOf(EarqBrasilMetadata.reativacao),
            onChanged: (value) =>
                editor.updateValueOf(EarqBrasilMetadata.reativacao, value),
          ),
          _formFieldsGap,
          EarqBrasilFormField(
            label: l10n.earqBrasilMudancaNomeLabel,
            helperText: l10n.earqBrasilMudancaNomeDefinition,
            initialValue: editor.valueOf(EarqBrasilMetadata.mudancaNome),
            onChanged: (value) =>
                editor.updateValueOf(EarqBrasilMetadata.mudancaNome, value),
          ),
          _formFieldsGap,
          EarqBrasilFormField(
            label: l10n.earqBrasilDeslocamentoLabel,
            helperText: l10n.earqBrasilDeslocamentoDefinition,
            initialValue: editor.valueOf(EarqBrasilMetadata.deslocamento),
            onChanged: (value) =>
                editor.updateValueOf(EarqBrasilMetadata.deslocamento, value),
          ),
          _formFieldsGap,
          EarqBrasilFormField(
            label: l10n.earqBrasilExtincaoLabel,
            helperText: l10n.earqBrasilExtincaoDefinition,
            initialValue: editor.valueOf(EarqBrasilMetadata.extincao),
            onChanged: (value) =>
                editor.updateValueOf(EarqBrasilMetadata.extincao, value),
          ),
          _formFieldsGap,
          EarqBrasilFormField(
            label: l10n.earqBrasilIndicadorAtivaLabel,
            helperText: l10n.earqBrasilIndicadorAtivaDefinition,
            initialValue: editor.valueOf(EarqBrasilMetadata.indicadorAtiva),
            onChanged: (value) =>
                editor.updateValueOf(EarqBrasilMetadata.indicadorAtiva, value),
          ),
        ],
      ),
    );
  }
}

class HierarchySection extends StatelessWidget {
  const HierarchySection({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final editor = context.read<ClassEditor>();

    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        return Flex(
          direction:
              constraints.maxWidth >= 600 ? Axis.horizontal : Axis.vertical,
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Flexible(
              child: EarqBrasilFormField(
                label: l10n.earqBrasilCodigoLabel,
                helperText: l10n.earqBrasilCodigoDefinition,
                initialValue: editor.valueOf(EarqBrasilMetadata.codigo),
                onChanged: (value) =>
                    editor.updateValueOf(EarqBrasilMetadata.codigo, value),
              ),
            ),
            _formFieldsGap,
            Flexible(
              child: Builder(
                builder: (BuildContext context) {
                  final code = context.select<SettingsController, String>(
                    (controller) => controller.institutionCode,
                  );
                  var value = editor.valueOf(EarqBrasilMetadata.subordinacao);
                  value = value?.isEmpty ?? true ? code : '$code-$value';

                  // TODO: add parent selector dialog

                  return EarqBrasilFormField(
                    label: l10n.earqBrasilSubordinacaoLabel,
                    helperText: l10n.earqBrasilSubordinacaoDefinition,
                    initialValue: value,
                    readOnly: true,
                  );
                },
              ),
            ),
          ],
        );
      },
    );
  }
}

class TemporalitySection extends StatelessWidget {
  const TemporalitySection({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final editor = context.read<ClassEditor>();

    return FocusTraversalGroup(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            l10n.earqBrasilFormTemporalidadeSectionHeader,
            style: Theme.of(context).textTheme.titleLarge,
          ),
          _formFieldsGap,
          EarqBrasilFormField(
            label: l10n.earqBrasilPrazoCorrenteLabel,
            helperText: l10n.earqBrasilPrazoCorrenteDefinition,
            initialValue: editor.valueOf(EarqBrasilMetadata.prazoCorrente),
            onChanged: (value) =>
                editor.updateValueOf(EarqBrasilMetadata.prazoCorrente, value),
          ),
          _formFieldsGap,
          EarqBrasilFormField(
            label: l10n.earqBrasilEventoCorrenteLabel,
            helperText: l10n.earqBrasilEventoCorrenteDefinition,
            initialValue: editor.valueOf(EarqBrasilMetadata.eventoCorrente),
            onChanged: (value) =>
                editor.updateValueOf(EarqBrasilMetadata.eventoCorrente, value),
          ),
          _formFieldsGap,
          EarqBrasilFormField(
            label: l10n.earqBrasilPrazoIntermediariaLabel,
            helperText: l10n.earqBrasilPrazoIntermediariaDefinition,
            initialValue: editor.valueOf(EarqBrasilMetadata.prazoIntermediaria),
            onChanged: (value) => editor.updateValueOf(
                EarqBrasilMetadata.prazoIntermediaria, value),
          ),
          _formFieldsGap,
          EarqBrasilFormField(
            label: l10n.earqBrasilEventoIntermediariaLabel,
            helperText: l10n.earqBrasilEventoIntermediariaDefinition,
            initialValue:
                editor.valueOf(EarqBrasilMetadata.eventoIntermediaria),
            onChanged: (value) => editor.updateValueOf(
                EarqBrasilMetadata.eventoIntermediaria, value),
          ),
          _formFieldsGap,
          EarqBrasilFormField(
            label: l10n.earqBrasilDestinacaoLabel,
            helperText: l10n.earqBrasilDestinacaoDefinition,
            initialValue: editor.valueOf(EarqBrasilMetadata.destinacao),
            onChanged: (value) =>
                editor.updateValueOf(EarqBrasilMetadata.destinacao, value),
          ),
          _formFieldsGap,
          EarqBrasilFormField(
            label: l10n.earqBrasilAlteracaoLabel,
            helperText: l10n.earqBrasilAlteracaoDefinition,
            initialValue: editor.valueOf(EarqBrasilMetadata.alteracao),
            onChanged: (value) =>
                editor.updateValueOf(EarqBrasilMetadata.alteracao, value),
          ),
          _formFieldsGap,
          EarqBrasilFormField(
            label: l10n.earqBrasilObservacoesLabel,
            helperText: l10n.earqBrasilObservacoesDefinition,
            initialValue: editor.valueOf(EarqBrasilMetadata.observacoes),
            maxLines: null,
            onChanged: (value) =>
                editor.updateValueOf(EarqBrasilMetadata.observacoes, value),
          ),
        ],
      ),
    );
  }
}

class EarqBrasilFormField extends StatefulWidget {
  const EarqBrasilFormField({
    super.key,
    required this.label,
    this.helperText = '',
    this.readOnly = false,
    this.maxLines = 1,
    this.initialValue,
    this.onChanged,
  });

  final String label;
  final String helperText;
  final bool readOnly;
  final int? maxLines;
  final String? initialValue;
  final ValueChanged<String>? onChanged;

  @override
  State<EarqBrasilFormField> createState() => _EarqBrasilFormFieldState();
}

class _EarqBrasilFormFieldState extends State<EarqBrasilFormField> {
  late final focusNode = FocusNode()..addListener(() => setState(() {}));

  @override
  void dispose() {
    focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Focus(
      focusNode: focusNode,
      canRequestFocus: false,
      child: TextFormField(
        initialValue: widget.initialValue,
        onChanged: widget.onChanged,
        readOnly: widget.readOnly,
        maxLines: widget.maxLines,
        decoration: InputDecoration(
          labelText: widget.label,
          helper: showHelperText ? Text(widget.helperText) : null,
          filled: true,
          border: const UnderlineInputBorder(),
          enabledBorder: const UnderlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(4)),
            borderSide: BorderSide.none,
          ),
        ),
      ),
    );
  }

  bool get showHelperText => focusNode.hasFocus && widget.helperText.isNotEmpty;
}
