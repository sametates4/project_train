

import 'package:hive_flutter/hive_flutter.dart';

abstract class StorageCacheManager<T> {
  StorageCacheManager(this.key);

  final String key;
  Box<T>? box; // hata olursa T yerine modeli ver

  Future<void> init() async {
    registerAdapters();
    if(!(box?.isOpen ?? false)){
      box = await Hive.openBox(key);
    }
  }

  Future<void> clearAll() async {
    await box?.clear();
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