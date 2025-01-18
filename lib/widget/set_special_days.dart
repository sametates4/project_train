import 'dart:core';

import 'package:flutter/material.dart';
import 'package:project_train/widget/set_date.dart';
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

  List<String> radioList = ["Hafta Tatili", "Yıllık & Sendika İzni", "Rapor & Eğitim", "İhtiyat"];

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 300,
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(20)),
      child: Column(
        children: [
          SheetDivider.showDivider(),
          Expanded(
            child: ListView.builder(
              itemCount: radioList.length,
              itemBuilder: (context, index) {
                return RadioListTile<int>(
                  title: Text(radioList[index]),
                  value: index,
                  groupValue: selectedRadio,
                  onChanged: (value) {
                    setState(() {
                      selectedRadio = value;
                    });
                  },
                );
              },
            ),
          ),
          ElevatedButton(
            onPressed: selectedRadio != 9
                ? () {
                    final working = WorkModel(
                      id: context.read<AppState>().work!.length + 1,
                      machinist: 'Hafta Tatili',
                      trainNumber: 99991,
                      trainNumberTwo: 88888,
                      startTime: setTime(widget.details.date!, 0),
                      endTime: setTime(widget.details.date!, 0),
                    );

                    if(selectedRadio == 0) {
                      context.read<AppState>().addWorkData(items: working);
                      context.router.popForced();
                    }
                    if(selectedRadio == 1) {
                      context.router.popForced();
                      AppFunction.showMainSheet(
                          context: context,
                          child: SetDate(
                            dateTime: widget.details.date!,
                            title: radioList[1],
                          ));
                    }
                    if(selectedRadio == 2) {
                      context.router.popForced();
                      AppFunction.showMainSheet(
                          context: context,
                          child: SetDate(
                            dateTime: widget.details.date!,
                            title: radioList[2],
                          ));
                    }
                    if(selectedRadio == 3) {
                      context.router.popForced();
                      AppFunction.showMainSheet(
                          context: context,
                          child: SetTime(dateTime: widget.details.date!));
                    }
                  }
                : null,
            child: selectedRadio != 0
                ? const Text('Devam Et')
                : const Text('Kayıt Et'),
          )
        ],
      ),
    );
  }
}