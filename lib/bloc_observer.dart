import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';

class BlocJsonObserver extends BlocObserver {
  @override
  void onChange(BlocBase<dynamic> bloc, Change<dynamic> change) {
    super.onChange(bloc, change);
    // debugPrint('${bloc.runtimeType} $change');
  }
}