import 'package:flutter/material.dart';
import 'package:project_train/core/state/app_state.dart';
import 'package:project_train/widget/sheet_divider.dart';
import 'package:provider/provider.dart';

class Report extends StatefulWidget {
  const Report({super.key});

  @override
  State<Report> createState() => _ReportState();
}

class _ReportState extends State<Report> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 250,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Colors.white,
      ),
      child: Consumer<AppState>(
        builder: (context, value, child) => Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(child: SheetDivider.showDivider()),
            Text('Toplam Çalışma Saati: ${value.monthlyWorkTime}'),
            Text('Gece Çalışması: ${value.nightWorking}'),
            Text('Gece Çalışması Aşan Kısım: ${value.nightWorkAdd}')
          ],
        ),
      ),
    );
  }
}
