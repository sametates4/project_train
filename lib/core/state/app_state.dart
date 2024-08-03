import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:project_train/core/function/app_function.dart';
import 'package:project_train/core/function/hour_function.dart';
import '../manager/work_manager.dart';
import '../model/user_model.dart';
import '../model/work_model.dart';
import '../service/network_service.dart';
import '../service/user_service.dart';

final class AppState extends ChangeNotifier{

  static final HiveCacheManager<WorkModel> _workService = WorkManager('box');
  NetworkService service = NetworkService(Dio(BaseOptions(baseUrl: 'https://api.sametates.dev')));

  UserModel? user = UserService.instance.currentUser;


  List<WorkModel>? work;
  bool loading = false;

  DateTime? startTime;
  DateTime? endTime;
  String monthlyWorkTime = "Hesaplanıyor...";
  String nightWorking = "Hesaplanıyor...";
  String nightWorkAdd = "Hesaplanıyor...";

  Future<void> ensureInit() async {
    await _workService.init();
    work = _workService.getValues();
    loading = true;
    notifyListeners();
    getMonthlyWork(month: DateTime.now().month);

  }

  Future<void> backupData() async {
    for(WorkModel i in work!) {
      Map<String, dynamic> data = {
        'machinist': i.machinist,
        'trainNumber': i.trainNumber,
        'trainNumberTwo': i.trainNumberTwo,
        'startTime': i.startTime.toString(),
        'endTime': i.endTime != null ? i.endTime.toString() : '',
        'offDay': i.offDay == null ? '' : i.offDay.toString(),
        'weekOfDay': i.weekOfDay == null ? '' : i.weekOfDay.toString(),
        'user_id': user?.kky,
      };
      print('yükleme işlemi başlayacak');
      service.backupData(data: data).then((value) {
        print(value);
      },);
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

  void clear() => work?.clear();

  List<WorkModel>? getWorkData() => _workService.getValues();

  void setStartTime(DateTime time) {
    startTime = time;
    //notifyListeners();
  }

  void setFinishTime(DateTime? time) {
    endTime = time;
    //notifyListeners();
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
    monthlyWorkTime = '...';
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
    monthlyWorkTime = AppFunction.timeFormat(time);
    notifyListeners();
  }

  void monthlyReport() {
    Duration nightWork = Duration.zero;
    Duration nightWorkShift = Duration.zero;
    for(WorkModel i in work ?? []) {
      final time = HourFunction.getNightWorking(i, DateTime.now());
      final times = HourFunction.getNightWorkShift(i, DateTime.now());
      final f = time != "--:--" ? AppFunction.parseDuration(time) : const Duration(hours: 0, minutes: 0);
      final s = times != "--:--" ? AppFunction.parseDuration(times) : const Duration(hours: 0, minutes: 0);
      nightWork = nightWork + f;
      nightWorkShift = nightWorkShift + s;
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

}