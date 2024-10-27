import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:project_train/widget/monthly_work_set.dart';
import 'package:project_train/widget/set_special_days.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

import '../../core/constant/button_constant.dart';
import '../../core/function/app_function.dart';
import '../../core/manager/work_data_manager.dart';
import '../../core/model/user_model.dart';
import '../../core/model/work_model.dart';
import '../../core/service/user_service.dart';
import '../../core/state/app_state.dart';
import '../../widget/appointment_card.dart';
import '../../widget/auth.dart';
import '../../widget/create_main_work.dart';
import '../create_work/create_work_view.dart';

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
    Future.delayed(const Duration(microseconds: 1))
        .then((value) => authCheck());
  }

  Future<void> authCheck() async {
    if (user == null) {
      AppFunction.showMainSheet(
          context: context,
          padding: EdgeInsets.only(
            bottom: MediaQuery
                .of(context)
                .viewInsets
                .bottom,
          ),
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
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: Text(context
              .watch<AppState>()
              .user
              ?.name ?? ''),
          centerTitle: false,
          backgroundColor: Colors.white,
          actions: [
            InkWell(
              child: RichText(
                text: TextSpan(
                  text: 'Çalışma Saati: ',
                    style: TextStyle(
                        color: Colors.black, fontSize: 14),
                  children: <TextSpan>[
                    TextSpan(
                      text: context.read<AppState>().monthlyWorkTimeString,
                      style: TextStyle(
                        color: context.read<AppState>().monthlyWorkTime > context.read<AppState>().setDuration() ? Colors.green : Colors.black
                      )
                    ),
                  ]
                ),
              ),
              onTap: () {
                AppFunction.showMainSheet(
                    context: context,
                    child: const MonthlyWorkSet(),
                );
              },
            ),
            PopupMenuButton(
              icon: const Icon(Icons.more_vert_outlined),
              position: PopupMenuPosition.under,
              itemBuilder: (context) =>
                  ButtonConstant.appbarEntry(context: context),
            )
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.only(left: 10, right: 10),
          child: Consumer<AppState>(
            builder: (context, value, child) {
              return SfCalendar(
                showDatePickerButton: false,
                view: CalendarView.month,
                showNavigationArrow: true,
                initialSelectedDate: DateTime.now(),
                firstDayOfWeek: 1,
                onLongPress: (details) {
                  AppFunction.showMainSheet(
                      context: context,
                      child: SetSpecialDays(details: details)
                  );
                },
                selectionDecoration: value.setting!.newUi ?  BoxDecoration(
                  shape: BoxShape.rectangle,
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.transparent,
                  border: Border.all(color: Colors.blueGrey, width: 2),
                ) : null,
                monthCellBuilder: value.setting!.newUi ?
                    (context, details) {
                      final DateTime date = details.date;
                      final DateTime visibleDate = calenderController.displayDate!;
                      final DateTime today = DateTime.now();
                      final bool isToday = date.year == today.year && date.month == today.month && date.day == today.day;
                      final bool isCurrentMonth = date.month == visibleDate.month && date.year == visibleDate.year;
                      final bool isWeekend = value.setting!.weekend != null ? date.weekday == value.setting!.weekend : false;
                      Color backgroundColor;
                      if (isWeekend) {
                        backgroundColor = Colors.grey.withOpacity(0.3);
                      } else {
                        backgroundColor = Colors.transparent;
                      }

                  return Container(
                    decoration: BoxDecoration(
                      color: backgroundColor,
                    ),
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
                              decoration: isToday ? TextDecoration.underline : TextDecoration.none,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                } : null,

                controller: calenderController,
                headerStyle: const CalendarHeaderStyle(
                  textAlign: TextAlign.center,
                    backgroundColor: Colors.white,
                ),
                onViewChanged: (viewChangedDetails) {
                  if (firstOpen) {
                    value.getMonthlyWork(
                        month: calenderController.displayDate!.month);
                  }
                },
                dataSource: value.loading
                    ? WorkDataManager(value.work ?? [])
                    : WorkDataManager([]),

                monthViewSettings: MonthViewSettings(
                  showAgenda: true,
                  appointmentDisplayMode: MonthAppointmentDisplayMode.indicator,
                  agendaItemHeight: 130,
                  agendaViewHeight: value.setting!.newUi ? 450 : -1,
                ),
                appointmentBuilder: (context, detail) {
                  final WorkModel appointment = detail.appointments.first;
                  return AppointmentCard(
                      workData: appointment,
                      date: detail.date,
                      month: calenderController.displayDate!);
                },
              );
            },
          ),
        ),
        floatingActionButton: InkWell(
          child: FloatingActionButton(
            child: const Icon(Icons.add),
            onPressed: () {
              AppFunction.showMainSheet(
                context: context,
                child: CreateWorkView(
                  date: calenderController.displayDate ?? DateTime.now(),
                ),
              );
            },
          ),
          onLongPress: () {
            AppFunction.showMainSheet(
                context: context, child: const CreateMainWork());
          },
        ));
  }
}
