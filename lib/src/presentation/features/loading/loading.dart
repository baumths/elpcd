import 'package:flutter/material.dart';

import '../../app/assets.dart';

class LoadingView extends StatelessWidget {
  const LoadingView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Column(
        children: const <Widget>[
          LinearProgressIndicator(
            minHeight: 6,
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.all(20),
              child: Image(
                image: AssetImage(AppAssets.logo),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
