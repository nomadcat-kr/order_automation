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
    );
  }
}

class LaunchInitial extends LaunchState {}
