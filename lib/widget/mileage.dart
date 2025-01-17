import 'package:flutter/material.dart';
import 'package:project_train/core/state/app_state.dart';
import 'package:provider/provider.dart';

import '../core/constant/button_constant.dart';
import '../core/constant/container_decoration.dart';
import '../core/constant/text_constant.dart';
import '../core/function/app_function.dart';
import '../core/model/work_model.dart';
import 'set_mileage_data.dart';
import 'sheet_divider.dart';

class Mileage extends StatefulWidget {
  const Mileage({super.key, required this.model, required this.date});

  final WorkModel? model;
  final DateTime date;

  @override
  State<Mileage> createState() => _MileageState();
}

class _MileageState extends State<Mileage> {
  @override
  Widget build(BuildContext context) {
    return Consumer<AppState>(
      builder: (context, value, child) {
        return Container(
          width: double.infinity,
          height: 250,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: Colors.white,
          ),
          child: Padding(
              padding: const EdgeInsets.only(left: 10, right: 10, bottom: 10),
              child: Stack(
                alignment: Alignment.bottomRight,
                children: [
                  Column(
                    children: [
                      SheetDivider.showDivider(),
                      Expanded(
                        child: ListView.builder(
                          itemCount: widget.model!.mileageList!.length,
                          itemBuilder: (context, index) {
                            final val = widget.model!.mileageList![index];
                            return Padding(
                              padding: const EdgeInsets.only(bottom: 10),
                              child: Container(
                                width: double.infinity,
                                padding:
                                    const EdgeInsets.only(left: 10, top: 5),
                                decoration:
                                    ContainerDecoration.appointmentCard(),
                                child: Stack(
                                  children: [
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: TextConstant.mileageDate(
                                              mileage: val,
                                              trainNumber: index == 0
                                                  ? widget.model!.trainNumber
                                                  : widget.model
                                                          ?.trainNumberTwo ??
                                                      99999)
                                          .map((text) => Text(text))
                                          .toList(),
                                    ),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        PopupMenuButton(
                                          icon: const Icon(
                                              Icons.more_vert_outlined),
                                          elevation: 10,
                                          position: PopupMenuPosition.under,
                                          itemBuilder: (context) =>
                                              ButtonConstant.mileageEntry(
                                                  context: context,
                                                  model: widget.model!,
                                                  date: widget.date,
                                                  index: index),
                                        )
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                  ElevatedButton(
                    child: Text('Ekle'),
                    onPressed: () {
                      AppFunction.showMainSheet(
                          context: context,
                          child: SetMileageData(
                              model: widget.model,
                              date: widget.date,
                              addData: true));
                    },
                  )
                ],
              )),
        );
      },
    );
  }
}
