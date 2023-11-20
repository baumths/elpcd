import 'package:flutter/widgets.dart';
import 'package:flutter_web_plugins/url_strategy.dart';
import 'package:provider/provider.dart';
import 'package:storage_service/storage_service.dart';

import '/features/app/app.dart';

void main() async {
  // `package:provider` is only used as a service locator. State management is
  // handled with native listenables and notifiers. The following instruction
  // makes sure we don't get an error screen when providing `Listenable`s to
  // the widget tree.
  Provider.debugCheckInvalidValueType = null;

  usePathUrlStrategy();
  WidgetsFlutterBinding.ensureInitialized();

  final storageFacade = VirtualStorageFacade();
  await storageFacade.init();

  runApp(ElpcdApp(
    storageFacade: storageFacade,
  ));
}
