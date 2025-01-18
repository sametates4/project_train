import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:project_train/core/function/app_function.dart';
import 'package:project_train/core/function/hour_function.dart';
import 'package:project_train/core/model/settings_model.dart';
import 'package:project_train/core/service/setting_service.dart';
import '../manager/work_manager.dart';
import '../model/user_model.dart';
import '../model/work_model.dart';
import '../service/network_service.dart';
import '../service/user_service.dart';

final class AppState extends ChangeNotifier{

  static final HiveCacheManager<WorkModel> _workService = WorkManager('box');
  NetworkService service = NetworkService(Dio(BaseOptions(baseUrl: 'https://api.sametates.dev')));

  UserModel? user = UserService.instance.currentUser;

  SettingsModel? setting = SettingService.instance.service;

  List<WorkModel>? work;
  Set<DateTime> reportDays = {
    DateTime(2025, 01, 01),
    DateTime(2025, 04, 23),
    DateTime(2025, 05, 01),
    DateTime(2025, 05, 19),
    DateTime(2025, 07, 15),
    DateTime(2025, 08, 30),
    DateTime(2025, 10, 29),
  };
  bool loading = false;
  List<String> nameList = ['Samet ATEŞ'];

  DateTime? startTime;
  DateTime? endTime;
  String nightWorking = "Hesaplanıyor...";
  String nightWorkAdd = "Hesaplanıyor...";

  Duration monthlyWorkTime = Duration.zero;
  String monthlyWorkTimeString = '';


  Future<void> ensureInit() async {
    await _workService.init();
    work = _workService.getValues();
    loading = true;
    notifyListeners();
    getMonthlyWork(month: DateTime.now().month);
    if(user!.kky == 11006644) {
      setNameList();
    }
  }

  Future<void> addWorkData({required WorkModel items}) async {
    _workService.addItems(items);
    clear();
    work = getWorkData();
    notifyListeners();
    reCalculateMonthlyWork(month: DateTime.now().month);
    timeClear();
  }

  void setNameList() {
    for(var i in work!) {
      final res = i.machinist?.split(' - ');
      nameList.add(res![0]);
      if(i.trainNumberTwo == 88888) {
        final res = generateDateRange(i.startTime, i.endTime!);
        reportDays.addAll(res);
      }
      try {
        nameList.add(res[1]);
      } catch (e) {}
    }
    notifyListeners();
  }

  void clear() => work?.clear();

  List<WorkModel>? getWorkData() => _workService.getValues();

  void setStartTime(DateTime time) {
    startTime = time;
  }

  void setFinishTime(DateTime? time) {
    endTime = time;
  }

  void sStartTime(DateTime time) {
    startTime = time;
    notifyListeners();
  }

  void finishTime(DateTime? time) {
    endTime = time;
    notifyListeners();
  }


  void deleteWorkData({required int index, required int month}) {
    int itemIndex = work!.indexWhere((element) => element.id == index);
    _workService.deleteItem(itemIndex);
    clear();
    work = getWorkData();
    notifyListeners();
    reCalculateMonthlyWork(month: month);
    timeClear();
  }

  void updateWorkData({required int index, required WorkModel item, required int month}) {
    int itemIndex = work!.indexWhere((element) => element.id == index);
    _workService.putAtItem(itemIndex, item);
    clear();
    work = getWorkData();
    notifyListeners();
    reCalculateMonthlyWork(month: month);
    timeClear();
  }

  void reCalculateMonthlyWork({required int month}) {
    monthlyWorkTime = Duration.zero;
    notifyListeners();
    getMonthlyWork(month: month);
  }

  String findMatchingHint(String input) {
    // Listeyi kontrol edip eşleşen ismi bulalım
    for (String name in nameList) {
      if (name.toLowerCase().startsWith(input.toLowerCase())) {
        return name.substring(input.length); // Eşleşmeyen kısmı döndür
      }
    }
    return ""; // Eşleşme yoksa boş döndür
  }



  void getMonthlyWork({required int month}) {
    Duration time = const Duration(hours: 0, minutes: 0);
    for (WorkModel i in work ?? []) {

      if(i.trainNumberTwo != 88888) {

        DateTime endTime = i.endTime ?? DateTime.now();
        if (i.startTime.month != endTime.month) {
          DateTime endOfStartMonth = DateTime(i.startTime.year, i.startTime.month + 1, 1)
              .subtract(const Duration(seconds: 1));
          if (i.startTime.month == month) {
            time += endOfStartMonth.difference(i.startTime) + const Duration(seconds: 1);
          }
          DateTime startOfEndMonth = DateTime(endTime.year, endTime.month, 1);
          if (endTime.month == month) {
            time += endTime.difference(startOfEndMonth);
          }
        } else if (i.startTime.month == month) {
          time += endTime.difference(i.startTime);
        }

      }
    }

    monthlyWorkTime = time;
    monthlyWorkTimeString = AppFunction.timeFormat(time);
    notifyListeners();
  }



  void monthlyReport() {
    Duration nightWork = Duration.zero;
    Duration nightWorkShift = Duration.zero;
    for(WorkModel i in work ?? []) {
      if(i.startTime.month == DateTime.now().month) {
        final time = HourFunction.getNightWorking(i, DateTime.now());
        final times = HourFunction.getNightWorkShift(i, DateTime.now());
        final f = time != "--:--" ? AppFunction.parseDuration(time) : const Duration(hours: 0, minutes: 0);
        final s = times != "--:--" ? AppFunction.parseDuration(times) : const Duration(hours: 0, minutes: 0);
        nightWork = nightWork + f;
        nightWorkShift = nightWorkShift + s;
      }
    }

    nightWorking = AppFunction.timeFormat(nightWork);
    nightWorkAdd = AppFunction.timeFormat(nightWorkShift);
    notifyListeners();
  }

  void timeClear() {
    startTime = null;
    endTime = null;
    notifyListeners();
  }


  setUser({required UserModel userData}) {
    UserService.instance.setUser(userData);
    user = UserService.instance.currentUser;
    notifyListeners();
  }

  updateSettings({required SettingsModel settingsData}) {
    SettingService.instance.updateSettings(settingsData);
    setting = SettingService.instance.service;
    notifyListeners();
  }

  Duration setDuration() {
    return setting!.workingHour == null
        ? const Duration(hours: 300)
        : Duration(hours: setting!.workingHour!.inHours, minutes: setting!.workingHour!.inMinutes);
  }

  Set<DateTime> generateDateRange(DateTime startTime, DateTime endTime) {
    Set<DateTime> dateRange = {};
    DateTime currentDate = DateUtils.dateOnly(startTime);
    DateTime lastDate = DateUtils.dateOnly(endTime);

    while (!currentDate.isAfter(lastDate)) {
      dateRange.add(currentDate);
      currentDate = currentDate.add(const Duration(days: 1));
    }

    return dateRange;
  }


}