import 'package:flutter/material.dart';

import '../../../components/animated_state.dart';
import 'widgets/widgets.dart';

class SettingsView extends StatefulWidget {
  const SettingsView({
    Key key = const Key('SettingsView'),
  }) : super(key: key);

  static final List<SettingsCardContent> cards = [
    SettingsCardContent(
      title: 'Tipo de Visualização',
      builder: (_) => const BrowserTypeTile(),
    ),
    SettingsCardContent(
      title: 'Alterar CODEARQ',
      builder: (_) => const CodearqTile(),
      infoTooltip: 'O CODEARQ é salvo automaticamente',
    ),
  ];

  @override
  State<SettingsView> createState() => _SettingsViewState();
}

class _SettingsViewState extends AnimatedState<SettingsView> {
  @override
  void initState() {
    super.initState();
    if (mounted) {
      animateForward();
    }
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: animation,
      child: Scrollbar(
        child: ListView.separated(
          itemCount: SettingsView.cards.length,
          padding: const EdgeInsets.all(10),
          separatorBuilder: (_, __) => const SizedBox(height: 10),
          itemBuilder: (_, int index) {
            return SettingsCard(
              content: SettingsView.cards[index],
            );
          },
        ),
      ),
    );
  }
}
