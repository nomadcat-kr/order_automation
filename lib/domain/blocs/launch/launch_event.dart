part of 'launch_bloc.dart';

@immutable
abstract class LaunchEvent extends Equatable {
  const LaunchEvent();

  @override
  List<Object?> get props => [];
}

class LaunchEventStarted extends LaunchEvent {}

class LaunchEventClicked extends LaunchEvent {}

class LaunchEventTextEditing extends LaunchEvent {
  const LaunchEventTextEditing({required String inputText});

  final String inputText = '';

  @override
  List<Object?> get props => [inputText];
}

class LaunchEventRefreshed extends LaunchEvent {}

class LaunchEventOrderListUploadClicked extends LaunchEvent {}

class LaunchEventOrderListDownloadClicked extends LaunchEvent {}

class LaunchEventInvoiceListUploadClicked extends LaunchEvent {}

class LaunchEventInvoiceListPutRequestClicked extends LaunchEvent {}

class LaunchEventSettlementHistoryGetClicked extends LaunchEvent {}

class LaunchEventKeyTextFieldClicked extends LaunchEvent {}

class LaunchEventRocketGrowthCenterClicked extends LaunchEvent {
  const LaunchEventRocketGrowthCenterClicked(
      {required this.rocketGrowthCenter});

  final String rocketGrowthCenter;

  @override
  List<Object?> get props => [rocketGrowthCenter];
}

class LaunchEventRocketGrowthBoxEditing extends LaunchEvent {
  const LaunchEventRocketGrowthBoxEditing({required this.rocketGrowthBox});

  final String rocketGrowthBox;

  @override
  List<Object?> get props => [rocketGrowthBox];
}

class LaunchEventRocketGrowthExcelClicked extends LaunchEvent {}

class LaunchEventDistributionCenterClicked extends LaunchEvent {}

class LaunchEventAdReportClicked extends LaunchEvent {}

class LaunchEventAdReportOrderClicked extends LaunchEvent {
  const LaunchEventAdReportOrderClicked({required this.orderCriteria});

  final String orderCriteria;

  @override
  List<Object?> get props => [orderCriteria];
}