import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:project_train/widget/sheet_divider.dart';
import 'package:provider/provider.dart';

import '../core/function/app_function.dart';
import '../core/model/work_model.dart';
import '../core/state/app_state.dart';
import '../sheet/time_sheet.dart';

class SetDate extends StatefulWidget {
  const SetDate({super.key, required this.title, required this.dateTime});

  final String title;
  final DateTime dateTime;

  @override
  State<SetDate> createState() => _SetDateState();
}

class _SetDateState extends State<SetDate> {

  DateTime? startDate;
  DateTime? endDate;

  String startText = "";
  String endText = "";


  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 200,
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(20)),
      child: Column(
        children: [

          SheetDivider.showDivider(),

          Row(
            children: [
              const SizedBox(width: 10),
              Text('${widget.title} başlama tarihi: '),
              Text(startText),
              const Spacer(),
              IconButton(
                icon: const Icon(Icons.date_range_outlined),
                onPressed: () {
                  AppFunction.showMainSheet(
                      context: context,
                      child: TimeSheet(
                        dateTime: widget.dateTime,
                        start: true,
                        onDateTimeChanged: (date) {
                          setState(() {
                            startDate = date;
                            startText = AppFunction.dateTimeFormat(date);
                          });
                        },
                      )
                  );
                },
              )
            ],
          ),

          Row(
            children: [
              const SizedBox(width: 10),
              Text('${widget.title} bitiş tarihi: '),
              Text(endText),
              const Spacer(),
              IconButton(
                icon: const Icon(Icons.date_range_outlined),
                onPressed: () {
                  AppFunction.showMainSheet(
                      context: context,
                      child: TimeSheet(
                        dateTime: widget.dateTime,
                        start: true,
                        onDateTimeChanged: (date) {
                          setState(() {
                            endDate = date;
                            endText = AppFunction.dateTimeFormat(date);
                          });
                        },
                      )
                  );
                },
              )
            ],
          ),

          const Spacer(),

          ElevatedButton(
            child: Text('Kayıt Et'),
            onPressed: () {
              final working = WorkModel(
                id: context.read<AppState>().work!.length+1,
                machinist: widget.title,
                trainNumber: 99993,
                trainNumberTwo: 88888,
                startTime: startDate!,
                endTime: endDate,
              );
              context.read<AppState>().addWorkData(items: working);
              context.router.popForced();
            },
          ),

          const SizedBox(height: 10),

        ],
      ),
    );
  }
}
