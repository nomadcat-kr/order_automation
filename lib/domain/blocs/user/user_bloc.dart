import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';
import 'package:meta/meta.dart';
import 'package:order_automation/data/repositories/order_list_print_repository.dart';

part 'user_event.dart';

part 'user_state.dart';

part 'user_event_type.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  UserBloc() : super(UserInitial()) {
    on<UserEventStarted>(_onStarted);
    on<UserEventClicked>(_onClicked);
  }


  void _onStarted(
    UserEventStarted event,
    Emitter<UserState> emit,
  ) async {
    emit(state.copyWith(
      eventType: UserEventType.started,
      status: FormzStatus.submissionInProgress,
    ));


    emit(state.copyWith(
      eventType: UserEventType.started,
      status: FormzStatus.submissionSuccess,
    ));
  }

  void _onClicked(
    UserEventClicked event,
    Emitter<UserState> emit,
  ) async {
    emit(state.copyWith(
      eventType: UserEventType.clicked,
      status: FormzStatus.submissionInProgress,
    ));



    emit(state.copyWith(
      eventType: UserEventType.clicked,
      status: FormzStatus.submissionSuccess,
    ));
  }
}
