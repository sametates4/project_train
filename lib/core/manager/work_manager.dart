import 'package:hive_flutter/hive_flutter.dart';
import '../model/work_model.dart';

part '../abstract/hive_cache_manager.dart';

final class WorkManager extends HiveCacheManager<WorkModel> {
  WorkManager(super.key);

  @override
  Future<void> addItems(WorkModel items) async {
    await _box?.add(items);
  }

  @override
  Future<void> deleteItem(int index) async {
    await _box?.deleteAt(index);
  }

  @override
  WorkModel? getItem(String key) {
    return _box?.get(key);
  }

  @override
  List<WorkModel>? getValues() {
    return _box?.values.toList();
  }

  @override
  Future<void> putAtItem(int index, WorkModel item) async {
    await _box?.putAt(index, item);
  }

  @override
  Future<void> putItem(String key, WorkModel item) async {
    await _box?.put(key, item);
  }

  @override
  Future<void> putItems(List<WorkModel> items) async {
    await _box?.putAll(Map.fromEntries(items.map((e) => MapEntry(e.id, e))));
  }

  @override
  void registerAdapters() {
    if(!Hive.isAdapterRegistered(1)){
      Hive.registerAdapter(WorkModelAdapter());
    }

  }

  @override
  Future<void> removeItem(String key) async {
    await _box?.delete(key);
  }
}