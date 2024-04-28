part  of '../manager/work_manager.dart';

abstract class HiveCacheManager<T> {
  HiveCacheManager(this.key);

  final String key;
  Box<T>? _box; // hata olursa T yerine modeli ver

  Future<void> init() async {
    registerAdapters();
    if(!(_box?.isOpen ?? false)){
      _box = await Hive.openBox(key);
    }
  }

  Future<void> clearAll() async {
    await _box?.clear();
  }

  void registerAdapters();

  List<T>? getValues();
  Future<void> addItems(T items);
  Future<void> putItems(List<T> items);
  T? getItem(String key);
  Future<void> putItem(String key, T item);
  Future<void> putAtItem(int index, T item);
  Future<void> removeItem(String key) ;
  Future<void> deleteItem(int index);

}