import 'package:flutter/material.dart';
import 'package:project_train/core/state/app_state.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

class CellBuilder extends StatelessWidget {
  const CellBuilder({super.key, required this.details, required this.controller});

  final MonthCellDetails details;
  final CalendarController controller;

  @override
  Widget build(BuildContext context) {
    final DateTime date = details.date;
    final DateTime visibleDate = controller.displayDate!;
    final DateTime today = DateTime.now();
    final bool isToday = date.year == today.year && date.month == today.month && date.day == today.day;
    final bool isCurrentMonth = date.month == visibleDate.month && date.year == visibleDate.year;
    final bool isReport = context.read<AppState>().reportDays.contains(DateUtils.dateOnly(date));

    return Container(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              date.day.toString(),
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: isCurrentMonth ? Colors.black : Colors.grey,
                decoration: isReport
                    ? TextDecoration.lineThrough // Raporlu günlerde üstü çizgili
                    : (isToday ? TextDecoration.underline : TextDecoration.none), // Bugün altı çizgili
                decorationColor: isReport ? Colors.red : Colors.black, // Çizgi rengi rapor günlerinde kırmızı
              ),
            ),
          ],
        ),
      ),
    );
  }
}
