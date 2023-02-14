import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:order_automation/app/pages/launch/launch.dart';
import 'package:order_automation/domain/blocs/launch/launch_bloc.dart';

import '../../common/common.dart';

class LaunchViewWeb extends StatelessWidget {
  const LaunchViewWeb({
    super.key,
    required this.keys,
    required this.isKeyTextFieldClicked,
    required this.isLoadingFinished,
  });

  final List<String> keys;
  final bool isKeyTextFieldClicked;
  final bool isLoadingFinished;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(defaultPadding),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(title),
                Row(
                  children: [
                    isLoadingFinished
                        ? keys.contains('')
                            ? Container()
                            : StreamBuilder<DocumentSnapshot>(
                                stream: FirebaseFirestore.instance
                                    .collection(coupang)
                                    .doc(keys[0])
                                    .snapshots(),
                                builder: (context, snapshot) {
                                  if (!snapshot.hasData) return Container();

                                  bool isOrderListExist = false;
                                  if (snapshot.data!['excel'].length != 0) {
                                    isOrderListExist = true;
                                  }

                                  bool isInvoiceOrderExist = false;
                                  int invoiceOrdersLeftList = 0;
                                  if (snapshot.data!['onGoingOrders'].length !=
                                      0) {
                                    isInvoiceOrderExist = true;
                                    for (int i = 0;
                                        i <
                                            snapshot
                                                .data!['onGoingOrders'].length;
                                        i++) {
                                      if (snapshot.data!['onGoingOrders'][i]
                                                  ['orderSheetInvoiceApplyDtos']
                                              ['invoiceNumber'] ==
                                          '') {
                                        invoiceOrdersLeftList++;
                                      }
                                    }
                                  }

                                  return Row(
                                    children: [
                                      InkWell(
                                        onTap: () {
                                          if (isOrderListExist) {
                                            BlocProvider.of<LaunchBloc>(context)
                                                .add(
                                              LaunchEventOrderListDownloadClicked(),
                                            );
                                          }
                                          HapticFeedback.heavyImpact();
                                        },
                                        child: Text(
                                          '발주서 출력',
                                          style: TextStyle(
                                              color: isOrderListExist
                                                  ? Colors.white
                                                  : Colors.grey
                                                      .withOpacity(0.5)),
                                        ),
                                      ),
                                      const SizedBox(
                                        width: defaultPadding,
                                      ),
                                      InkWell(
                                        onTap: () {
                                          if (isInvoiceOrderExist) {
                                            BlocProvider.of<LaunchBloc>(context)
                                                .add(
                                              LaunchEventInvoiceListUploadClicked(),
                                            );
                                          }
                                          HapticFeedback.heavyImpact();
                                        },
                                        child: Text(
                                            '운송장 입력 $invoiceOrdersLeftList',
                                            style: TextStyle(
                                                color: isInvoiceOrderExist
                                                    ? Colors.white
                                                    : Colors.grey
                                                        .withOpacity(0.5))),
                                      ),
                                      const SizedBox(
                                        width: defaultPadding,
                                      ),
                                    ],
                                  );
                                })
                        : const Text('Loading...'),
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
                  ],
                ),
              ],
            ),
            const SizedBox(
              height: defaultPadding,
            ),
            Visibility(
              visible: isKeyTextFieldClicked,
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
            const SizedBox(
              height: defaultPadding,
            ),
          ],
        ),
      ),
    );
  }
}
