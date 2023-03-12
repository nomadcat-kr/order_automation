part of 'launch_bloc.dart';

@immutable
class LaunchState extends Equatable {
  const LaunchState({
    this.status = FormzStatus.pure,
    this.eventType = LaunchEventType.pure,
    this.keys,
    this.statusAccept,
    this.statusInstruct,
    this.statusDeparture,
    this.statusDelivering,
    this.statusFinalDelivery,
    this.consumerService,
    this.callCenterInquiries,
    this.revenueHistory,
    this.keyTextFieldClicked = false,
    this.loadingFinished = false,
    this.onStartedProgress = 0.0,
    this.rocketGrowthCenter = '',
    this.rocketGrowthBox = '',
    this.distributionCenterClicked = false,
    this.adReportExcel,
    this.adReportExcelTotal,
    this.adReportOrderKeyWordClicked = false,
    this.adReportOrderImpressionClicked = false,
    this.adReportOrderClicksClicked = false,
    this.adReportOrderAdExpensesClicked = false,
    this.adReportOrderTotalOrdersClicked = false,
    this.adReportOrderTotalRevenueClicked = false,
    this.adReportOrderCtrClicked = false,
    this.adReportOrderCpcClicked = false,
    this.adReportOrderCpaClicked = false,
    this.adReportOrderRoasClicked = false,
    this.adReportExcelFileName = '',
  });

  final FormzStatus status;
  final LaunchEventType eventType;
  final List<String>? keys;
  final List<dynamic>? statusAccept;
  final List<dynamic>? statusInstruct;
  final List<dynamic>? statusDeparture;
  final List<dynamic>? statusDelivering;
  final List<dynamic>? statusFinalDelivery;
  final List<dynamic>? consumerService;
  final List<dynamic>? callCenterInquiries;
  final Map<dynamic, dynamic>? revenueHistory;
  final bool keyTextFieldClicked;
  final bool loadingFinished;
  final double onStartedProgress;
  final String rocketGrowthCenter;
  final String rocketGrowthBox;
  final bool distributionCenterClicked;
  final List<dynamic>? adReportExcel;
  final Map<dynamic, dynamic>? adReportExcelTotal;
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
  List<Object?> get props => [
        status,
        eventType,
        keys,
        statusAccept,
        statusInstruct,
        statusDeparture,
        statusDelivering,
        statusFinalDelivery,
        consumerService,
        callCenterInquiries,
        revenueHistory,
        keyTextFieldClicked,
        loadingFinished,
        onStartedProgress,
        rocketGrowthCenter,
        rocketGrowthBox,
        distributionCenterClicked,
        adReportExcel,
        adReportExcelTotal,
        adReportOrderKeyWordClicked,
        adReportOrderImpressionClicked,
        adReportOrderClicksClicked,
        adReportOrderAdExpensesClicked,
        adReportOrderTotalOrdersClicked,
        adReportOrderTotalRevenueClicked,
        adReportOrderCtrClicked,
        adReportOrderCpcClicked,
        adReportOrderCpaClicked,
        adReportOrderRoasClicked,
        adReportExcelFileName,
      ];

  LaunchState copyWith({
    FormzStatus? status,
    LaunchEventType? eventType,
    List<String>? keys,
    List<dynamic>? statusAccept,
    List<dynamic>? statusInstruct,
    List<dynamic>? statusDeparture,
    List<dynamic>? statusDelivering,
    List<dynamic>? statusFinalDelivery,
    List<dynamic>? consumerService,
    List<dynamic>? callCenterInquiries,
    Map<dynamic, dynamic>? revenueHistory,
    bool? keyTextFieldClicked,
    bool? loadingFinished,
    double? onStartedProgress,
    String? rocketGrowthCenter,
    String? rocketGrowthBox,
    bool? distributionCenterClicked,
    List<dynamic>? adReportExcel,
    Map<dynamic, dynamic>? adReportExcelTotal,
    bool? adReportOrderKeyWordClicked,
    bool? adReportOrderImpressionClicked,
    bool? adReportOrderClicksClicked,
    bool? adReportOrderAdExpensesClicked,
    bool? adReportOrderTotalOrdersClicked,
    bool? adReportOrderTotalRevenueClicked,
    bool? adReportOrderCtrClicked,
    bool? adReportOrderCpcClicked,
    bool? adReportOrderCpaClicked,
    bool? adReportOrderRoasClicked,
    String? adReportExcelFileName,
  }) {
    return LaunchState(
      status: status ?? this.status,
      eventType: eventType ?? this.eventType,
      keys: keys ?? this.keys,
      statusAccept: statusAccept ?? this.statusAccept,
      statusInstruct: statusInstruct ?? this.statusInstruct,
      statusDeparture: statusDeparture ?? this.statusDeparture,
      statusDelivering: statusDelivering ?? this.statusDelivering,
      statusFinalDelivery: statusFinalDelivery ?? this.statusFinalDelivery,
      consumerService: consumerService ?? this.consumerService,
      callCenterInquiries: callCenterInquiries ?? this.callCenterInquiries,
      revenueHistory: revenueHistory ?? this.revenueHistory,
      keyTextFieldClicked: keyTextFieldClicked ?? this.keyTextFieldClicked,
      loadingFinished: loadingFinished ?? this.loadingFinished,
      onStartedProgress: onStartedProgress ?? this.onStartedProgress,
      rocketGrowthCenter: rocketGrowthCenter ?? this.rocketGrowthCenter,
      rocketGrowthBox: rocketGrowthBox ?? this.rocketGrowthBox,
      distributionCenterClicked:
          distributionCenterClicked ?? this.distributionCenterClicked,
      adReportExcel: adReportExcel ?? this.adReportExcel,
      adReportExcelTotal: adReportExcelTotal ?? this.adReportExcelTotal,
      adReportOrderKeyWordClicked:
          adReportOrderKeyWordClicked ?? this.adReportOrderKeyWordClicked,
      adReportOrderImpressionClicked:
          adReportOrderImpressionClicked ?? this.adReportOrderImpressionClicked,
      adReportOrderClicksClicked:
          adReportOrderClicksClicked ?? this.adReportOrderClicksClicked,
      adReportOrderAdExpensesClicked:
          adReportOrderAdExpensesClicked ?? this.adReportOrderAdExpensesClicked,
      adReportOrderTotalOrdersClicked: adReportOrderTotalOrdersClicked ??
          this.adReportOrderTotalOrdersClicked,
      adReportOrderTotalRevenueClicked: adReportOrderTotalRevenueClicked ??
          this.adReportOrderTotalRevenueClicked,
      adReportOrderCtrClicked:
          adReportOrderCtrClicked ?? this.adReportOrderCtrClicked,
      adReportOrderCpcClicked:
          adReportOrderCpcClicked ?? this.adReportOrderCpcClicked,
      adReportOrderCpaClicked:
          adReportOrderCpaClicked ?? this.adReportOrderCpaClicked,
      adReportOrderRoasClicked:
          adReportOrderRoasClicked ?? this.adReportOrderRoasClicked,
      adReportExcelFileName:
          adReportExcelFileName ?? this.adReportExcelFileName,
    );
  }
}

class LaunchInitial extends LaunchState {}
