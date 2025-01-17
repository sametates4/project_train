import 'package:dio/dio.dart';
import 'package:flutter/material.dart';


import '../function/app_function.dart';
import '../model/user_model.dart';
import '../model/work_model.dart';
import '../service/network_service.dart';
import '../service/user_service.dart';

final class BackupState extends ChangeNotifier {

  UserModel? user = UserService.instance.currentUser;
  NetworkService service = NetworkService(Dio(BaseOptions(baseUrl: 'https://api.sametates.dev')));

  int backupStatus = 0;
  int backupLength = 0;
  String backupMessage = "Yedeklemeye Hazırlanılıyor ...";
  List<WorkModel> list = [];
  List<WorkModel> cloudDataList = [];
  List<WorkModel> backupData = [];

  Future<void> _fetchCloudData() async {
    final response = await service.fetchData(data: {'kky' : user!.kky});
    cloudDataList = response ?? [];
    notifyListeners();
  }

  Future<void> _compareData() async {
    backupData = findUniqueItems(list, cloudDataList);
    backupLength = backupData.length;
    backupMessage = "${backupData.length} adet veri yedeklenecek ...";
    notifyListeners();
  }

  Future<void> _startingBackup() async {
    for(WorkModel i in list) {
      Map<String, dynamic> data = {
        'machinist': i.machinist,
        'trainNumber': i.trainNumber,
        'trainNumberTwo': i.trainNumberTwo ?? '',
        'startTime': i.startTime.toString(),
        'endTime': i.endTime != null ? i.endTime.toString() : '',
        'offDay': i.offDay == null ? '' : i.offDay.toString(),
        'weekOfDay': i.weekOfDay == null ? '' : i.weekOfDay.toString(),
        'user_id': user?.kky,
      };
      await service.backupData(data: data).then((value) {
        backupStatus = backupStatus + 1;
        backupMessage = "$backupStatus adet veri yedeklendi ...";
        notifyListeners();
      });
    }
  }

  Future<void> _setUserBackupDate() async {
    String time = AppFunction.dateTimeFormat(DateTime.now());
    print(time);
  }

  Future<void> startBackup({required List<WorkModel> data}) async {
    list = data;
    //await _fetchCloudData();
    //await _compareData();
    await _startingBackup();
    //await _setUserBackupDate();
    backupMessage = "Yedekleme Tamamlandı";
    notifyListeners();
  }

  List<WorkModel> findUniqueItems(List<WorkModel> list1, List<WorkModel> list2) {
    Set<WorkModel> set1 = list1.toSet();
    Set<WorkModel> set2 = list2.toSet();

    // Ortak elemanları bul
    Set<WorkModel> intersection = set1.intersection(set2);

    // Tüm elemanları içeren set
    Set<WorkModel> allItems = set1.union(set2);

    // Ortak elemanları tüm elemanlardan çıkar
    allItems.removeAll(intersection);

    return allItems.toList();
  }

}