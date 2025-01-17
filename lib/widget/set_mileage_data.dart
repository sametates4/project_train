import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../core/function/app_function.dart';
import '../core/model/mileage_compensation_model.dart';
import '../core/model/work_model.dart';
import '../core/state/app_state.dart';
import '../sheet/time_sheet.dart';
import 'sheet_divider.dart';

class SetMileageData extends StatefulWidget {
  const SetMileageData({super.key, required this.model, required this.date, this.index, this.addData});

  final WorkModel? model;
  final DateTime date;
  final int? index;
  final bool? addData;

  @override
  State<SetMileageData> createState() => _SetMileageDataState();
}

class _SetMileageDataState extends State<SetMileageData> {

  final startStation = TextEditingController();
  final endStation = TextEditingController();
  final intermediateStation = TextEditingController();

  final startTime = TextEditingController();
  final endTime = TextEditingController();

  List<MileageCompensationModel> dataList = [];
  List<MileageCompensationModel> list = [];

  @override
  void initState() {
    super.initState();
    if(widget.index != null) {
      setData();
    }
    if(widget.addData != null) {
      dataList = widget.model!.mileageList!;
    }
  }

  void setData() {
    final res = widget.model!.mileageList![widget.index!];

    startStation.text = res.startStation;
    endStation.text = res.endStation != null ? res.endStation.toString() : '';
    intermediateStation.text = res.intermediateStation != null ? res.intermediateStation.toString() : '';

    startTime.text = AppFunction.dateTimeFormat(res.startTime);
    endTime.text = AppFunction.dateTimeFormat(res.endTime);

    list = widget.model!.mileageList!;

  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 290,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Colors.white,
      ),
      child: Padding(
        padding: const EdgeInsets.only(left: 10, right: 10, bottom: 10),
        child: Column(
          children: [
            SheetDivider.showDivider(),
            Row(
              children: [
                SizedBox(
                  width: MediaQuery.sizeOf(context).width * 0.42,
                  height: 60,
                  child: TextField(
                    controller: startStation,
                    textInputAction: TextInputAction.next,
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
                        labelText: 'Başlangıç İstasyonu'),
                  ),
                ),
                const SizedBox(width: 10),
                SizedBox(
                  width: MediaQuery.sizeOf(context).width * 0.42,
                  height: 60,
                  child: TextField(
                    controller: intermediateStation,
                    textInputAction: TextInputAction.next,
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
                        labelText: 'Ara İstasyon'),
                  ),
                ),
              ],
            ),
            Row(
              children: [
                const Spacer(),
                SizedBox(
                  width: MediaQuery.sizeOf(context).width * 0.42,
                  height: 60,
                  child: TextField(
                    controller: endStation,
                    textInputAction: TextInputAction.next,
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
                        labelText: 'Varış İstasyonu'),
                  ),
                ),
                const SizedBox(width: 5),
              ],
            ),
            const SizedBox(height: 10),
            SizedBox(
              width: double.infinity,
              height: 60,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    width: MediaQuery.sizeOf(context).width * 0.42,
                    height: 60,
                    child: Stack(
                      alignment: Alignment.centerRight,
                      children: [
                        TextField(
                          enabled: false,
                          controller: widget.model != null
                              ? startTime
                              : TextEditingController(text: AppFunction.dateTimeFormat(context.watch<AppState>().startTime)),
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20)),
                            labelText: '45 Açılış',
                          ),
                        ),
                        IconButton(
                          icon: const Icon(Icons.date_range_outlined),
                          onPressed: () {
                            AppFunction.showMainSheet(
                                context: context,
                                child: TimeSheet(
                                  dateTime: context.read<AppState>().startTime,
                                  start: true,
                                  onDateTimeChanged: (date) {
                                    startTime.text = AppFunction.dateTimeFormat(date);
                                  },
                                )
                            );
                          },
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    width: MediaQuery.sizeOf(context).width * 0.42,
                    height: 60,
                    child: Stack(
                      alignment: Alignment.centerRight,
                      children: [
                        TextField(
                          enabled: false,
                          controller: widget.model != null
                              ? endTime
                              : TextEditingController(text: AppFunction.dateTimeFormat(context.watch<AppState>().endTime)),
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20)),
                            labelText: '45 kapanış',
                          ),
                        ),
                        IconButton(
                          icon: const Icon(Icons.date_range_outlined),
                          onPressed: () {
                            AppFunction.showMainSheet(
                                context: context,
                                child: TimeSheet(
                                  dateTime: context.read<AppState>().endTime,
                                  start: false,
                                  onDateTimeChanged: (date) {
                                    endTime.text = AppFunction.dateTimeFormat(date);
                                  },
                                )
                            );
                          },
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              child: Text(widget.index == null ? 'Kayıt Et' : 'Güncelle'),
              onPressed: () {
                final data = MileageCompensationModel(
                  startStation: startStation.text,
                  intermediateStation: intermediateStation.text.isNotEmpty ? intermediateStation.text : null,
                  endStation: endStation.text.isNotEmpty ? endStation.text : null,
                  startTime: context.read<AppState>().startTime ?? widget.model!.mileageList![widget.index!].startTime,
                  endTime: context.read<AppState>().endTime ?? widget.model!.mileageList?[widget.index!].endTime ?? null,
                );
                list.isNotEmpty ? list[widget.index!] = data : null;
                dataList.add(data);
                final working = WorkModel(
                    id: widget.model!.id,
                    machinist: widget.model!.machinist,
                    trainNumber: widget.model!.trainNumber,
                    trainNumberTwo: widget.model!.trainNumberTwo,
                    startTime: widget.model!.startTime,
                    endTime: widget.model!.endTime,
                    mileageList: widget.index == null ? dataList : list
                );
                context.read<AppState>().updateWorkData(index: widget.model!.id, item: working, month: widget.date.month);
                context.router.popForced();
              },
            )
          ],
        ),
      ),
    );
  }
}
