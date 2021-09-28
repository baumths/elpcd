import 'package:flutter/material.dart';

import '../../components/svg_image.dart';
import '../../theme/theme.dart';
import 'widgets/widgets.dart';

class MainView extends StatelessWidget {
  const MainView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Theme.of(context).colorScheme.secondary,
      child: Row(
        children: const <Widget>[
          Expanded(
            flex: 6,
            child: BrowseView(),
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 20),
            child: Center(
              child: SizedBox(
                width: 40,
                height: double.infinity,
                child: Icon(Icons.double_arrow_rounded),
              ),
            ),
          ),
          Expanded(
            key: Key('ComposeView'),
            flex: 4,
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 20),
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
            ),
          ),
          SizedBox(width: 20),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 20),
            child: MainSidebarMenu(),
          ),
          SizedBox(width: 20)
        ],
      ),
    );
  }
}

class BrowseView extends StatelessWidget {
  const BrowseView({
    Key key = const Key('BrowseView'),
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const PhysicalModel(
      elevation: 12,
      color: Colors.white,
      child: SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: BrowsePlaceholder(),
      ),
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
      padding: const EdgeInsets.all(40),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          const Flexible(child: SvgImage.box),
          const SizedBox(height: 40),
          const Flexible(
            child: Text(
              'Você ainda não criou nenhuma classe.',
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
