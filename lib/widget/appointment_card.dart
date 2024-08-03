import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

import '../core/constant/button_constant.dart';
import '../core/constant/container_decoration.dart';
import '../core/constant/text_constant.dart';
import '../core/model/work_model.dart';

class AppointmentCard extends StatelessWidget {
  const AppointmentCard(
      {super.key,
      required this.appointment,
      required this.detail,
      required this.controller});

  final WorkModel appointment;
  final CalendarAppointmentDetails detail;
  final CalendarController controller;

  @override
  Widget build(BuildContext context) {
    return Container(
        width: double.infinity,
        padding: const EdgeInsets.only(left: 10, top: 5),
        decoration: ContainerDecoration.appointmentCard(),
        child: Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: TextConstant.data(
                model: appointment,
                detail: detail,
              ).map((text) => Text(text)).toList(),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                PopupMenuButton(
                  elevation: 10,
                  position: PopupMenuPosition.under,
                  itemBuilder: (context) => ButtonConstant.popUpEntry(
                    context: context,
                    model: appointment,
                    controller: controller,
                  ),
                )
              ],
            )
          ],
        ));
  }
}
