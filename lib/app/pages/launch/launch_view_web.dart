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
    required this.rocketGrowthCenter,
    required this.rocketGrowthBox,
    required this.isDistributionCenterClicked,
    required this.adReportExcel,
    required this.adReportExcelTotal,
    required this.adReportOrderKeyWordClicked,
    required this.adReportOrderImpressionClicked,
    required this.adReportOrderClicksClicked,
    required this.adReportOrderAdExpensesClicked,
    required this.adReportOrderTotalOrdersClicked,
    required this.adReportOrderTotalRevenueClicked,
    required this.adReportOrderCtrClicked,
    required this.adReportOrderCpcClicked,
    required this.adReportOrderCpaClicked,
    required this.adReportOrderRoasClicked,
    required this.adReportExcelFileName,
  });

  final List<String> keys;
  final bool isKeyTextFieldClicked;
  final bool isLoadingFinished;
  final String rocketGrowthCenter;
  final String rocketGrowthBox;
  final bool isDistributionCenterClicked;
  final List<dynamic> adReportExcel;
  final Map<dynamic, dynamic> adReportExcelTotal;
  final bool adReportOrderKeyWordClicked;
  final bool adReportOrderImpressionClicked;
  final bool adReportOrderClicksClicked;
  final bool adReportOrderAdExpensesClicked;
  final bool adReportOrderTotalOrdersClicked;
  final bool adReportOrderTotalRevenueClicked;
  final bool adReportOrderCtrClicked;
  final bool adReportOrderCpcClicked;
  final bool adReportOrderCpaClicked;
  final bool adReportOrderRoasClicked;
  final String adReportExcelFileName;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(defaultPadding),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Expanded(
                flex: 1,
                child: Text(title),
              ),
              Expanded(
                flex: 1,
                child: Visibility(
                  visible: adReportExcel.isNotEmpty,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        adReportExcelFileName,
                        style: const TextStyle(color: Colors.white),
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                flex: 1,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
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
                                      Visibility(
                                        visible: !keys.contains(''),
                                        child: InkWell(
                                          onTap: () {
                                            BlocProvider.of<LaunchBloc>(context)
                                                .add(
                                              LaunchEventAdReportClicked(),
                                            );
                                          },
                                          child: const Text(
                                            '보고서',
                                            style:
                                                TextStyle(color: Colors.white),
                                          ),
                                        ),
                                      ),
                                      const SizedBox(
                                        width: defaultPadding,
                                      ),
                                      Visibility(
                                        visible: !keys.contains(''),
                                        child: InkWell(
                                          onTap: () {
                                            BlocProvider.of<LaunchBloc>(context)
                                                .add(
                                              LaunchEventDistributionCenterClicked(),
                                            );
                                          },
                                          child: const Text(
                                            '물류센터 송장',
                                            style:
                                                TextStyle(color: Colors.white),
                                          ),
                                        ),
                                      ),
                                      const SizedBox(
                                        width: defaultPadding,
                                      ),
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
                        : const Padding(
                            padding: EdgeInsets.only(right: defaultPadding),
                            child: Text('Loading...'),
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
                  ],
                ),
              ),
            ],
          ),
        ),
        Visibility(
          visible: isKeyTextFieldClicked,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: defaultPadding),
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
        const SizedBox(
          height: defaultPadding,
        ),
        Visibility(
          visible: isDistributionCenterClicked,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: defaultPadding),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  flex: 1,
                  child: Column(
                    children: [
                      const Text('물류센터'),
                      const SizedBox(
                        height: defaultPadding,
                      ),
                      ListView.builder(
                        itemCount: coupangRocketGrowthCenterList.length,
                        shrinkWrap: true,
                        itemBuilder: (BuildContext context, int index) {
                          return Padding(
                            padding:
                                const EdgeInsets.only(bottom: defaultPadding),
                            child: InkWell(
                              onTap: () {
                                BlocProvider.of<LaunchBloc>(context).add(
                                  LaunchEventRocketGrowthCenterClicked(
                                    rocketGrowthCenter:
                                        coupangRocketGrowthCenterList[index]
                                            ['name']!,
                                  ),
                                );
                              },
                              borderRadius:
                                  BorderRadius.circular(defaultPadding),
                              splashColor: Colors.transparent,
                              child: Container(
                                decoration: BoxDecoration(
                                  color: rocketGrowthCenter ==
                                          coupangRocketGrowthCenterList[index]
                                              ['name']
                                      ? Colors.white
                                      : primaryColor,
                                  borderRadius:
                                      BorderRadius.circular(defaultPadding),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(defaultPadding),
                                  child: Text(
                                    coupangRocketGrowthCenterList[index]
                                        ['name']!,
                                    style: TextStyle(
                                        color: rocketGrowthCenter ==
                                                coupangRocketGrowthCenterList[
                                                    index]['name']
                                            ? Colors.black
                                            : Colors.white),
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  width: defaultPadding,
                ),
                BoxTextField(
                    rocketGrowthCenter: rocketGrowthCenter,
                    rocketGrowthBox: rocketGrowthBox),
                const Expanded(
                  flex: 4,
                  child: SizedBox(),
                )
              ],
            ),
          ),
        ),
        Visibility(
          visible: adReportExcel.isNotEmpty,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: defaultPadding),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  flex: 2,
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: defaultPadding),
                    child: InkWell(
                      onTap: () {
                        BlocProvider.of<LaunchBloc>(context).add(
                          const LaunchEventAdReportOrderClicked(
                              orderCriteria: 'keyword'),
                        );
                      },
                      borderRadius: BorderRadius.circular(defaultPadding),
                      splashColor: Colors.transparent,
                      highlightColor: Colors.transparent,
                      hoverColor: Colors.transparent,
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(defaultPadding),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(defaultPadding),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                '키워드\n${adReportExcelTotal['totalKeyword']}개',
                                style: const TextStyle(color: Colors.black),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  width: defaultPadding / 2,
                ),
                Expanded(
                  flex: 1,
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: defaultPadding),
                    child: InkWell(
                      onTap: () {
                        BlocProvider.of<LaunchBloc>(context).add(
                          const LaunchEventAdReportOrderClicked(
                              orderCriteria: 'impression'),
                        );
                      },
                      borderRadius: BorderRadius.circular(defaultPadding),
                      splashColor: Colors.transparent,
                      highlightColor: Colors.transparent,
                      hoverColor: Colors.transparent,
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(defaultPadding),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(defaultPadding),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                '노출수\n총 ${adReportExcelTotal['totalImpression']}번',
                                style: const TextStyle(color: Colors.black),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  width: defaultPadding / 2,
                ),
                Expanded(
                  flex: 1,
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: defaultPadding),
                    child: InkWell(
                      onTap: () {
                        BlocProvider.of<LaunchBloc>(context).add(
                          const LaunchEventAdReportOrderClicked(
                              orderCriteria: 'clicks'),
                        );
                      },
                      borderRadius: BorderRadius.circular(defaultPadding),
                      splashColor: Colors.transparent,
                      highlightColor: Colors.transparent,
                      hoverColor: Colors.transparent,
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(defaultPadding),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(defaultPadding),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                '클릭수\n총 ${adReportExcelTotal['totalClicks']}번',
                                style: const TextStyle(color: Colors.black),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  width: defaultPadding / 2,
                ),
                Expanded(
                  flex: 1,
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: defaultPadding),
                    child: InkWell(
                      onTap: () {
                        BlocProvider.of<LaunchBloc>(context).add(
                          const LaunchEventAdReportOrderClicked(
                              orderCriteria: 'adExpenses'),
                        );
                      },
                      borderRadius: BorderRadius.circular(defaultPadding),
                      splashColor: Colors.transparent,
                      highlightColor: Colors.transparent,
                      hoverColor: Colors.transparent,
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(defaultPadding),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(defaultPadding),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                '광고비\n총 ${adReportExcelTotal['totalAdExpenses']}원',
                                style: const TextStyle(color: Colors.black),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  width: defaultPadding / 2,
                ),
                Expanded(
                  flex: 1,
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: defaultPadding),
                    child: InkWell(
                      onTap: () {
                        BlocProvider.of<LaunchBloc>(context).add(
                          const LaunchEventAdReportOrderClicked(
                              orderCriteria: 'ctr'),
                        );
                      },
                      borderRadius: BorderRadius.circular(defaultPadding),
                      splashColor: Colors.transparent,
                      highlightColor: Colors.transparent,
                      hoverColor: Colors.transparent,
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(defaultPadding),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(defaultPadding),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'CTR\n평균 ${adReportExcelTotal['averageCtr']}%',
                                style: const TextStyle(color: Colors.black),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  width: defaultPadding / 2,
                ),
                Expanded(
                  flex: 1,
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: defaultPadding),
                    child: InkWell(
                      onTap: () {
                        BlocProvider.of<LaunchBloc>(context).add(
                          const LaunchEventAdReportOrderClicked(
                              orderCriteria: 'cpc'),
                        );
                      },
                      borderRadius: BorderRadius.circular(defaultPadding),
                      splashColor: Colors.transparent,
                      highlightColor: Colors.transparent,
                      hoverColor: Colors.transparent,
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(defaultPadding),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(defaultPadding),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'CPC\n평균 ${adReportExcelTotal['averageCpc']}원',
                                style: const TextStyle(color: Colors.black),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  width: defaultPadding / 2,
                ),
                Expanded(
                  flex: 1,
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: defaultPadding),
                    child: InkWell(
                      onTap: () {
                        BlocProvider.of<LaunchBloc>(context).add(
                          const LaunchEventAdReportOrderClicked(
                              orderCriteria: 'cpa'),
                        );
                      },
                      borderRadius: BorderRadius.circular(defaultPadding),
                      splashColor: Colors.transparent,
                      highlightColor: Colors.transparent,
                      hoverColor: Colors.transparent,
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(defaultPadding),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(defaultPadding),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'CPA\n평균 ${adReportExcelTotal['averageCpa']}원',
                                style: const TextStyle(color: Colors.black),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  width: defaultPadding / 2,
                ),
                Expanded(
                  flex: 1,
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: defaultPadding),
                    child: InkWell(
                      onTap: () {
                        BlocProvider.of<LaunchBloc>(context).add(
                          const LaunchEventAdReportOrderClicked(
                              orderCriteria: 'roas'),
                        );
                      },
                      borderRadius: BorderRadius.circular(defaultPadding),
                      splashColor: Colors.transparent,
                      highlightColor: Colors.transparent,
                      hoverColor: Colors.transparent,
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(defaultPadding),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(defaultPadding),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'ROAS\n평균 ${adReportExcelTotal['averageRoas']}%',
                                style: const TextStyle(color: Colors.black),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  width: defaultPadding / 2,
                ),
                Expanded(
                  flex: 1,
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: defaultPadding),
                    child: InkWell(
                      onTap: () {
                        BlocProvider.of<LaunchBloc>(context).add(
                          const LaunchEventAdReportOrderClicked(
                              orderCriteria: 'totalOrders'),
                        );
                      },
                      borderRadius: BorderRadius.circular(defaultPadding),
                      splashColor: Colors.transparent,
                      highlightColor: Colors.transparent,
                      hoverColor: Colors.transparent,
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(defaultPadding),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(defaultPadding),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                '판매수\n총 ${adReportExcelTotal['totalTotalOrders']}개',
                                style: const TextStyle(color: Colors.black),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  width: defaultPadding / 2,
                ),
                Expanded(
                  flex: 1,
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: defaultPadding),
                    child: InkWell(
                      onTap: () {
                        BlocProvider.of<LaunchBloc>(context).add(
                          const LaunchEventAdReportOrderClicked(
                              orderCriteria: 'totalRevenue'),
                        );
                      },
                      borderRadius: BorderRadius.circular(defaultPadding),
                      splashColor: Colors.transparent,
                      highlightColor: Colors.transparent,
                      hoverColor: Colors.transparent,
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(defaultPadding),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(defaultPadding),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                '매출액\n총 ${adReportExcelTotal['totalTotalRevenue']}원',
                                style: const TextStyle(color: Colors.black),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        Visibility(
          visible: adReportExcel.isNotEmpty,
          child: Expanded(
            child: Scrollbar(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: defaultPadding),
                  child: ListView.builder(
                    itemCount: adReportExcel.length,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (BuildContext context, int index) {
                      return Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            flex: 2,
                            child: Padding(
                              padding:
                                  const EdgeInsets.only(bottom: defaultPadding),
                              child: Container(
                                decoration: BoxDecoration(
                                  color: primaryColor,
                                  borderRadius:
                                      BorderRadius.circular(defaultPadding),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(defaultPadding),
                                  child: Text(
                                    adReportExcel[index]['keyWord'],
                                    style: const TextStyle(color: Colors.white),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(
                            width: defaultPadding / 2,
                          ),
                          Expanded(
                            flex: 1,
                            child: Padding(
                              padding:
                                  const EdgeInsets.only(bottom: defaultPadding),
                              child: Container(
                                decoration: BoxDecoration(
                                  color: primaryColor,
                                  borderRadius:
                                      BorderRadius.circular(defaultPadding),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(defaultPadding),
                                  child: Text(
                                    adReportExcel[index]['impression'],
                                    style: const TextStyle(color: Colors.white),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(
                            width: defaultPadding / 2,
                          ),
                          Expanded(
                            flex: 1,
                            child: Padding(
                              padding:
                                  const EdgeInsets.only(bottom: defaultPadding),
                              child: Container(
                                decoration: BoxDecoration(
                                  color: primaryColor,
                                  borderRadius:
                                      BorderRadius.circular(defaultPadding),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(defaultPadding),
                                  child: Text(
                                    adReportExcel[index]['clicks'],
                                    style: const TextStyle(color: Colors.white),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(
                            width: defaultPadding / 2,
                          ),
                          Expanded(
                            flex: 1,
                            child: Padding(
                              padding:
                                  const EdgeInsets.only(bottom: defaultPadding),
                              child: Container(
                                decoration: BoxDecoration(
                                  color: primaryColor,
                                  borderRadius:
                                      BorderRadius.circular(defaultPadding),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(defaultPadding),
                                  child: Text(
                                    adReportExcel[index]['adExpenses'],
                                    style: const TextStyle(color: Colors.white),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(
                            width: defaultPadding / 2,
                          ),
                          Expanded(
                            flex: 1,
                            child: Padding(
                              padding:
                                  const EdgeInsets.only(bottom: defaultPadding),
                              child: Container(
                                decoration: BoxDecoration(
                                  color: primaryColor,
                                  borderRadius:
                                      BorderRadius.circular(defaultPadding),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(defaultPadding),
                                  child: Text(
                                    adReportExcel[index]['ctr'],
                                    style: const TextStyle(color: Colors.white),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(
                            width: defaultPadding / 2,
                          ),
                          Expanded(
                            flex: 1,
                            child: Padding(
                              padding:
                                  const EdgeInsets.only(bottom: defaultPadding),
                              child: Container(
                                decoration: BoxDecoration(
                                  color: primaryColor,
                                  borderRadius:
                                      BorderRadius.circular(defaultPadding),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(defaultPadding),
                                  child: Text(
                                    adReportExcel[index]['cpc'],
                                    style: const TextStyle(color: Colors.white),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(
                            width: defaultPadding / 2,
                          ),
                          Expanded(
                            flex: 1,
                            child: Padding(
                              padding:
                                  const EdgeInsets.only(bottom: defaultPadding),
                              child: Container(
                                decoration: BoxDecoration(
                                  color: primaryColor,
                                  borderRadius:
                                      BorderRadius.circular(defaultPadding),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(defaultPadding),
                                  child: Text(
                                    adReportExcel[index]['cpa'],
                                    style: const TextStyle(color: Colors.white),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(
                            width: defaultPadding / 2,
                          ),
                          Expanded(
                            flex: 1,
                            child: Padding(
                              padding:
                                  const EdgeInsets.only(bottom: defaultPadding),
                              child: Container(
                                decoration: BoxDecoration(
                                  color: primaryColor,
                                  borderRadius:
                                      BorderRadius.circular(defaultPadding),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(defaultPadding),
                                  child: Text(
                                    adReportExcel[index]['roas'],
                                    style: const TextStyle(color: Colors.white),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(
                            width: defaultPadding / 2,
                          ),
                          Expanded(
                            flex: 1,
                            child: Padding(
                              padding:
                                  const EdgeInsets.only(bottom: defaultPadding),
                              child: Container(
                                decoration: BoxDecoration(
                                  color: primaryColor,
                                  borderRadius:
                                      BorderRadius.circular(defaultPadding),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(defaultPadding),
                                  child: Text(
                                    adReportExcel[index]['totalOrders'],
                                    style: const TextStyle(color: Colors.white),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(
                            width: defaultPadding / 2,
                          ),
                          Expanded(
                            flex: 1,
                            child: Padding(
                              padding:
                                  const EdgeInsets.only(bottom: defaultPadding),
                              child: Container(
                                decoration: BoxDecoration(
                                  color: primaryColor,
                                  borderRadius:
                                      BorderRadius.circular(defaultPadding),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(defaultPadding),
                                  child: Text(
                                    adReportExcel[index]['totalRevenue'],
                                    style: const TextStyle(color: Colors.white),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
