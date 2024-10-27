import 'package:hive_flutter/hive_flutter.dart';

import '../abstract/storage_cache_manager.dart';
import '../model/settings_model.dart';

final class SettingManager extends StorageCacheManager<SettingsModel> {
  SettingManager(super.key);

  @override
  Future<void> addItems(SettingsModel items) async {
    await box?.add(items);
  }

  @override
  Future<void> deleteItem(int index) async {
    await box?.deleteAt(index);
  }

  @override
  SettingsModel? getItem(String key) {
    // TODO: implement getItem
    throw UnimplementedError();
  }

  @override
  List<SettingsModel>? getValues() {
    return box?.values.toList();
  }

  @override
  Future<void> putAtItem(int index, SettingsModel item) async {
    await box?.putAt(index, item);
  }

  @override
  Future<void> putItem(String key, SettingsModel item) async {
    throw UnimplementedError();
  }

  @override
  Future<void> putItems(List<SettingsModel> items) {
    // TODO: implement putItems
    throw UnimplementedError();
  }

  @override
  void registerAdapters() {
    if(!Hive.isAdapterRegistered(3)) {
      Hive.registerAdapter(SettingsModelAdapter());
    }
  }

  @override
  Future<void> removeItem(String key) async {
    await box?.delete(key);
  }

}