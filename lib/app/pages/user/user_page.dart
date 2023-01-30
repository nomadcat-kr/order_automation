import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:order_automation/app/pages/user/user.dart';
import 'package:order_automation/domain/blocs/user/user_bloc.dart';

class UserPage extends StatelessWidget {
  const UserPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => UserBloc()
        ..add(
          UserEventStarted(),
        ),
      child: const UserView(),
    );
  }
}
