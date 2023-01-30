part of 'user_bloc.dart';

enum UserEventType {
  pure,
  started,
  clicked,
  longPressed,
}

extension UserEventTypeX on UserEventType{
  bool get isStarted =>this == UserEventType.started;

  bool get isClicked =>this == UserEventType.clicked;

  bool get isLongPressed =>this == UserEventType.longPressed;
}
