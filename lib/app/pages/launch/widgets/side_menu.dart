import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:order_automation/app/pages/launch/launch.dart';
import 'package:order_automation/domain/blocs/launch/launch_bloc.dart';

import 'package:order_automation/app/common/common.dart';

class SideMenu extends StatelessWidget {
  const SideMenu({
    super.key,
    required this.keys,
    required this.isKeyTextFieldClicked,
  });

  final List<String> keys;
  final bool isKeyTextFieldClicked;

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: SingleChildScrollView(
        child: Column(
          children: [
            const DrawerHeader(
              child: Center(
                child: Text(title),
              ),
            ),
            DrawerListTile(
              title: '발주서 출력',
              icon: const Icon(
                Icons.file_download,
                color: Colors.white54,
              ),
              press: () {
                BlocProvider.of<LaunchBloc>(context).add(
                  LaunchEventOrderListPrintClicked(),
                );
              },
            ),
            DrawerListTile(
              title: '운송장 입력',
              icon: const Icon(
                Icons.file_upload,
                color: Colors.white54,
              ),
              press: () {
                // BlocProvider.of<LaunchBloc>(context).add(
                //   LaunchEventClicked(),
                // );
              },
            ),
            DrawerListTile(
              title: '키 입력',
              icon: const Icon(
                Icons.key,
                color: Colors.white54,
              ),
              press: () {
                BlocProvider.of<LaunchBloc>(context).add(
                  LaunchEventKeyTextFieldClicked(),
                );
              },
            ),
            if (isKeyTextFieldClicked)
              for (int i = 0; i < 4; i++) SideTextField(keyNumber: i),
          ],
        ),
      ),
    );
  }
}
