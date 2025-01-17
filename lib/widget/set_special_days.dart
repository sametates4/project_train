import 'dart:core';

import 'package:flutter/material.dart';
import 'package:project_train/widget/set_time.dart';
import 'package:project_train/widget/sheet_divider.dart';
import 'package:auto_route/auto_route.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

import '../core/function/app_function.dart';
import '../core/model/work_model.dart';
import '../core/state/app_state.dart';

class SetSpecialDays extends StatefulWidget {
  const SetSpecialDays({super.key, required this.details});

  final CalendarLongPressDetails details;

  @override
  State<SetSpecialDays> createState() => _SetSpecialDaysState();
}

class _SetSpecialDaysState extends State<SetSpecialDays> {
  int? selectedRadio = 9;

  DateTime setTime(DateTime time, int minute) {
    return DateTime(time.year, time.month, time.day, 00, minute);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 250,
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(20)),
      child: Column(
        children: [
          SheetDivider.showDivider(),
          RadioListTile<int>(
            title: const Text('Hafta Tatili'),
            value: 0,
            groupValue: selectedRadio,
            onChanged: (value) {
              setState(() {
                selectedRadio = value;
              });
            },
          ),
          RadioListTile<int>(
            title: const Text('Yıllık İzin'),
            value: 1,
            groupValue: selectedRadio,
            onChanged: (value) {
              setState(() {
                selectedRadio = value;
              });
            },
          ),
          RadioListTile<int>(
            title: const Text('İhtiyat'),
            value: 2,
            groupValue: selectedRadio,
            onChanged: (value) {
              setState(() {
                selectedRadio = value;
              });
            },
          ),
          ElevatedButton(
            onPressed: selectedRadio != 4
                ? () {
                    final working = WorkModel(
                      id: context.read<AppState>().work!.length + 1,
                      machinist: selectedRadio == 0
                          ? 'Hafta Tatili'
                          : selectedRadio == 1
                              ? 'Yıllık İzin'
                              : '',
                      trainNumber: selectedRadio == 0
                          ? 99991
                          : selectedRadio == 1
                              ? 99992
                              : 99993,
                      trainNumberTwo: 88888,
                      startTime: setTime(widget.details.date!, 0),
                      endTime: setTime(widget.details.date!, 0),
                    );
                    selectedRadio == 2
                        ? {
                            context.router.popForced(),
                            AppFunction.showMainSheet(
                                context: context, child: const SetTime())
                          }
                        : {
                            context
                                .read<AppState>()
                                .addWorkData(items: working),
                            context.router.popForced()
                          };
                  }
                : null,
            child: selectedRadio == 2
                ? const Text('Devam Et')
                : const Text('Kayıt Et'),
          )
        ],
      ),
    );
  }
}
