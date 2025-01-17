import 'package:hive_flutter/hive_flutter.dart';

import '../model/mileage_compensation_model.dart';
import '../model/user_model.dart';

part '../abstract/user_cache_manager.dart';

final class UserManager extends HiveCacheManager<UserModel> {
  UserManager(super.key);

  @override
  Future<void> addItems(List<UserModel> items)  async {
    await _box?.addAll(items);
  }

  @override
  Future<void> deleteItem(int index) async {
    await _box?.deleteAt(index);
  }

  @override
  UserModel? getItem(String key) {
    return _box?.get(key);
  }

  @override
  List<UserModel>? getValues() {
    return _box?.values.toList();
  }

  @override
  Future<void> putItem(String key, UserModel item) async {
    await _box?.put(key, item);
  }

  @override
  Future<void> putItems(List<UserModel> items) async {
    await _box?.putAll(Map.fromEntries(items.map((e) => MapEntry(e.name, e))));
  }

  @override
  void registerAdapters() {
    if(!Hive.isAdapterRegistered(2)){
      Hive.registerAdapter(UserModelAdapter());
      Hive.registerAdapter(MileageCompensationModelAdapter());
    }
  }

  @override
  Future<void> removeItem(String key) async {
    await _box?.delete(key);
  }

}