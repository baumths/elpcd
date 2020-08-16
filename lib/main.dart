import 'package:flutter/material.dart';

import 'package:elpcd_dart/src/database/hive_database.dart';
import 'package:elpcd_dart/src/core/app.dart';

void main() async {
  await HiveDatabase.instance.initDatabase();
  runApp(ElPCDApp());
}
