import 'package:flutter/material.dart';
import 'package:project_train/core/service/user_service.dart';
import 'package:project_train/core/state/app_state.dart';
import 'package:project_train/core/state/backup_state.dart';
import 'package:project_train/widget/sheet_divider.dart';
import 'package:provider/provider.dart';

class Backup extends StatefulWidget {
  const Backup({super.key});

  @override
  State<Backup> createState() => _BackupState();
}

class _BackupState extends State<Backup> with TickerProviderStateMixin {

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
          Text('Son Yedekleme: ${user!.lastBackup}'),
          Text(context.watch<BackupState>().backupMessage),
          ElevatedButton(
            child: Text('Yedekle'),
            onPressed: () {
              context.read<BackupState>().startBackup(
                  data: context.read<AppState>().work!
              );
            },
          )
        ],
      ),
    );
  }
}
