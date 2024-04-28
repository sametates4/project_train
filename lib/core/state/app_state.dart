

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../manager/work_manager.dart';
import '../model/work_model.dart';

final class AppState extends ChangeNotifier{
  static final HiveCacheManager<WorkModel> _workService = WorkManager('box');

  List<WorkModel>? work;

  Future<void> init() async {
    await _workService.init();
    work = getWorkData();
    notifyListeners();
  }

  Future<void> addWorkData({required WorkModel items}) async {
    _workService.addItems(items);
    clear();
    work = getWorkData();
    notifyListeners();
  }

  void clear() => work?.clear();

  List<WorkModel>? getWorkData() => _workService.getValues();
}

final workState = ChangeNotifierProvider<AppState>((ref) => AppState());