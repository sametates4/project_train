import 'package:flutter/material.dart';
import 'package:project_train/core/model/settings_model.dart';
import 'package:project_train/core/state/app_state.dart';
import 'package:provider/provider.dart';
import 'package:auto_route/auto_route.dart';

class MonthlyWorkSet extends StatefulWidget {
  const MonthlyWorkSet({super.key});

  @override
  State<MonthlyWorkSet> createState() => _MonthlyWorkSetState();
}

class _MonthlyWorkSetState extends State<MonthlyWorkSet> {

  final _hour = TextEditingController();
  final _minute = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Consumer<AppState>(
      builder: (context, value, child) {
        return Container(
          width: double.infinity,
          height: 150,
          decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(20)),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                      width: 80,
                      height: 50,
                      child: TextField(
                        controller: _hour,
                        textAlign: TextAlign.center,
                        keyboardType: TextInputType.number,
                        decoration: const InputDecoration(
                            hintText: 'Saat'
                        ),
                      )
                  ),
                  const Text(':'),
                  SizedBox(
                      width: 80,
                      height: 50,
                      child: TextField(
                        controller: _minute,
                        textAlign: TextAlign.center,
                        keyboardType: TextInputType.number,
                        decoration: const InputDecoration(
                            hintText: 'Dakika'
                        ),
                      )
                  ),
                  const SizedBox(width: 10),
                  ElevatedButton(
                    child: const Text('Çalışma Saati Ayarla'),
                    onPressed: () {
                      int hour = int.parse(_hour.text);
                      int minute = int.parse(_minute.text);
                      Duration work = Duration(hours: hour, minutes: minute);
                      final settingsData = SettingsModel(
                          showMachinist: value.setting!.showMachinist,
                          newUi: value.setting!.newUi,
                          workingHour: work
                      );
                      value.updateSettings(settingsData: settingsData);
                      context.router.popForced();
                    },
                  )

                ],
              ),

            ],
          ),
        );
      },
    );
  }
}
