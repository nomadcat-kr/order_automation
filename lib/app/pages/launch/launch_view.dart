import 'package:formz/formz.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:order_automation/app/common/widgets/platform.dart';
import 'package:order_automation/app/pages/launch/launch.dart';
import 'package:order_automation/domain/blocs/launch/launch_bloc.dart';

class LaunchView extends StatelessWidget {
  const LaunchView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LaunchBloc, LaunchState>(
      listener: (context, state) {
        if (state.eventType.isOrderListUploadClicked &&
            state.status.isSubmissionSuccess) {
          BlocProvider.of<LaunchBloc>(context).add(
            LaunchEventStarted(),
          );
        }
        if (state.eventType.isInvoiceListPutRequestClicked &&
            state.status.isSubmissionSuccess) {
          BlocProvider.of<LaunchBloc>(context).add(
            LaunchEventStarted(),
          );
        }
        if (state.eventType.isRefreshed && state.status.isSubmissionSuccess) {
          BlocProvider.of<LaunchBloc>(context).add(
            LaunchEventStarted(),
          );
        }
      },
      builder: (context, state) {
        return Scaffold(
          resizeToAvoidBottomInset: false,
          body: SafeArea(
            child: PlatformCheck.isApp(context)
                ? LaunchViewApp(
                    keys: state.keys ?? [],
                    statusAccept: state.statusAccept ?? [],
                    statusInstruct: state.statusInstruct ?? [],
                    statusDeparture: state.statusDeparture ?? [],
                    statusDelivering: state.statusDelivering ?? [],
                    statusFinalDelivery: state.statusFinalDelivery ?? [],
                    consumerService: state.consumerService ?? [],
                    callCenterInquiries: state.callCenterInquiries ?? [],
                    revenueHistory: state.revenueHistory ?? {},
                    isKeyTextFieldClicked: state.keyTextFieldClicked,
                    isLoadingFinished: state.status.isSubmissionSuccess,
                  )
                : LaunchViewWeb(
                    keys: state.keys ?? [],
                    isKeyTextFieldClicked: state.keyTextFieldClicked,
                    isLoadingFinished: state.status.isSubmissionSuccess,
                  ),
          ),
        );
      },
    );
  }
}
