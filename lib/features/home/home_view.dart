import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:project_train/core/function/hour_function.dart';
import 'package:project_train/core/manager/work_data_manager.dart';
import 'package:project_train/core/model/work_model.dart';
import 'package:project_train/core/service/user_service.dart';
import 'package:project_train/features/create_work/create_work_view.dart';
import 'package:project_train/features/table/table_view.dart';
import 'package:project_train/widget/auth.dart';
import 'package:project_train/widget/backup.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

import '../../core/function/app_function.dart';
import '../../core/model/user_model.dart';
import '../../core/state/app_state.dart';

@RoutePage()
class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {

  UserModel? user = UserService.instance.currentUser;
  bool firstOpen = false;

  @override
  void initState() {
    super.initState();
    Provider.of<AppState>(context, listen: false).ensureInit();
    Future.delayed(const Duration(microseconds: 1)).then((value) => authCheck());
  }

  Future<void> authCheck() async {
    if(user == null) {
      AppFunction.showMainSheet(
          context: context,
          child: const Auth());
    }
    setState(() {
      firstOpen = true;
    });
  }

  final calenderController = CalendarController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(context.watch<AppState>().user?.name ?? ''),
        centerTitle: false,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 10),
            child: Text(
                'Çalışma Saati: ${context.watch<AppState>().monthlyWorkTime}'),
          ),
          PopupMenuButton(
            icon: const Icon(Icons.more_vert_outlined),
            position: PopupMenuPosition.under,
            itemBuilder: (context) {
              return [
                PopupMenuItem(
                  child: const Text('Table'),
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => const TableView()));
                  },
                ),
                PopupMenuItem(
                  child: const Text('Backup'),
                  onTap: () {
                    AppFunction.showMainSheet(context: context, child: const Backup());
                  },
                ),
              ];
            },
          )
        ],
      ),
      body: Consumer<AppState>(
        builder: (context, value, child) {
          return SfCalendar(
            showDatePickerButton: true,
            view: CalendarView.month,
            initialSelectedDate: DateTime.now(),
            firstDayOfWeek: 1,
            controller: calenderController,
            onViewChanged: (viewChangedDetails) {
              if(firstOpen) {
                value.getMonthlyWork(month: calenderController.displayDate!.month);
              }
            },
            dataSource: value.loading
                ? WorkDataManager(value.work ?? [])
                : WorkDataManager([]),
            monthViewSettings: const MonthViewSettings(
              showAgenda: true,
              appointmentDisplayMode: MonthAppointmentDisplayMode.indicator,
              agendaItemHeight: 120,
            ),
            appointmentBuilder: (context, detail) {
              final WorkModel appointment = detail.appointments.first;
              return Container(
                  width: double.infinity,
                  padding: const EdgeInsets.only(left: 10, top: 5),
                  decoration: const BoxDecoration(
                      borderRadius:
                          BorderRadius.only(bottomLeft: Radius.circular(20)),
                      border: Border(
                        bottom: BorderSide(color: Colors.black),
                        left: BorderSide(color: Colors.black),
                      )),
                  child: Stack(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            appointment.machinist,
                            style: Theme.of(context).textTheme.bodyMedium,
                          ),
                          Text(
                              'Giden: ${appointment.trainNumber}  -  Gelen: ${HourFunction.trainNumber(appointment.trainNumberTwo)}'),
                          Text(
                              'İşe Başlama: ${HourFunction.getStartTime(appointment, detail.date)}, '
                              'İş Bitiş: ${HourFunction.getEndTime(appointment, detail.date)}'),
                          Text(
                              'Gece Çalışması: ${HourFunction.getNightWorking(appointment, detail.date)}'),
                          Text(
                              'Fiili Çalışma: ${HourFunction.getActiveWorking(appointment, detail.date)}')
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          PopupMenuButton(
                            elevation: 10,
                            position: PopupMenuPosition.under,
                            itemBuilder: (context) => [
                              PopupMenuItem(
                                child: const Text('Düzenle'),
                                onTap: () {
                                  AppFunction.showMainSheet(
                                    context: context,
                                    child: CreateWorkView(
                                      model: appointment,
                                      controller: calenderController,
                                    ),
                                  );
                                },
                              ),
                              PopupMenuItem(
                                child: const Text('Sil'),
                                onTap: () {
                                  context.read<AppState>().deleteWorkData(
                                      index: appointment.id,
                                      month: calenderController
                                          .displayDate!.month);
                                },
                              )
                            ],
                          )
                        ],
                      )
                    ],
                  ));
            },
          );
        },
      ),
      floatingActionButton: IconButton(
        icon: const Icon(Icons.add),
        onPressed: () {
          AppFunction.showMainSheet(
              context: context,
              child: CreateWorkView(
                controller: calenderController,
              ));
        },
      ),
    );
  }
}
