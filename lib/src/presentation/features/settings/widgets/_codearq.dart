part of '../settings.dart';

class CodearqSection extends StatefulWidget {
  const CodearqSection({
    Key key = const Key('CodearqSection'),
  }) : super(key: key);

  final String codearq = 'ElPCD'; // TODO: get from user preferences

  @override
  State<CodearqSection> createState() => _CodearqSectionState();
}

class _CodearqSectionState extends State<CodearqSection> {
  late final FocusNode _focusNode;
  late final TextEditingController _textEditingController;

  String get text => _textEditingController.text;

  bool _isEditing = false;
  bool get isEditing => _isEditing;
  set isEditing(bool value) {
    if (isEditing == value) return;

    setState(() {
      _isEditing = value;
    });
  }

  @override
  void initState() {
    super.initState();
    _textEditingController = TextEditingController(text: widget.codearq);
    _focusNode = FocusNode(onKeyEvent: _onKeyEvent)
      ..addListener(_onFocusChange);
  }

  @override
  void dispose() {
    _textEditingController.dispose();
    _focusNode
      ..removeListener(_onFocusChange)
      ..dispose();
    super.dispose();
  }

  void _onSaved() {
    if (text == widget.codearq) return;
    // TODO: Save new CODEARQ
    print('Saving CODEARQ ==> ${_textEditingController.text}');
  }

  void _onFocusChange() {
    if (_focusNode.hasFocus) return;

    // Save when unfocused
    _onSaved();
    isEditing = false;
  }

  KeyEventResult _onKeyEvent(FocusNode focusNode, KeyEvent event) {
    final PhysicalKeyboardKey keyPressed = event.physicalKey;

    final bool fieldSubmitted = keyPressed == PhysicalKeyboardKey.enter ||
        keyPressed == PhysicalKeyboardKey.numpadEnter ||
        keyPressed == PhysicalKeyboardKey.tab;

    if (fieldSubmitted) {
      focusNode.unfocus();
      return KeyEventResult.handled;
    }
    return KeyEventResult.ignored;
  }

  @override
  Widget build(BuildContext context) {
    // TODO: Perhaps debounce field's onChanged and save after some delay?

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.symmetric(
            vertical: AppEdgeInsets.small,
            horizontal: AppEdgeInsets.medium,
          ),
          child: CodearqHelperText(),
        ),
        SizedBox(
          height: 64,
          child: AnimatedSwitcher(
            duration: kAnimationDuration,
            reverseDuration: Duration.zero,
            switchInCurve: Curves.easeIn,
            switchOutCurve: Curves.easeOut,
            child: isEditing
                ? _CodearqEditTile(
                    focusNode: _focusNode,
                    controller: _textEditingController,
                  )
                : _CodearqDisplayTile(
                    codearq: widget.codearq,
                    onTap: () => isEditing = true,
                  ),
          ),
        ),
      ],
    );
  }
}

class CodearqHelperText extends StatelessWidget {
  const CodearqHelperText({Key? key}) : super(key: key);

  static const String conarqUrl = 'https://www.gov.br/conarq/pt-br/servicos-1/'
      'consulta-as-entidades-custodiadoras-de-acervos-arquivisticos-cadastradas';

  static const String helperText =
      'Este é o nome da instituição arquivística que será '
      'criada no AtoM quando você importar o arquivo CSV do seu PCD.\n\n'
      'Para mais informações sobre o '
      'Cadastro nacional de entidades custodiadoras de acervos arquivísticos '
      'acesse o ';

  static const String hyperLinkText = 'site do Conarq';

  void onTap() {
    // TODO: LAUNCH ➜ [conarqUrl]
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final ColorScheme colorScheme = theme.colorScheme;

    final TextStyle? textStyle = theme.textTheme.caption?.copyWith(
      fontSize: 14,
      fontWeight: FontWeight.w500,
    );

    return RichText(
      text: TextSpan(
        text: helperText,
        style: textStyle,
        children: [
          WidgetSpan(
            child: Tooltip(
              message: conarqUrl,
              textStyle: theme.tooltipTheme.textStyle?.copyWith(fontSize: 10),
              verticalOffset: 10,
              child: MouseRegion(
                cursor: SystemMouseCursors.click,
                child: GestureDetector(
                  onTap: onTap,
                  child: Text(
                    hyperLinkText,
                    style: textStyle?.copyWith(
                      color: colorScheme.primary,
                      fontWeight: FontWeight.w700,
                      // Height needed to align vertically with parent span.
                      // Without this, the parent span would be a little higher.
                      height: 1.2,
                    ),
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

class _CodearqDisplayTile extends StatelessWidget {
  const _CodearqDisplayTile({
    Key? key,
    required this.codearq,
    this.onTap,
  }) : super(key: key);

  final String codearq;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final ColorScheme colorScheme = theme.colorScheme;

    final TextStyle? textStyle = theme.textTheme.subtitle1?.copyWith(
      fontWeight: FontWeight.w600,
    );

    return Material(
      color: Colors.transparent,
      clipBehavior: Clip.hardEdge,
      borderRadius: AppBorderRadius.all,
      child: ListTile(
        onTap: onTap,
        dense: true,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: AppEdgeInsets.medium,
        ),
        subtitle: const Text(
          'Toque para editar',
          style: TextStyle(
            fontWeight: FontWeight.w700,
          ),
        ),
        title: Text(
          codearq,
          style: textStyle,
        ),
        trailing: Icon(
          Icons.edit_rounded,
          color: colorScheme.primary,
        ),
      ),
    );
  }
}

class _CodearqEditTile extends StatelessWidget {
  const _CodearqEditTile({
    Key? key,
    required this.focusNode,
    required this.controller,
  }) : super(key: key);

  final FocusNode focusNode;
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(
        AppEdgeInsets.medium,
      ).copyWith(top: AppEdgeInsets.small),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              autofocus: true,
              focusNode: focusNode,
              controller: controller,
              decoration: const InputDecoration(
                filled: true,
                isDense: true,
                hintText: 'ElPCD',
                border: InputBorder.none,
                focusedBorder: OutlineInputBorder(
                  borderRadius: AppBorderRadius.all,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
