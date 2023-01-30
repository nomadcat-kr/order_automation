part of 'user_bloc.dart';

@immutable
abstract class UserEvent extends Equatable{
  const UserEvent();

  @override
  List<Object?> get props => [



  ];
}


class UserEventStarted extends UserEvent{}

class UserEventClicked extends UserEvent{}

class UserEventLongPressed extends UserEvent{}