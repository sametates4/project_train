import 'package:flutter/material.dart';

import '../manager/work_manager.dart';
import '../model/work_model.dart';

final class AppState extends ChangeNotifier{
  static final HiveCacheManager<WorkModel> _workService = WorkManager('box');
  bool loading = false;
  List<WorkModel>? work;

  DateTime? startTime;
  DateTime? endTime;

  Future<void> ensureInit() async {
    await _workService.init();
    work = _workService.getValues();
    loading = true;
    notifyListeners();
  }

  Future<void> addWorkData({required WorkModel items}) async {
    _workService.addItems(items);
    clear();
    startTime = null;
    endTime = null;
    work = getWorkData();
    notifyListeners();
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

  void deleteWorkData({required int index}) {
    int itemIndex = work!.indexWhere((element) => element.id == index);
    _workService.deleteItem(itemIndex);
    clear();
    work = getWorkData();
    notifyListeners();
  }

  void updateWorkData({required int index, required WorkModel item}) {
    int itemIndex = work!.indexWhere((element) => element.id == index);
    print('bulunan index: $itemIndex');
    print('gelen index $index');
    _workService.putAtItem(itemIndex, item);
    clear();
    work = getWorkData();
    notifyListeners();
  }

}