import 'package:flutter/material.dart';

import '../../components/svg_image.dart';
import '../../theme/theme.dart';
import '../menu/menu.dart';

class MainView extends StatelessWidget {
  const MainView({
    Key key = const Key('MainView'),
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ColorScheme colorScheme = Theme.of(context).colorScheme;

    return Material(
      color: colorScheme.secondary,
      child: Row(
        children: const <Widget>[
          Expanded(
            child: Menu(),
          ),
          Expanded(
            child: Compose(),
          ),
        ],
      ),
    );
  }
}

class Compose extends StatelessWidget {
  const Compose({
    Key key = const Key('ComposeView'),
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.all(AppInsets.large),
      child: PhysicalModel(
        elevation: 8,
        borderRadius: AppBorderRadius.all,
        color: Colors.white,
        child: SizedBox.expand(
          child: Center(
            child: SvgImage.factory,
          ),
        ),
      ),
    );
  }
}

class Browse extends StatelessWidget {
  const Browse({
    Key key = const Key('BrowseView'),
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const SizedBox(
      width: double.infinity,
      height: double.infinity,
      child: BrowsePlaceholder(),
    );
  }
}

class BrowsePlaceholder extends StatelessWidget {
  const BrowsePlaceholder({
    Key key = const Key('BrowsePlaceholder'),
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(AppInsets.large),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          const Flexible(child: SvgImage.box),
          const SizedBox(height: 40),
          const Flexible(
            child: Text(
              'Seu PCD está vazio.',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 24,
              ),
            ),
          ),
          const SizedBox(height: 40),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              fixedSize: const Size(256, 56),
              shape: const RoundedRectangleBorder(
                borderRadius: AppBorderRadius.all,
              ),
            ),
            onPressed: () {
              // TODO: Open Form and Create Class
            },
            child: const Center(
              child: Text(
                'Criar Classe',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
