import 'package:package_info_plus/package_info_plus.dart';

PackageInfo? appInfo;

void setupAppInfo() {
  PackageInfo.fromPlatform().then((PackageInfo info) => appInfo = info);
}
