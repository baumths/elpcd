import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

void showErrorSnackBar(BuildContext context, String message) {
  ScaffoldMessenger.of(context)
    ..hideCurrentSnackBar()
    ..showSnackBar(SnackBar(
      duration: const Duration(seconds: 5),
      padding: const EdgeInsetsDirectional.fromSTEB(16, 14, 16, 14),
      content: Row(
        children: [
          const Icon(LucideIcons.triangleAlert, color: Colors.orange),
          const SizedBox(width: 12),
          Expanded(child: Text(message)),
        ],
      ),
    ));
}

void showInfoSnackBar(BuildContext context, String message) {
  ScaffoldMessenger.of(context)
    ..hideCurrentSnackBar()
    ..showSnackBar(SnackBar(
      duration: const Duration(seconds: 5),
      content: Text(message),
    ));
}
