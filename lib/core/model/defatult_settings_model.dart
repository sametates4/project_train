import 'package:project_train/core/model/settings_model.dart';

final class DefaultSettingsModel {
  static SettingsModel setSettings() {
    return SettingsModel(
        showMachinist: true,
        newUi: false,
    );
  }
}
