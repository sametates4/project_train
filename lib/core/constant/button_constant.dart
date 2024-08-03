import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

import '../../features/create_work/create_work_view.dart';
import '../../features/table/table_view.dart';
import '../../widget/backup.dart';
import '../../widget/report.dart';
import '../../widget/restore_data.dart';
import '../function/app_function.dart';
import '../model/work_model.dart';
import '../state/app_state.dart';

final class ButtonConstant {
  static List<PopupMenuEntry> popUpEntry({
    required BuildContext context,
    required WorkModel model,
    required CalendarController controller,
  }) {
    return model.machinist == "DEPO"
        ? [
            PopupMenuItem(
              child: const Text('Sil'),
              onTap: () {
                context.read<AppState>().deleteWorkData(
                    index: model.id, month: controller.displayDate!.month);
              },
            )
          ]
        : [
            PopupMenuItem(
                child: const Text('Düzenle'),
                onTap: () {
                  AppFunction.showMainSheet(
                      context: context,
                      child: CreateWorkView(
                        model: model,
                        controller: controller,
                      ));
                }),
            PopupMenuItem(
                child: const Text('Sil'),
                onTap: () {
                  context.read<AppState>().deleteWorkData(
                      index: model.id, month: controller.displayDate!.month);
                })
          ];
  }

  static List<PopupMenuEntry> appbarEntry({required BuildContext context}) {
    return [
      PopupMenuItem(
        child: const Text('Table'),
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => const TableView()));
        },
      ),
      PopupMenuItem(
        child: const Text('Backup'),
        onTap: () {
          AppFunction.showMainSheet(
              context: context, child: const Backup());
        },
      ),
      PopupMenuItem(
        child: const Text('ReBackup'),
        onTap: () {
          AppFunction.showMainSheet(
              context: context, child: const RestoreData());
        },
      ),
      PopupMenuItem(
        child: const Text('Rapor'),
        onTap: () {
          context.read<AppState>().monthlyReport();
          AppFunction.showMainSheet(
              context: context, child: const Report());
        },
      ),
    ];
  }
}
