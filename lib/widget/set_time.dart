import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../core/function/app_function.dart';
import '../core/model/work_model.dart';
import '../core/state/app_state.dart';
import '../sheet/time_sheet.dart';
import 'sheet_divider.dart';

class SetTime extends StatefulWidget {
  const SetTime({super.key});

  @override
  State<SetTime> createState() => _SetTimeState();
}

class _SetTimeState extends State<SetTime> {
  DateTime? startWorkTime;
  Duration workDuration = Duration.zero;
  String startTime = "Tarih Şecilmedi";
  String workTime = "Süre Şecilmedi";

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 200,
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(20)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [

          SheetDivider.showDivider(),

          Row(
            children: [
              const SizedBox(width: 10),
              Text('Görev Alma Saati: '),
              Text(startTime),
              const Spacer(),
              IconButton(
                icon: const Icon(Icons.date_range_outlined),
                onPressed: () {
                  AppFunction.showMainSheet(
                      context: context,
                      child: TimeSheet(
                        dateTime: DateTime.now(),
                        start: true,
                        onDateTimeChanged: (date) {
                          setState(() {
                            startWorkTime = date;
                            startTime = AppFunction.dateTimeFormat(date);
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
              Text('İhtiyat Süresi: '),
              Text(workTime),
              const Spacer(),
              IconButton(
                icon: const Icon(Icons.date_range_outlined),
                onPressed: () {
                  AppFunction.showMainSheet(
                      context: context,
                      child: Container(
                        height: 250,
                        width: double.infinity,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: Colors.white
                        ),
                        child: CupertinoTimerPicker(
                          onTimerDurationChanged: (value) {
                            setState(() {
                              workDuration = value;
                              workTime = AppFunction.timeFormat(value);
                            });
                          },
                          mode: CupertinoTimerPickerMode.hm,
                        ),
                      )
                  );
                },
              )
            ],
          ),

          Spacer(),

          ElevatedButton(
            child: Text('Kayıt Et'),
            onPressed: () {
              final working = WorkModel(
                id: context.read<AppState>().work!.length+1,
                machinist: 'Samet ATEŞ - İhtiyat',
                trainNumber: 99993,
                trainNumberTwo: 99999,
                startTime: startWorkTime!,
                endTime: startWorkTime!.add(workDuration),
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