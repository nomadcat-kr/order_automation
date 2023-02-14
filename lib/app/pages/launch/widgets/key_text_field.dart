import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:order_automation/data/data.dart';
import 'package:order_automation/domain/blocs/launch/launch_bloc.dart';

import 'package:order_automation/app/common/common.dart';

class KeyTextField extends StatefulWidget {
  const KeyTextField({
    super.key,
    required this.keyNumber,
  });

  final int keyNumber;

  @override
  State<KeyTextField> createState() => _KeyTextFieldState();
}

class _KeyTextFieldState extends State<KeyTextField> {
  final TextEditingController _textEditingController = TextEditingController();
  late FocusNode _focusNode;
  final GetCoupangKeys _getCoupangKeys = GetCoupangKeys();
  final SaveCoupangKeys _saveCoupangKeys = SaveCoupangKeys();
  List<String> _keys = [];

  @override
  void initState() {
    _keys = _getCoupangKeys.getCoupangKeys();
    _textEditingController.text = _keys[widget.keyNumber];
    _focusNode = FocusNode();
    if (widget.keyNumber == 0) {
      _focusNode.requestFocus();
    }
    _textEditingController.addListener(() {
      BlocProvider.of<LaunchBloc>(context).add(
        LaunchEventTextEditing(
          inputText: _textEditingController.value.toString(),
        ),
      );
    });
    super.initState();
  }

  @override
  void dispose() {
    _textEditingController.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: defaultPadding),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              focusNode: _focusNode,
              controller: _textEditingController,
              showCursor: true,
              cursorColor: Colors.white,
              keyboardType: TextInputType.text,
              decoration: InputDecoration(
                hintText: coupangKeyList[widget.keyNumber],
                fillColor: primaryColor,
                filled: true,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(defaultPadding),
                  borderSide: const BorderSide(
                    width: 0,
                    style: BorderStyle.none,
                  ),
                ),
                errorStyle: const TextStyle(color: Colors.redAccent),
              ),
            ),
          ),
          const SizedBox(
            width: defaultPadding,
          ),
          GestureDetector(
            onTap: () async {
              if (_textEditingController.text.isEmpty) {
                HapticFeedback.heavyImpact();
              } else {
                String keyVendorId = _textEditingController.text.trim();
                if (widget.keyNumber == 0) {
                  var ref = FirebaseFirestore.instance.collection(coupang);
                  var doc = await ref.doc(keyVendorId).get();
                  if (!doc.exists) {
                    ref.doc(keyVendorId).set({
                      'excel': [],
                      'onGoingOrders': [],
                      'completeOrders': [],
                    });
                  }
                }
                _saveCoupangKeys.saveCoupangKeys(
                    coupangKeyList[widget.keyNumber],
                    _textEditingController.text.trim());
                HapticFeedback.heavyImpact();
              }
            },
            child: Icon(
              Icons.check,
              color: _textEditingController.text.isEmpty
                  ? Colors.grey.withOpacity(0.5)
                  : Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}
