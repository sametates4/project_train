import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:project_train/core/state/app_state.dart';
import 'package:provider/provider.dart';

class TimeSheet extends StatelessWidget {
  const TimeSheet({super.key, required this.start, required this.onDateTimeChanged});

  final bool start;
  final Function(DateTime) onDateTimeChanged;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 250,
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Colors.white
      ),
      child: CupertinoDatePicker(
        dateOrder: DatePickerDateOrder.dmy,
        backgroundColor: Colors.white,
        onDateTimeChanged: (time) {
          onDateTimeChanged(time);
          if(start) {
            context.read<AppState>().setStartTime(time);
          } else {
            context.read<AppState>().setFinishTime(time);
          }
        },
        mode: CupertinoDatePickerMode.dateAndTime,
        use24hFormat: true,
      ),
    );
  }
}
