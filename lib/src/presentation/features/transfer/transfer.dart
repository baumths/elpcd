import 'package:flutter/material.dart';

import '../../components/buttons/stretched.dart';
import '../../theme/theme.dart';

part 'widgets/_content.dart';
part 'widgets/_csv_export.dart';
part 'widgets/_json_backup.dart';
part 'widgets/_section.dart';

class Transfer extends StatelessWidget {
  const Transfer({
    Key key = const Key('Transfer'),
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(AppInsets.small),
      child: ListView(
        children: const [
          CsvExportSection(),
          SizedBox(height: AppInsets.small),
          JsonBackupSection(),
        ],
      ),
    );
  }
}
