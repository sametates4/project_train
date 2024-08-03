import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import 'dart:math' as math;

import '../../widget/sheet_hide_button.dart';

final class AppFunction {
  static Duration calculateActiveWork({required DateTime startTime, required DateTime endTime}) {
    return endTime.difference(startTime);
  }

  static showMainSheet({required BuildContext context, required Widget child, EdgeInsetsGeometry? padding}) {
    return showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      enableDrag: true,
      builder: (context) {
        return Padding(
          padding: padding ?? EdgeInsets.zero,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 16, right: 16, bottom: 16),
                child: child,
              ),
              const SheetHideButton(),
            ],
          ),
        );
      },
    );
  }

  static randomColor() {
    return Color((math.Random().nextDouble() * 0xFFFFFF).toInt()).withOpacity(1.0);
  }

  static dateTimeFormat(DateTime? date) {
    if(date != null) {
      return DateFormat('d MMM H:mm', 'tr').format(date);
    }
    return '';
  }

  static timeFormat(Duration duration) {
    // Saat ve dakikaları al
    int hours = duration.inHours;
    int minutes = duration.inMinutes.remainder(60); // Saat başına düşen dakikalar

    // Duration'u istenen formata dönüştür
    NumberFormat numberFormat = NumberFormat('00'); // Sayıları iki basamaklı olarak formatla
    String formattedHours = numberFormat.format(hours);
    String formattedMinutes = numberFormat.format(minutes);

    return '$formattedHours:$formattedMinutes';
  }

  static Duration parseDuration(String timeString) {
    List<String> parts = timeString.split(":");
    int hours = int.parse(parts[0]);
    int minutes = int.parse(parts[1]);
    return Duration(hours: hours, minutes: minutes);
  }

}