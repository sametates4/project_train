import 'package:flutter/material.dart';
import 'package:project_train/core/state/app_state.dart';
import 'package:project_train/widget/sheet_divider.dart';
import 'package:provider/provider.dart';

import '../core/model/work_model.dart';
import '../core/service/user_service.dart';

class RestoreData extends StatefulWidget {
  const RestoreData({super.key});

  @override
  State<RestoreData> createState() => _RestoreDataState();
}

class _RestoreDataState extends State<RestoreData> {

  final user = UserService.instance.currentUser;


  @override
  Widget build(BuildContext context) {
    return Container(
      height: 220,
      width: double.infinity,
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(20)),
      child: Column(
        children: [
          SheetDivider.showDivider(),
          ElevatedButton(
            child: const Text('Geri Yükle'),
            onPressed: () async {
              List<WorkModel> list = await context.read<AppState>().service.fetchData(data: {'kky': user!.kky}) ?? [];

              for(WorkModel i in list) {
                context.read<AppState>().addWorkData(items: i);
              }

            },
          )
        ],
      ),
    );
  }
}
