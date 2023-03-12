import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:order_automation/domain/blocs/launch/launch_bloc.dart';

import '../../../common/common.dart';

class BoxTextField extends StatefulWidget {
  const BoxTextField({
    super.key,
    required this.rocketGrowthCenter,
    required this.rocketGrowthBox,
  });

  final String rocketGrowthCenter;
  final String rocketGrowthBox;

  @override
  State<BoxTextField> createState() => _BoxTextFieldState();
}

class _BoxTextFieldState extends State<BoxTextField> {
  final TextEditingController _textEditingController = TextEditingController();
  late FocusNode _focusNode;

  @override
  void initState() {
    _focusNode = FocusNode();
    _textEditingController.addListener(() {
      BlocProvider.of<LaunchBloc>(context).add(
        LaunchEventRocketGrowthBoxEditing(
          rocketGrowthBox: _textEditingController.text.toString(),
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
    return Expanded(
      flex: 2,
      child: Row(
        children: [
          Expanded(
            flex: 1,
            child: Column(
              children: [
                const Text('박스수량'),
                const SizedBox(
                  height: defaultPadding,
                ),
                TextField(
                  focusNode: _focusNode,
                  controller: _textEditingController,
                  showCursor: true,
                  cursorColor: Colors.white,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    hintText: '1일 9개 이하',
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
              ],
            ),
          ),
          const SizedBox(
            width: defaultPadding,
          ),
          Expanded(
            flex: 1,
            child: Column(
              children: [
                const Text('파일생성'),
                const SizedBox(
                  height: defaultPadding,
                ),
                Row(
                  children: [
                    Expanded(
                      child: InkWell(
                        onTap: () {
                          BlocProvider.of<LaunchBloc>(context).add(
                            LaunchEventRocketGrowthExcelClicked(),
                          );
                          _textEditingController.clear();
                        },
                        borderRadius: BorderRadius.circular(defaultPadding),
                        splashColor: Colors.transparent,
                        child: Container(
                          decoration: BoxDecoration(
                            color: primaryColor,
                            borderRadius: BorderRadius.circular(defaultPadding),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(defaultPadding),
                            child: Row(
                              children: [
                                Visibility(
                                  visible: widget.rocketGrowthCenter == '' ||
                                      widget.rocketGrowthBox == '',
                                  child: const Text(
                                    '',
                                    style: TextStyle(color: primaryColor),
                                  ),
                                ),
                                Visibility(
                                  visible: widget.rocketGrowthCenter != '',
                                  child: Text(widget.rocketGrowthCenter),
                                ),
                                Visibility(
                                  visible: widget.rocketGrowthBox != '',
                                  child: Text(' 박스 ${widget.rocketGrowthBox}개'),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
