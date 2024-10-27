import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:project_train/core/constant/date_constant.dart';
import 'package:project_train/core/state/app_state.dart';
import 'package:provider/provider.dart';
import '../core/model/settings_model.dart';
import 'sheet_divider.dart';

class SetWeekendDay extends StatelessWidget {
  const SetWeekendDay({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 200,
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(20)),
      child: Column(
        children: [
          SheetDivider.showDivider(),
          Expanded(
            child: CupertinoPicker(
              itemExtent: 50,
              onSelectedItemChanged: (value) {
                SettingsModel settingsData = SettingsModel(
                  newUi: context.read<AppState>().setting!.newUi,
                  showMachinist: context.read<AppState>().setting!.showMachinist,
                  weekend: value+1,
                  workingHour: context.read<AppState>().setting!.workingHour
                );
                context.read<AppState>().updateSettings(settingsData: settingsData);
              },
              scrollController: FixedExtentScrollController(),
              children: DateConstant.days.map((e) => Center(child: Text(e))).toList()
            ),
          ),
        ],
      ),
    );
  }
}
