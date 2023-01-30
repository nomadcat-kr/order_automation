import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:order_automation/bloc_observer.dart';
import 'package:order_automation/app/order_automation.dart';
import 'package:url_strategy/url_strategy.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  await Hive.openBox('coupang');
  Bloc.observer = BlocJsonObserver();
  setPathUrlStrategy();
  runApp(const OrderAutomation());
}

// flutter build web
// firebase deploy --only hosting