part of 'launch_bloc.dart';

@immutable
class LaunchState extends Equatable {
  const LaunchState({
    this.status = FormzStatus.pure,
    this.eventType = LaunchEventType.pure,
    this.counts = 0,
    this.keyType = '',
    this.keys,
    this.getData,
    this.keyTextFieldClicked = false,
    this.code = '',
  });

  final FormzStatus status;
  final LaunchEventType eventType;
  final int counts;
  final String keyType;
  final List<String>? keys;
  final List<dynamic>? getData;
  final bool keyTextFieldClicked;
  final String code;

  @override
  List<Object?> get props => [
        status,
        eventType,
        counts,
        keyType,
        keys,
        getData,
        keyTextFieldClicked,
        code,
      ];

  LaunchState copyWith({
    FormzStatus? status,
    LaunchEventType? eventType,
    int? counts,
    String? keyType,
    List<String>? keys,
    List<dynamic>? getData,
    bool? keyTextFieldClicked,
    String? code,
  }) {
    return LaunchState(
      status: status ?? this.status,
      eventType: eventType ?? this.eventType,
      counts: counts ?? this.counts,
      keyType: keyType ?? this.keyType,
      keys: keys ?? this.keys,
      getData: getData ?? this.getData,
      keyTextFieldClicked: keyTextFieldClicked ?? this.keyTextFieldClicked,
      code: code ?? this.code,
    );
  }
}

class LaunchInitial extends LaunchState {}
