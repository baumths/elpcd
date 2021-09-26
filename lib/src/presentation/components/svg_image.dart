import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../app/assets.dart';

class SvgImage extends StatelessWidget {
  const SvgImage(
    this.svgPath, {
    Key? key,
    this.width,
    this.height,
  }) : super(key: key);

  static const SvgImage box = SvgImage(
    AppAssets.box,
    width: 320,
    height: 320,
  );

  static const SvgImage factory = SvgImage(
    AppAssets.factory,
    width: 320,
    height: 220,
  );

  final String svgPath;

  final double? width;
  final double? height;

  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(
      svgPath,
      width: width,
      height: height,
    );
  }
}
