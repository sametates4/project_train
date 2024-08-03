import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:project_train/widget/sheet_divider.dart';
import 'package:provider/provider.dart';

import '../core/model/work_model.dart';
import '../core/state/app_state.dart';

class CreateMainWork extends StatefulWidget {
  const CreateMainWork({super.key});

  @override
  State<CreateMainWork> createState() => _CreateMainWorkState();
}

class _CreateMainWorkState extends State<CreateMainWork> {

  int? selectedRadio = 4;

  final time1 = DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day, 00, 00);
  final time2 = DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day, 08, 00);
  final time3 = DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day, 16, 00);

  final time11 = DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day, 07, 30);
  final time22 = DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day, 15, 30);
  final time33 = DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day, 23, 30);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 250,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20)
      ),
      child: Column(
        children: [
          SheetDivider.showDivider(),
          RadioListTile<int>(
            title: const Text('Depo, 00:00 - 08:00'),
            value: 0,
            groupValue: selectedRadio,
            onChanged: (value) {
              setState(() {
                selectedRadio = value;
              });
            },
          ),
          RadioListTile<int>(
            title: const Text('Depo, 08:00 - 16:00'),
            value: 1,
            groupValue: selectedRadio,
            onChanged: (value) {
              setState(() {
                selectedRadio = value;
              });
            },
          ),
          RadioListTile<int>(
            title: const Text('Depo, 16:00 - 24:00'),
            value: 2,
            groupValue: selectedRadio,
            onChanged: (value) {
              setState(() {
                selectedRadio = value;
              });
            },
          ),

          ElevatedButton(
            onPressed: selectedRadio != 4 ? () {
              final working = WorkModel(
                id: context.read<AppState>().work!.length+1,
                machinist: 'DEPO',
                trainNumber: selectedRadio == 0 ? 99997 : selectedRadio == 1 ? 99998 : 99999,
                trainNumberTwo: 99999,
                startTime: selectedRadio == 0 ? time1 : selectedRadio == 1 ? time2 : time3,
                endTime: selectedRadio == 0 ? time11 : selectedRadio == 1 ? time22 : time33,
              );
              context.read<AppState>().addWorkData(items: working);
              context.router.popForced();
            } : null ,
            child: const Text('Kayıt Et'),
          )
        ],
      ),
    );
  }
}
