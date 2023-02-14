import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:order_automation/app/common/common.dart';
import 'package:universal_platform/universal_platform.dart';

import 'pages/launch/launch.dart';

class OrderAutomation extends StatelessWidget {
  const OrderAutomation({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness:
            UniversalPlatform.isAndroid ? Brightness.light : Brightness.dark,
        statusBarBrightness:
            UniversalPlatform.isAndroid ? Brightness.light : Brightness.dark,
        systemNavigationBarColor: Colors.grey[900],
        systemNavigationBarDividerColor: Colors.grey[900],
        systemNavigationBarIconBrightness: Brightness.light,
      ),
    );
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: title,
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: backgroundColor,
        textTheme: GoogleFonts.poppinsTextTheme(
          Theme.of(context).textTheme.apply(bodyColor: Colors.white),
        ),
        canvasColor: secondaryColor,
      ),
      home: const LaunchPage(),
    );
  }
}
