
import 'package:project_train/core/model/defatult_settings_model.dart';

import '../abstract/storage_cache_manager.dart';
import '../manager/setting_manager.dart';
import '../model/settings_model.dart';

final class SettingService{
  StorageCacheManager<SettingsModel> manager = SettingManager('settings');
  static final SettingService instance = SettingService._privateConstructor();
  SettingsModel? service;

  SettingService._privateConstructor();

  bool _isInitialized = false;

  factory SettingService() {
    return instance;
  }

  Future<void> ensureInitialized() async {
    await manager.init();
    _isInitialized = true;
    await getSetting();
  }

  Future<void> getSetting() async {
    if (!_isInitialized) {
      return;
    }

    List<SettingsModel>? settingsList = manager.getValues();
    if (settingsList != null && settingsList.isNotEmpty) {
      service = settingsList[0];
    } else {
      manager.addItems(DefaultSettingsModel.setSettings());
      List<SettingsModel>? settingsList = manager.getValues();
      service = settingsList![0];
    }
  }

  Future<void> updateSettings(SettingsModel setting) async {
    manager.putAtItem(0, setting);
    await getSetting();
  }

}