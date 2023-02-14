import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:order_automation/domain/blocs/launch/launch_bloc.dart';

import '../../../common/common.dart';

class LaunchViewAppListTile extends StatelessWidget {
  const LaunchViewAppListTile({
    super.key,
    required this.keys,
    required this.status,
    required this.statusJson,
    required this.title,
  });

  final List<String> keys;
  final String status;
  final List<dynamic> statusJson;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: defaultPadding),
      child: Container(
        decoration: BoxDecoration(
          color: primaryColor,
          borderRadius: BorderRadius.circular(defaultPadding),
        ),
        child: Row(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(defaultPadding),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Text('$title : ${statusJson.length}'),
                        ),
                        keys.contains('')
                            ? Container()
                            : Visibility(
                                visible: status == coupangStatusAccept ||
                                    status == coupangStatusInstruct,
                                child: StreamBuilder<DocumentSnapshot>(
                                    stream: FirebaseFirestore.instance
                                        .collection(coupang)
                                        .doc(keys[0])
                                        .snapshots(),
                                    builder: (context, snapshot) {
                                      if (!snapshot.hasData) return Container();
                                      if (status == coupangStatusAccept) {
                                        return GestureDetector(
                                          onTap: () {
                                            if (statusJson.isNotEmpty) {
                                              BlocProvider.of<LaunchBloc>(
                                                      context)
                                                  .add(
                                                LaunchEventOrderListUploadClicked(),
                                              );
                                            }
                                            HapticFeedback.heavyImpact();
                                          },
                                          child: Icon(
                                            Icons.upload_file,
                                            color: statusJson.isNotEmpty
                                                ? Colors.white
                                                : Colors.grey.withOpacity(0.5),
                                          ),
                                        );
                                      }
                                      bool isInvoiceOrderExist = false;
                                      for (int i = 0;
                                          i <
                                              snapshot.data!['onGoingOrders']
                                                  .length;
                                          i++) {
                                        if (snapshot.data!['onGoingOrders'][i][
                                                    'orderSheetInvoiceApplyDtos']
                                                ['invoiceNumber'] !=
                                            '') {
                                          isInvoiceOrderExist = true;
                                        }
                                      }
                                      if (status == coupangStatusInstruct) {
                                        return GestureDetector(
                                          onTap: () {
                                            if (isInvoiceOrderExist) {
                                              BlocProvider.of<LaunchBloc>(
                                                      context)
                                                  .add(
                                                LaunchEventInvoiceListPutRequestClicked(),
                                              );
                                            }
                                            HapticFeedback.heavyImpact();
                                          },
                                          child: Icon(
                                            Icons.upload_file,
                                            color: isInvoiceOrderExist
                                                ? Colors.white
                                                : Colors.grey.withOpacity(0.5),
                                          ),
                                        );
                                      }
                                      return Container();
                                    }),
                              ),
                        Visibility(
                          visible: status == coupangStatusFinalDelivery,
                          child: const Text('최근 2주'),
                        ),
                      ],
                    ),
                    Visibility(
                      visible: statusJson.isNotEmpty,
                      child: Padding(
                        padding: const EdgeInsets.only(top: defaultPadding),
                        child: ListView.builder(
                          itemCount: statusJson.length,
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemBuilder: (BuildContext context, int index) {
                            return Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(
                                  child: Text(statusJson[index]['orderItems'][0]
                                      ['vendorItemName']),
                                ),
                                const SizedBox(
                                  width: defaultPadding / 2,
                                ),
                                Text(
                                    '${statusJson[index]['orderItems'][0]['shippingCount']}개'),
                                Text(
                                    ' ${statusJson[index]['orderItems'][0]['orderPrice']}원'),
                              ],
                            );
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
