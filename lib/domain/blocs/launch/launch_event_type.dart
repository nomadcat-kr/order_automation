part of 'launch_bloc.dart';

enum LaunchEventType {
  pure,
  started,
  clicked,
  textEditing,
  refreshed,
  orderListPrintClicked,
  textFieldClicked,
  keyTextFieldClicked,
}

extension LaunchEventTypeX on LaunchEventType{
  bool get isStarted =>this == LaunchEventType.started;

  bool get isClicked =>this == LaunchEventType.clicked;

  bool get isTextEditing =>this == LaunchEventType.textEditing;

  bool get isRefreshed =>this == LaunchEventType.refreshed;

  bool get isOrderListPrintClicked =>this == LaunchEventType.orderListPrintClicked;

  bool get isTextFieldClicked =>this == LaunchEventType.textFieldClicked;

  bool get isKeyTextFieldClicked =>this == LaunchEventType.keyTextFieldClicked;

}
