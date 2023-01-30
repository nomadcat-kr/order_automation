import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:order_automation/data/data.dart';
import 'package:order_automation/domain/blocs/launch/launch_bloc.dart';

import 'package:order_automation/app/common/common.dart';

class SideTextField extends StatefulWidget {
  const SideTextField({
    super.key,
    required this.keyNumber,
  });

  final int keyNumber;

  @override
  State<SideTextField> createState() => _SideTextFieldState();
}

class _SideTextFieldState extends State<SideTextField> {
  final TextEditingController _textEditingController = TextEditingController();
  final GetCoupangKeys _getCoupangKeys = GetCoupangKeys();
  final SaveCoupangKeys _saveCoupangKeys = SaveCoupangKeys();
  List<String> _keys = [];

  @override
  void initState() {
    _keys = _getCoupangKeys.getCoupangKeys();
    _textEditingController.text = _keys[widget.keyNumber];
    _textEditingController.addListener(() {
      BlocProvider.of<LaunchBloc>(context).add(
        LaunchEventTextEditing(),
      );
    });
    super.initState();
  }

  @override
  void dispose() {
    _textEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
      child: TextField(
        controller: _textEditingController,
        decoration: InputDecoration(
          hintText: coupangKeyList[widget.keyNumber],
          fillColor: primaryColor,
          filled: true,
          border: const OutlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: BorderRadius.all(
              Radius.circular(10),
            ),
          ),
          suffixIcon: InkWell(
            onTap: () {
              _saveCoupangKeys.saveCoupangKeys(coupangKeyList[widget.keyNumber],
                  _textEditingController.text.trim());
              // BlocProvider.of<LaunchBloc>(context).add(
              //   LaunchEventTextFieldClicked(),
              // );
            },
            child: const Icon(Icons.check),
          ),
        ),
      ),
    );
  }
}
