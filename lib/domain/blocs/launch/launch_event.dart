part of 'launch_bloc.dart';

@immutable
abstract class LaunchEvent extends Equatable{
  const LaunchEvent();

  @override
  List<Object?> get props => [



  ];
}


class LaunchEventStarted extends LaunchEvent{}

class LaunchEventClicked extends LaunchEvent{}

class LaunchEventTextEditing extends LaunchEvent{}

class LaunchEventRefreshed extends LaunchEvent{}

class LaunchEventOrderListPrintClicked extends LaunchEvent{}

class LaunchEventTextFieldClicked extends LaunchEvent{}

class LaunchEventKeyTextFieldClicked extends LaunchEvent{}