import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:order_automation/app/pages/launch/launch.dart';
import 'package:order_automation/domain/blocs/launch/launch_bloc.dart';

class LaunchPage extends StatelessWidget {
  const LaunchPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => LaunchBloc()
        ..add(
          LaunchEventStarted(),
        ),
      child: const LaunchView(),
    );
  }
}
