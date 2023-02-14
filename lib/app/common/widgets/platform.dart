import 'package:flutter/material.dart';
import 'package:universal_platform/universal_platform.dart';

class PlatformCheck extends StatelessWidget {
  final Widget app;
  final Widget web;

  const PlatformCheck({
    Key? key,
    required this.app,
    required this.web,
  }) : super(key: key);

  static bool isApp(BuildContext context) =>
      UniversalPlatform.isAndroid || UniversalPlatform.isIOS;

  static bool isWeb(BuildContext context) =>
      UniversalPlatform.isWindows || UniversalPlatform.isMacOS;

  @override
  Widget build(BuildContext context) {
    if (UniversalPlatform.isAndroid || UniversalPlatform.isIOS) {
      return app;
    } else {
      return web;
    }
  }
}
