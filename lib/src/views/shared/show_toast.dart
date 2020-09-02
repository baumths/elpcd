import 'package:flutter/material.dart';
import 'package:toast/toast.dart';

import '../../utils/extensions.dart';

abstract class ShowToast {
  static error(BuildContext context, String msg, {int duration = 3}) {
    Toast.show(
      msg,
      context,
      duration: duration,
      textColor: Colors.white,
      backgroundColor: Colors.red[900],
    );
  }

  static info(BuildContext context, String msg, {int duration = 2}) {
    Toast.show(
      msg,
      context,
      duration: duration,
      textColor: Colors.black,
      backgroundColor: context.accentColor,
    );
  }
}
