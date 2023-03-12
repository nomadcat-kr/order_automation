part of 'launch_bloc.dart';

enum LaunchEventType {
  pure,
  started,
  clicked,
  textEditing,
  refreshed,
  orderListUploadClicked,
  orderListDownloadClicked,
  invoiceListUploadClicked,
  invoiceListPutRequestClicked,
  settlementHistoryGetClicked,
  keyTextFieldClicked,
  rocketGrowthCenterClicked,
  rocketGrowthBoxEditing,
  rocketGrowthExcelClicked,
  distributionCenterClicked,
  adReportClicked,
  adReportOrderClicked,
}

extension LaunchEventTypeX on LaunchEventType {
  bool get isStarted => this == LaunchEventType.started;

  bool get isClicked => this == LaunchEventType.clicked;

  bool get isTextEditing => this == LaunchEventType.textEditing;

  bool get isRefreshed => this == LaunchEventType.refreshed;

  bool get isOrderListUploadClicked =>
      this == LaunchEventType.orderListUploadClicked;

  bool get isOrderListDownloadClicked =>
      this == LaunchEventType.orderListDownloadClicked;

  bool get isInvoiceListUploadClicked =>
      this == LaunchEventType.invoiceListUploadClicked;

  bool get isInvoiceListPutRequestClicked =>
      this == LaunchEventType.invoiceListPutRequestClicked;

  bool get isSettlementHistoryGetClicked =>
      this == LaunchEventType.settlementHistoryGetClicked;

  bool get isKeyTextFieldClicked => this == LaunchEventType.keyTextFieldClicked;

  bool get isRocketGrowthCenterClicked =>
      this == LaunchEventType.rocketGrowthCenterClicked;

  bool get isRocketGrowthBoxEditing =>
      this == LaunchEventType.rocketGrowthBoxEditing;

  bool get isRocketGrowthExcelClicked => this == LaunchEventType.rocketGrowthExcelClicked;

  bool get isDistributionCenterClicked => this == LaunchEventType.distributionCenterClicked;

  bool get isAdReportClicked => this == LaunchEventType.adReportClicked;

  bool get isAdReportOrderClicked => this == LaunchEventType.adReportOrderClicked;
}
