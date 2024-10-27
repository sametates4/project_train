import 'package:flutter/material.dart';

import '../core/constant/button_constant.dart';
import '../core/constant/container_decoration.dart';
import '../core/constant/text_constant.dart';
import '../core/model/work_model.dart';

class AppointmentCard extends StatelessWidget {
  const AppointmentCard(
      {super.key,
      required this.workData,
      required this.date,
      required this.month});

  final WorkModel workData;
  final DateTime date;
  final DateTime month;

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
                model: workData,
                date: date,
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
                    model: workData,
                    date: month,
                  ),
                )
              ],
            )
          ],
        ));
  }
}
