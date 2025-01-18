import 'package:flutter/material.dart';
import 'package:project_train/widget/set_mileage_data.dart';
import 'package:project_train/widget/setting.dart';
import 'package:provider/provider.dart';

import '../../features/create_work/create_work_view.dart';
import '../../features/table/table_view.dart';
import '../../widget/backup.dart';
import '../../widget/mileage.dart';
import '../../widget/report.dart';
import '../../widget/restore_data.dart';
import '../function/app_function.dart';
import '../model/work_model.dart';
import '../state/app_state.dart';

final class ButtonConstant {
  static List<PopupMenuEntry> popUpEntry({
    required BuildContext context,
    required WorkModel model,
    required DateTime date,
  })
  {
    return model.machinist == "DEPO" || model.machinist == "İhtiyat"
        ? [
            PopupMenuItem(
              child: const Text('Sil'),
              onTap: () {
                context
                    .read<AppState>()
                    .deleteWorkData(index: model.id, month: date.month);
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
                        date: date,
                      ));
                }),
            PopupMenuItem(
                child: const Text('5545'),
                onTap: () {
                  AppFunction.showMainSheet(
                      context: context,
                      child: model.mileageList != null ?  Mileage(
                        model: model,
                        date: date,
                      ) :  SetMileageData(
                        model: model,
                        date: date,
                      ));
                }),
            PopupMenuItem(
                child: const Text('Sil'),
                onTap: () {
                  context
                      .read<AppState>()
                      .deleteWorkData(index: model.id, month: date.month);
                })
          ];
  }

  static List<PopupMenuEntry> appbarEntry({required BuildContext context}) {
    return [
      PopupMenuItem(
        child: const Text('Table'),
        onTap: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => const TableView()));
        },
      ),
      PopupMenuItem(
        child: const Text('Backup'),
        onTap: () {
          AppFunction.showMainSheet(context: context, child: const Backup());
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
          AppFunction.showMainSheet(context: context, child: const Report());
        },
      ),
      PopupMenuItem(
        child: const Text('Ayarlar'),
        onTap: () {
          context.read<AppState>().monthlyReport();
          AppFunction.showMainSheet(context: context, child: const Setting());
        },
      ),
      PopupMenuItem(
        child: const Text('Maaş Hesapla'),
        onTap: () {
          AppFunction.showMainSheet(context: context, child: const Setting());
        },
      ),
    ];
  }

  static List<PopupMenuEntry> mileageEntry({required BuildContext context, required DateTime date, required WorkModel model, required int index}) {
    return [
      PopupMenuItem(
        child: const Text('Düzenle'),
        onTap: () {
          AppFunction.showMainSheet(context: context, child: SetMileageData(model: model, date: date, index: index));
        },
      ),
    ];
  }
}
