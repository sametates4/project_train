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
  bool loading = false;

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
  }

  Future<void> addWorkData({required WorkModel items}) async {
    _workService.addItems(items);
    clear();
    work = getWorkData();
    notifyListeners();
    reCalculateMonthlyWork(month: DateTime.now().month);
    timeClear();
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


  void getMonthlyWork({required int month}) {
    Duration time = const Duration(hours: 0, minutes: 0);
    for(WorkModel i in work ?? []) {
      if(i.startTime.month == month) {
        if(i.endTime != null) {
          final dailyActivityWork = i.endTime!.difference(i.startTime);
          time = time + dailyActivityWork;
        } else {
          final dailyActivityWork = DateTime.now().difference(i.startTime);
          time = time + dailyActivityWork;
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
    notifyListeners(); // ihtiyaç yok
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

}