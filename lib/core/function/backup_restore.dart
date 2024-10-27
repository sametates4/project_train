import '../model/user_model.dart';
import '../model/work_model.dart';
import '../service/network_service.dart';

final class BackupRestore{
  static final BackupRestore _instance = BackupRestore._internal();
  late final NetworkService service; // Service sınıfı, network işlemlerini temsil eden bir sınıf olmalı

  BackupRestore._internal();

  factory BackupRestore({required NetworkService service}) {
    _instance.service = service;
    return _instance;
  }

  static Future<bool> backup({required List<WorkModel> workList, required UserModel user}) async {

    for(WorkModel i in workList) {
      Map<String, dynamic> data = {
        'machinist': i.machinist,
        'trainNumber': i.trainNumber,
        'trainNumberTwo': i.trainNumberTwo,
        'startTime': i.startTime.toString(),
        'endTime': i.endTime != null ? i.endTime.toString() : '',
        'offDay': i.offDay == null ? '' : i.offDay.toString(),
        'weekOfDay': i.weekOfDay == null ? '' : i.weekOfDay.toString(),
        'user_id': user.kky,
      };
      _instance.service.backupData(data: data).then((value) {
      },);
    }
    return true;
  }

  static Future<bool> restore() async {
    return true;
  }
}