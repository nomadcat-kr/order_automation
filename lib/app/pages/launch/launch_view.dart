import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:order_automation/app/common/widgets/responsive.dart';
import 'package:order_automation/app/pages/launch/launch.dart';
import 'package:order_automation/domain/blocs/launch/launch_bloc.dart';

class LaunchView extends StatelessWidget {
  const LaunchView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LaunchBloc, LaunchState>(
      builder: (context, state) {
        return Scaffold(
          drawer: SideMenu(
              keys: state.keys ?? [],
              isKeyTextFieldClicked: state.keyTextFieldClicked),
          body: SafeArea(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (Responsive.isDesktop(context))
                  Expanded(
                    flex: 1,
                    child: SideMenu(
                        keys: state.keys ?? [],
                        isKeyTextFieldClicked:
                            state.keyTextFieldClicked),
                  ),
                Expanded(
                  flex: 5,
                  child: DashBoard(result: state.getData),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
