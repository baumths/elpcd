part of '../settings.dart';

class CodearqTile extends StatefulWidget {
  const CodearqTile({
    Key key = const Key('CodearqTile'),
  }) : super(key: key);

  final String codearq = 'ElPCD'; // TODO: get from user preferences

  @override
  State<CodearqTile> createState() => _CodearqTileState();
}

class _CodearqTileState extends State<CodearqTile> {
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
    final ThemeData theme = Theme.of(context);

    // TODO: Perhaps debounce field's onChanged and save after some delay?

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
          child: CodearqHelperText(),
        ),
        SizedBox(
          height: 64,
          child: Center(
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

  void onTap() {
    // TODO:
    print('LAUNCH ==> $conarqUrl');
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final ColorScheme colorScheme = theme.colorScheme;
    final TextStyle? textStyle = theme.textTheme.caption;

    return RichText(
      text: TextSpan(
        style: textStyle?.copyWith(fontWeight: FontWeight.w500),
        text: 'Este será o nome da instituição arquivística '
            'criada no AtoM quando você importar o arquivo CSV do seu PCD.\n\n'
            'Para mais informações sobre o CODEARQ, acesse o '
            'Cadastro nacional de entidades custodiadoras de acervos arquivísticos ',
        children: [
          WidgetSpan(
            child: Tooltip(
              textStyle: theme.tooltipTheme.textStyle?.copyWith(fontSize: 10),
              verticalOffset: 10,
              child: MouseRegion(
                cursor: SystemMouseCursors.click,
                child: GestureDetector(
                  onTap: onTap,
                  child: Text(
                    'clicando aqui',
                    style: textStyle?.copyWith(
                      color: colorScheme.primary,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
              message: conarqUrl,
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

    return ListTile(
      dense: true,
      horizontalTitleGap: 2,
      contentPadding: const EdgeInsets.symmetric(horizontal: 10),
      trailing: Icon(Icons.edit_rounded, color: colorScheme.primary),
      subtitle: const Text('Toque para editar'),
      title: Text(codearq, style: textStyle),
      onTap: onTap,
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
      padding: const EdgeInsets.symmetric(horizontal: 10),
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
                border: InputBorder.none,
                hintText: 'ElPCD',
                focusedBorder: OutlineInputBorder(
                  borderRadius: AppBorderRadius.all,
                  borderSide: BorderSide(width: .9),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
