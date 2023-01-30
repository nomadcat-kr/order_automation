part of 'user_bloc.dart';

@immutable
class UserState extends Equatable {
  const UserState({
    this.status = FormzStatus.pure,
    this.eventType = UserEventType.pure,
    this.counts = 0,
});

  final FormzStatus status;
  final UserEventType eventType;
  final int counts;

  @override
  List<Object?> get props => [
    status,
    eventType,
    counts,
  ];

  UserState copyWith({
  FormzStatus? status,
    UserEventType? eventType,
    int? counts,
}) {
    return UserState(
      status: status ?? this.status,
      eventType: eventType ?? this.eventType,
      counts: counts ?? this.counts,
    );
  }

}

class UserInitial extends UserState {}