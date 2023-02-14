import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:order_automation/app/pages/launch/launch.dart';
import 'package:order_automation/domain/blocs/launch/launch_bloc.dart';

import 'package:order_automation/app/common/common.dart';

class LaunchViewWebListTile extends StatelessWidget {
  const LaunchViewWebListTile({
    super.key,
    required this.keys,
    required this.isKeyTextFieldClicked,
  });

  final List<String> keys;
  final bool isKeyTextFieldClicked;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: primaryColor,
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
                LaunchEventOrderListDownloadClicked(),
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
          GestureDetector(
            onTap: () {
              BlocProvider.of<LaunchBloc>(context).add(
                LaunchEventKeyTextFieldClicked(),
              );
              HapticFeedback.heavyImpact();
            },
            child: isKeyTextFieldClicked
                ? const Icon(Icons.arrow_upward)
                : keys.contains('')
                ? const Icon(Icons.add)
                : const Icon(Icons.check),
          ),
          Visibility(
            visible: isKeyTextFieldClicked,
            child: Padding(
              padding: const EdgeInsets.all(defaultPadding),
              child: ListView.builder(
                itemCount: 4,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (BuildContext context, int index) {
                  return KeyTextField(
                    keyNumber: index,
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
