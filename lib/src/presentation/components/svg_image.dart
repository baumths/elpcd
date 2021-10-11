import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../app/assets.dart';

class SvgImage extends StatelessWidget {
  static const SvgImage box = SvgImage(
    path: AppAssets.box,
    width: 320,
    height: 320,
  );

  static const SvgImage factory = SvgImage(
    path: AppAssets.factory,
    width: 320,
    height: 220,
  );

  const SvgImage({
    Key? key,
    required this.path,
    this.width,
    this.height,
  }) : super(key: key);

  final String path;

  final double? width;
  final double? height;

  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(
      path,
      width: width,
      height: height,
    );
  }
}
