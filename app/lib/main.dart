import 'package:flutter/widgets.dart';
import 'package:storage_service/storage_service.dart';

import '/features/app/app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final storageFacade = InMemoryStorageFacade();
  await storageFacade.init();

  runApp(ElpcdApp(
    storageFacade: storageFacade,
  ));
}
