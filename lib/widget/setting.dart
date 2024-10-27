import 'package:flutter/material.dart';
import 'package:project_train/core/model/settings_model.dart';
import 'package:project_train/core/state/app_state.dart';
import 'package:project_train/widget/sheet_divider.dart';
import 'package:provider/provider.dart';

class Setting extends StatelessWidget {
  const Setting({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 220,
      width: double.infinity,
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(20)),
      child: Consumer<AppState>(
        builder: (context, value, child) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                SheetDivider.showDivider(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text('Makinist ve Tren şefi Bilgilerini al'),
                    Switch(
                      value: value.setting!.showMachinist,
                      onChanged: (val) {
                        value.updateSettings(
                            settingsData: SettingsModel(
                                showMachinist: val,
                                newUi: value.setting!.newUi,
                            ));
                      },
                    )
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text('Yeni Tasarım (BETA)'),
                    Switch(
                      value: value.setting!.newUi,
                      onChanged: (val) {
                        value.updateSettings(
                            settingsData: SettingsModel(
                                showMachinist: value.setting!.showMachinist,
                                newUi: val,
                            ));
                      },
                    )
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
