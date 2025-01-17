import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:project_train/core/constant/c_style.dart';
import 'package:project_train/features/home/widget/cell_builder.dart';
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

class _HomeViewState extends State<HomeView> with WidgetsBindingObserver {
  UserModel? user = UserService.instance.currentUser;
  bool firstOpen = false;
  CalendarAppointmentDetails? detail;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    Provider.of<AppState>(context, listen: false).ensureInit();
    Future.delayed(const Duration(microseconds: 1))
        .then((value) => authCheck());
  }

  Future<void> authCheck() async {
    if (user == null) {
      AppFunction.showMainSheet(
          context: context,
          padding:
              EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
          child: const Auth());
    }
    setState(() {
      firstOpen = true;
    });
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);

    if (state == AppLifecycleState.resumed) {
      context
          .read<AppState>()
          .reCalculateMonthlyWork(month: DateTime.now().month);
    }
  }

  @override
  void dispose() {
    super.dispose();
    WidgetsBinding.instance.removeObserver(this);
  }

  final controller = CalendarController();

  @override
  Widget build(BuildContext context) {
    return Consumer<AppState>(
      builder: (context, value, child) {
        return Scaffold(
            backgroundColor: Colors.white,
            resizeToAvoidBottomInset: false,
            appBar: AppBar(
              title: Text(value.user?.name ?? ''),
              centerTitle: false,
              backgroundColor: Colors.white,
              actions: [
                InkWell(
                    child: RichText(
                      text: TextSpan(
                          text: 'Çalışma Saati: ',
                          style: TextStyle(color: Colors.black, fontSize: 14),
                          children: <TextSpan>[
                            TextSpan(
                                text: value.monthlyWorkTimeString,
                                style: TextStyle(
                                    color: value.monthlyWorkTime >
                                            value.setDuration()
                                        ? Colors.green
                                        : Colors.black)),
                          ]),
                    ),
                    onTap: () {
                      AppFunction.showMainSheet(
                          context: context,
                          padding: EdgeInsets.only(
                              bottom: MediaQuery.of(context).viewInsets.bottom),
                          child: const MonthlyWorkSet());
                    }),
                PopupMenuButton(
                    icon: const Icon(Icons.more_vert_outlined),
                    position: PopupMenuPosition.under,
                    itemBuilder: (context) =>
                        ButtonConstant.appbarEntry(context: context))
              ],
            ),
            body: Padding(
                padding: const EdgeInsets.only(left: 5, right: 5),
                child: SfCalendar(
                    showDatePickerButton: false,
                    view: CalendarView.month,
                    showNavigationArrow: true,
                    initialSelectedDate: DateTime.now(),
                    firstDayOfWeek: 1,
                    onLongPress: (details) {
                      AppFunction.showMainSheet(
                          context: context,
                          child: SetSpecialDays(details: details));
                    },
                    selectionDecoration:
                        value.setting!.newUi ? CStyle.style1() : null,
                    monthCellBuilder: value.setting!.newUi
                        ? (_, d) => CellBuilder(details: d, controller: controller)
                        : null,
                    controller: controller,
                    headerStyle: const CalendarHeaderStyle(
                      textAlign: TextAlign.center,
                      backgroundColor: Colors.white,
                    ),
                    onViewChanged: (viewChangedDetails) {
                      if (firstOpen) {
                        value.getMonthlyWork(
                            month: controller.displayDate!.month);
                      }
                    },
                    dataSource: value.loading
                        ? WorkDataManager(value.work ?? [])
                        : WorkDataManager([]),
                    monthViewSettings: MonthViewSettings(
                      showAgenda: true,
                      appointmentDisplayMode: MonthAppointmentDisplayMode.indicator,
                      agendaItemHeight: 130,
                      agendaViewHeight: value.setting!.newUi
                          ? MediaQuery.sizeOf(context).height * 0.47
                          : -1,
                    ),
                    appointmentBuilder: (context, d) {
                      final WorkModel appointment = d.appointments.first;
                      detail = d;
                      return AppointmentCard(
                          workData: appointment,
                          date: d.date,
                          month: controller.displayDate!);
                    })),
            floatingActionButton: InkWell(
              child: FloatingActionButton(
                child: const Icon(Icons.add),
                onPressed: () {
                  AppFunction.showMainSheet(
                    context: context,
                    padding: EdgeInsets.only(
                        bottom: MediaQuery.of(context).viewInsets.bottom),
                    child: CreateWorkView(
                      date: controller.displayDate ?? DateTime.now(),
                    ),
                  );
                },
              ),
              onLongPress: () {
                AppFunction.showMainSheet(context: context, child: const CreateMainWork());
              },
            ));
      },
    );
  }
}
