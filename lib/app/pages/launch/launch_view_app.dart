import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:order_automation/app/pages/launch/launch.dart';
import 'package:order_automation/domain/blocs/launch/launch_bloc.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:percent_indicator/percent_indicator.dart';

import '../../common/common.dart';

class LaunchViewApp extends StatelessWidget {
  const LaunchViewApp({
    super.key,
    required this.keys,
    required this.statusAccept,
    required this.statusInstruct,
    required this.statusDeparture,
    required this.statusDelivering,
    required this.statusFinalDelivery,
    required this.consumerService,
    required this.callCenterInquiries,
    required this.revenueHistory,
    required this.isKeyTextFieldClicked,
    required this.isLoadingFinished,
    required this.onStartedProgress,
  });

  final List<String> keys;
  final List<dynamic> statusAccept;
  final List<dynamic> statusInstruct;
  final List<dynamic> statusDeparture;
  final List<dynamic> statusDelivering;
  final List<dynamic> statusFinalDelivery;
  final List<dynamic> consumerService;
  final List<dynamic> callCenterInquiries;
  final Map<dynamic, dynamic> revenueHistory;
  final bool isKeyTextFieldClicked;
  final bool isLoadingFinished;
  final double onStartedProgress;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: defaultPadding),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(title),
              Row(
                children: [
                  GestureDetector(
                    onTap: () async {
                      BlocProvider.of<LaunchBloc>(context).add(
                        LaunchEventRefreshed(),
                      );
                      HapticFeedback.heavyImpact();
                    },
                    child: const Icon(Icons.refresh),
                  ),
                  const SizedBox(
                    width: defaultPadding,
                  ),
                  GestureDetector(
                    onTap: () async {
                      HapticFeedback.heavyImpact();

                      FlutterBarcodeScanner.scanBarcode(
                          '#ff6666', '취소', false, ScanMode.DEFAULT);
                    },
                    child: const Icon(Icons.barcode_reader),
                  ),
                  const SizedBox(
                    width: defaultPadding,
                  ),
                  GestureDetector(
                    onTap: () {
                      BlocProvider.of<LaunchBloc>(context).add(
                        LaunchEventKeyTextFieldClicked(),
                      );
                      if (isKeyTextFieldClicked) {
                        BlocProvider.of<LaunchBloc>(context).add(
                          LaunchEventRefreshed(),
                        );
                      }
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
          isLoadingFinished
              ? Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        LaunchViewAppListTile(
                            keys: keys,
                            status: coupangStatusAccept,
                            statusJson: statusAccept,
                            title: '결제완료'),
                        LaunchViewAppListTile(
                            keys: keys,
                            status: coupangStatusInstruct,
                            statusJson: statusInstruct,
                            title: '상품준비중'),
                        LaunchViewAppListTile(
                            keys: keys,
                            status: coupangStatusDeparture,
                            statusJson: statusDeparture,
                            title: '배송지시'),
                        LaunchViewAppListTile(
                            keys: keys,
                            status: coupangStatusDelivering,
                            statusJson: statusDelivering,
                            title: '배송중'),
                        LaunchViewAppListTile(
                            keys: keys,
                            status: coupangStatusFinalDelivery,
                            statusJson: statusFinalDelivery,
                            title: '배송완료'),
                        Padding(
                          padding:
                              const EdgeInsets.only(bottom: defaultPadding),
                          child: Container(
                            decoration: BoxDecoration(
                              color: primaryColor,
                              borderRadius:
                                  BorderRadius.circular(defaultPadding),
                            ),
                            child: Row(
                              children: [
                                Expanded(
                                  child: Padding(
                                    padding:
                                        const EdgeInsets.all(defaultPadding),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Expanded(
                                              child: Text(
                                                  '매출합계 : ${revenueHistory['totalSells'] ?? 0}개 ${revenueHistory['total'] ?? 0}원'),
                                            ),
                                            const SizedBox(
                                              width: defaultPadding / 2,
                                            ),
                                            const Text('최근 30일'),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Padding(
                          padding:
                              const EdgeInsets.only(bottom: defaultPadding),
                          child: Container(
                            decoration: BoxDecoration(
                              color: primaryColor,
                              borderRadius:
                                  BorderRadius.circular(defaultPadding),
                            ),
                            child: Row(
                              children: [
                                Expanded(
                                  child: Padding(
                                    padding:
                                        const EdgeInsets.all(defaultPadding),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Expanded(
                                              child: Text(
                                                  '고객문의 : ${consumerService.length}'),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Padding(
                          padding:
                              const EdgeInsets.only(bottom: defaultPadding),
                          child: Container(
                            decoration: BoxDecoration(
                              color: primaryColor,
                              borderRadius:
                                  BorderRadius.circular(defaultPadding),
                            ),
                            child: Row(
                              children: [
                                Expanded(
                                  child: Padding(
                                    padding:
                                        const EdgeInsets.all(defaultPadding),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Expanded(
                                              child: Text(
                                                  '쿠팡문의 : ${callCenterInquiries.length}'),
                                            ),
                                          ],
                                        ),
                                      ],
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
                )
              : Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        'assets/images/splash_image/splash.png',
                        width: MediaQuery.of(context).size.width / 1.5,
                      ),
                      const SizedBox(
                        height: defaultPadding,
                      ),
                      Text('${onStartedProgress * 100}%'),
                      const SizedBox(
                        height: defaultPadding / 2,
                      ),
                      SizedBox(
                        height: defaultPadding * 3,
                        child: LinearPercentIndicator(
                          animation: true,
                          animateFromLastPercent: true,
                          lineHeight: defaultPadding * 3,
                          barRadius: const Radius.circular(defaultPadding),
                          percent: onStartedProgress,
                          backgroundColor: primaryColor,
                          progressColor: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
        ],
      ),
    );
  }
}
