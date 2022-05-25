import 'package:flutter/material.dart';

import '../../../theme/theme.dart';

class CreateClassButton extends StatelessWidget {
  const CreateClassButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox.square(
      dimension: kSearchBarHeight,
      child: ElevatedButton(
        child: const Icon(Icons.add_to_photos_rounded),
        style: ElevatedButton.styleFrom(
          elevation: kSearchBarElevation,
          shadowColor: Colors.white,
          padding: EdgeInsets.zero,
        ),
        onPressed: () {
          // TODO: Setup CreateClassButton action
        },
      ),
    );
  }
}
