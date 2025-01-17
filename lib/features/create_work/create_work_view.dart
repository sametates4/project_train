import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:project_train/core/function/app_function.dart';
import 'package:project_train/core/model/work_model.dart';
import 'package:project_train/core/state/app_state.dart';
import 'package:project_train/sheet/time_sheet.dart';
import 'package:project_train/widget/auto_complete.dart';
import 'package:project_train/widget/sheet_divider.dart';
import 'package:provider/provider.dart';

@RoutePage()
class CreateWorkView extends StatefulWidget {
  const CreateWorkView({super.key, this.model, required this.date});
  final WorkModel? model;
  final DateTime date;

  @override
  State<CreateWorkView> createState() => _CreateWorkViewState();
}

class _CreateWorkViewState extends State<CreateWorkView> {


  final machinist = TextEditingController();
  final machinistTwo = TextEditingController();

  final trainNumber = TextEditingController();
  final trainNumberTwo = TextEditingController();

  final startTime = TextEditingController();
  final endTime = TextEditingController();

  String inputText = ""; // Kullanıcının girdiği metin
  String hintText = "";  // Dinamik olarak kalan metin
  String _currentText = '';
  String _lastUserInput = '';

  @override
  void initState() {
    super.initState();
    if(widget.model != null){
      setData();
    }
  }

  void setData() {
    final names = widget.model!.machinist!.isNotEmpty ?  widget.model!.machinist?.split(' - ') : ['', ''];
    machinist.text = names![0];
    machinistTwo.text = names[1];
    trainNumber.text = widget.model!.trainNumber.toString();
    trainNumberTwo.text = widget.model!.trainNumberTwo != null ? widget.model!.trainNumberTwo.toString() : '';
    startTime.text = AppFunction.dateTimeFormat(widget.model!.startTime);
    endTime.text = AppFunction.dateTimeFormat(widget.model!.endTime);
    context.read<AppState>().setStartTime(widget.model!.startTime);
    context.read<AppState>().setFinishTime(widget.model?.endTime);
  }



  void _onTextChanged(String value) {
    if (_lastUserInput.length > value.length) {
      // Eğer silme işlemi yapılmışsa
      //_lastUserInput = value;
      return; // Silme işlemi sırasında otomatik tamamlama yapılmasın
    }

    setState(() {
      _lastUserInput = value;
      String? match = context.read<AppState>().nameList.firstWhere(
            (item) => item.toLowerCase().startsWith(value.toLowerCase()),
        orElse: () => '',
      );

      if (match.isNotEmpty && value.isNotEmpty) {
        // Kullanıcının girdisi eşleşirse otomatik tamamlama
        machinist.value = TextEditingValue(
          text: match,
          selection: TextSelection(
            baseOffset: value.length,
            extentOffset: match.length,
          ),
        );
      }
    });

    print(_lastUserInput);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 390,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Colors.white,
      ),
      child: Padding(
        padding: const EdgeInsets.only(left: 10, right: 10, bottom: 10),
        child: Column(
          children: [
            SheetDivider.showDivider(),
            AutoComplete(
              controller: machinist,
              list: context.read<AppState>().nameList,
              labelText: 'Makinist Adı',
              inputAction: TextInputAction.next,
              inputType: TextInputType.name,
            ),
            const SizedBox(height: 10),
            AutoComplete(
              controller: machinistTwo,
              list: context.read<AppState>().nameList,
              labelText: 'Tren Şefi Adı',
              inputAction: TextInputAction.next,
              inputType: TextInputType.name,
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
                    child: TextField(
                      controller: trainNumber,
                      textInputAction: TextInputAction.next,
                      keyboardType: TextInputType.numberWithOptions(signed: true),
                      inputFormatters: [
                        FilteringTextInputFormatter.digitsOnly,
                      ],
                      decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20)),
                          labelText: 'Çıkış Tren Numarası'),
                    ),
                  ),
                  SizedBox(
                    width: MediaQuery.sizeOf(context).width * 0.42,
                    height: 60,
                    child: TextField(
                      controller: trainNumberTwo,
                      textInputAction: TextInputAction.done,
                      keyboardType: TextInputType.numberWithOptions(signed: true),
                      inputFormatters: [
                        FilteringTextInputFormatter.digitsOnly,
                      ],
                      decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20)),
                          labelText: 'Dönüş Tren Numarası'),
                    ),
                  ),
                ],
              ),
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
                              labelText: 'Görev Alma Saati',
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
                          controller: TextEditingController(
                              text: AppFunction.dateTimeFormat(context.watch<AppState>().endTime)
                          ),
                          decoration: InputDecoration(
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20)),
                              labelText: 'İş Bitiş Saati',
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
            const SizedBox(height: 30),
            ElevatedButton(
              child: Text(widget.model == null ? 'Kayıt Et' : 'Güncelle'),
              onPressed: () {
                final working = WorkModel(
                    id: widget.model == null ? context.read<AppState>().work != null ? context.read<AppState>().work!.length+1 : 1 : widget.model!.id,
                    machinist: '${machinist.text} - ${machinistTwo.text}',
                    trainNumber: int.parse(trainNumber.text),
                    trainNumberTwo: trainNumberTwo.text.isNotEmpty ? int.parse(trainNumberTwo.text) : null,
                    startTime: context.read<AppState>().startTime!,
                    endTime: context.read<AppState>().endTime,
                    mileageList: widget.model?.mileageList != null ? widget.model!.mileageList : null
                );
                if(widget.model == null) {
                  context.read<AppState>().addWorkData(items: working);
                } else {
                 context.read<AppState>().updateWorkData(index: widget.model!.id, item: working, month: widget.date.month);
                }
                context.router.popForced();
              },
            )
          ],
        ),
      ),
    );
  }
}