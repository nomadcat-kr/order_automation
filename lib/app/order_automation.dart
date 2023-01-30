import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:order_automation/app/common/common.dart';

import 'pages/launch/launch.dart';

class OrderAutomation extends StatelessWidget {
  const OrderAutomation({super.key});

  @override
  Widget build(BuildContext context) {
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
