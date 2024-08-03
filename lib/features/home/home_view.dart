import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
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
            Text('Çalışma Saati: ${context
                .watch<AppState>()
                .monthlyWorkTime}'),
            PopupMenuButton(
              icon: const Icon(Icons.more_vert_outlined),
              position: PopupMenuPosition.under,
              itemBuilder: (context) =>
                  ButtonConstant.appbarEntry(context: context),
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
              headerStyle: const CalendarHeaderStyle(
                  backgroundColor: Colors.white),
              onViewChanged: (viewChangedDetails) {
                if (firstOpen) {
                  value.getMonthlyWork(
                      month: calenderController.displayDate!.month);
                }
              },
              dataSource: value.loading
                  ? WorkDataManager(value.work ?? [])
                  : WorkDataManager([]),

              monthViewSettings: const MonthViewSettings(
                showAgenda: true,
                appointmentDisplayMode: MonthAppointmentDisplayMode.indicator,
                agendaItemHeight: 130,
              ),
              appointmentBuilder: (context, detail) {
                final WorkModel appointment = detail.appointments.first;
                return AppointmentCard(
                    appointment: appointment,
                    detail: detail,
                    controller: calenderController);
              },
            );
          },
        ),
        floatingActionButton: InkWell(
          child: FloatingActionButton(
            child: const Icon(Icons.add),
            onPressed: () {
              AppFunction.showMainSheet(
                context: context,
                child: CreateWorkView(
                  controller: calenderController,
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
