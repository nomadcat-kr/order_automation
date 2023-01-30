import 'package:flutter/material.dart';
import 'package:order_automation/app/common/common.dart';
import 'package:order_automation/app/pages/launch/launch.dart';


class RecentFiles extends StatelessWidget {
  const RecentFiles({
    Key? key,  this.result,
  }) : super(key: key);

  final List<dynamic>? result;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(defaultPadding),
      decoration: const BoxDecoration(
        color: secondaryColor,
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Recent Files",
            style: Theme
                .of(context)
                .textTheme
                .subtitle1,
          ),
          const SizedBox(
            width: double.infinity,
            height: 20,
          ),
          if(result != null)
            Results(result: result!),
        ],
      ),
    );
  }
}


