part of '../settings.dart';

class CodearqSection extends StatelessWidget {
  const CodearqSection({
    Key key = const Key('CodearqSection'),
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final settings = Settings.of(context);
    final controller = settings.codearqController;

    return Column(
      children: [
        const Padding(
          padding: EdgeInsets.fromLTRB(
            AppInsets.medium,
            AppInsets.small,
            AppInsets.medium,
            AppInsets.xSmall,
          ),
          child: _HelperText(),
        ),
        SizedBox(
          height: 64,
          child: AnimatedBuilder(
            animation: controller,
            builder: (_, __) {
              late final Widget child;

              if (controller.isEditing) {
                controller.text = settings.codearq;

                child = const Align(
                  alignment: Alignment.center,
                  child: _EditTile(),
                );
              } else {
                child = const Align(
                  alignment: Alignment.bottomCenter,
                  child: _DisplayTile(),
                );
              }

              return AnimatedSwitcher(
                duration: kAnimationDuration,
                reverseDuration: Duration.zero,
                switchInCurve: Curves.easeIn,
                switchOutCurve: Curves.easeOut,
                child: KeyedSubtree(
                  key: Key('${controller.isEditing}'),
                  child: child,
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}

class _HelperText extends StatelessWidget {
  const _HelperText({Key? key}) : super(key: key);

  static const String conarqUrl = 'https://www.gov.br/conarq/pt-br/servicos-1/'
      'consulta-as-entidades-custodiadoras-de-acervos-arquivisticos-cadastradas';

  static const String helperText =
      'Este é o nome da instituição arquivística que será '
      'criada no AtoM quando você importar o arquivo CSV do seu PCD.\n\n'
      'Para mais informações sobre o '
      'Cadastro nacional de entidades custodiadoras de acervos arquivísticos '
      'acesse o ';

  static const String hyperLinkText = 'site do Conarq';

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final ColorScheme colorScheme = theme.colorScheme;

    final TextStyle? textStyle = theme.textTheme.caption?.copyWith(
      fontSize: 14,
      fontWeight: FontWeight.w500,
    );

    final TextStyle? hyperLinkTextStyle = textStyle?.copyWith(
      color: colorScheme.primary,
      fontWeight: FontWeight.w700,
      // Height needed to align vertically with parent span.
      // Without this, the parent span would be a little higher.
      height: 1.2,
    );

    final TextStyle? tooltipTextStyle = theme.tooltipTheme.textStyle?.copyWith(
      fontSize: 10,
    );

    return RichText(
      text: TextSpan(
        text: helperText,
        style: textStyle,
        children: [
          WidgetSpan(
            child: Tooltip(
              message: conarqUrl,
              textStyle: tooltipTextStyle,
              verticalOffset: 10,
              child: MouseRegion(
                cursor: SystemMouseCursors.click,
                child: GestureDetector(
                  onTap: () {
                    // TODO: Launch [conarqUrl]
                  },
                  child: Text(
                    hyperLinkText,
                    style: hyperLinkTextStyle,
                  ),
                ),
              ),
            ),
          ),
          const TextSpan(text: '.'),
        ],
      ),
    );
  }
}

class _DisplayTile extends StatelessWidget {
  const _DisplayTile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final settings = Settings.of(context);

    final ThemeData theme = Theme.of(context);
    final ColorScheme colorScheme = theme.colorScheme;

    return ListTile(
      onTap: settings.codearqController.enableEditing,
      shape: const RoundedRectangleBorder(
        borderRadius: AppBorderRadius.bottom,
      ),
      contentPadding: const EdgeInsets.symmetric(
        horizontal: AppInsets.medium,
      ),
      subtitle: const Text(
        'Toque para editar',
        style: TextStyle(
          fontWeight: FontWeight.w700,
        ),
      ),
      title: Text(
        settings.codearq,
        style: const TextStyle(
          fontWeight: FontWeight.bold,
        ),
      ),
      trailing: Icon(
        Icons.edit_rounded,
        color: colorScheme.primary,
      ),
    );
  }
}

class _EditTile extends StatelessWidget {
  const _EditTile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Settings.of(context).codearqController;

    // TODO: Debounce field's onChanged to save after delay

    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: AppInsets.medium,
      ),
      child: TextField(
        autofocus: true,
        focusNode: controller.focusNode,
        controller: controller.textEditingController,
        decoration: const InputDecoration(
          filled: true,
          isDense: true,
          hintText: 'ElPCD',
          border: InputBorder.none,
          focusedBorder: OutlineInputBorder(
            borderRadius: AppBorderRadius.all,
            borderSide: BorderSide(width: 2),
          ),
        ),
      ),
    );
  }
}
