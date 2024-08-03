import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:project_train/core/function/app_function.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

import '../model/work_model.dart';

final class WorkDataManager extends CalendarDataSource {

  WorkDataManager(List<WorkModel> source) {
    appointments = source;
  }

  final time1 = DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day+1, 00, 00);

  @override
  DateTime getStartTime(int index) {
    return _getWorkingData(index).startTime;
  }

  @override
  DateTime getEndTime(int index) {
    if(_getWorkingData(index).endTime != null) {
      return _getWorkingData(index).endTime!;
    } else {
      return DateTime.now();
    }
  }

  @override
  String getSubject(int index) {
    return _getWorkingData(index).machinist;
  }

  @override
  Color getColor(int index) {
    return AppFunction.randomColor();
  }

  @override
  bool isAllDay(int index) {
    return _getWorkingData(index).offDay ?? false;
  }

  WorkModel _getWorkingData(int index) {
    final dynamic working = appointments![index];
    late final WorkModel workingData;
    if (working is WorkModel) {
      workingData = working;
    }
    return workingData;
  }
}
