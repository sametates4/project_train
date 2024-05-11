import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:project_train/core/manager/work_data_manager.dart';
import 'package:project_train/core/model/work_model.dart';
import 'package:project_train/features/create_work/create_work_view.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

import '../../core/function/app_function.dart';
import '../../core/state/app_state.dart';

@RoutePage()
class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  String dropdownValue = 'One';

  @override
  void initState() {
    super.initState();
    Provider.of<AppState>(context, listen: false).ensureInit();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Ana Sayfa'),
      ),
      body: Consumer<AppState>(
        builder: (context, value, child) {
          return SfCalendar(
            view: CalendarView.month,
            initialSelectedDate: DateTime.now(),
            firstDayOfWeek: 1,
            dataSource: WorkDataManager(value.work ?? []),
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
                    borderRadius: BorderRadius.only( bottomLeft: Radius.circular(20)),
                    border: Border(bottom: BorderSide(color: Colors.black), left: BorderSide(color: Colors.black) )
                  ),
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
                              'Giden: ${appointment.trainNumber}  -  Gelen: ${trainNumber(appointment.trainNumberTwo)}'),
                          Text(
                              'İşe Başlama: ${getStartTime(appointment, detail.date)}, '
                              'İş Bitiş: ${getEndTime(appointment, detail.date)}'),
                          Text(
                              'Gece Çalışması: ${getNightWorking(appointment, detail.date)}'),
                          Text(
                              'Fiili Çalışma: ${getActiveWorking(appointment, detail.date)}')
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          PopupMenuButton(
                            elevation: 10,
                            itemBuilder: (context) => [
                              PopupMenuItem(
                                child: const Text('Düzenle'),
                                onTap: () {
                                  AppFunction.showMainSheet(
                                    context: context,
                                    child: CreateWorkView(model: appointment),
                                  );
                                },
                              ),
                              PopupMenuItem(
                                child: const Text('Sil'),
                                onTap: () {
                                  context.read<AppState>().deleteWorkData(index: appointment.id);
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
              context: context, child: const CreateWorkView());
        },
      ),
    );
  }
}

String getEndTime(WorkModel work, DateTime detail) {
  if (work.endTime != null) {
    if (work.startTime.day == work.endTime!.day) {
      final duration =
          Duration(hours: work.endTime!.hour, minutes: work.endTime!.minute);
      return AppFunction.timeFormat(duration);
    } else {
      if (work.startTime.day == detail.day) {
        return AppFunction.timeFormat(const Duration(hours: 00, minutes: 00));
      } else {
        final duration =
            Duration(hours: work.endTime!.hour, minutes: work.endTime!.minute);
        return AppFunction.timeFormat(duration);
      }
    }
  } else {
    if (work.startTime.day == DateTime.now().day) {
      return '--:--';
    } else {
      if (work.startTime.day == detail.day) {
        return AppFunction.timeFormat(const Duration(hours: 00, minutes: 00));
      } else {
        return '--:--';
      }
    }
  }
}

String getStartTime(WorkModel work, DateTime detail) {
  if (work.endTime != null) {
    if (work.startTime.day == work.endTime!.day) {
      final duration =
          Duration(hours: work.startTime.hour, minutes: work.startTime.minute);
      return AppFunction.timeFormat(duration);
    } else {
      if (work.startTime.day == detail.day) {
        final duration = Duration(
            hours: work.startTime.hour, minutes: work.startTime.minute);
        return AppFunction.timeFormat(duration);
      } else {
        return AppFunction.timeFormat(const Duration(hours: 00, minutes: 00));
      }
    }
  } else {
    if (work.startTime.day == DateTime.now().day) {
      final duration =
          Duration(hours: work.startTime.hour, minutes: work.startTime.minute);
      return AppFunction.timeFormat(duration);
    } else {
      if (work.startTime.day == detail.day) {
        final duration = Duration(
            hours: work.startTime.hour, minutes: work.startTime.minute);
        return AppFunction.timeFormat(duration);
      } else {
        return AppFunction.timeFormat(const Duration(hours: 00, minutes: 00));
      }
    }
  }
}

String getNightWorking(WorkModel work, DateTime detail) {
  if (work.endTime != null) {
    if (work.startTime.day == work.endTime!.day) {
      final time = DateTime(
          work.endTime!.year, work.endTime!.month, work.endTime!.day, 20, 00);
      Duration nightWork = work.endTime!.difference(time);
      if (nightWork.isNegative) {
        return '--:--';
      } else {
        return AppFunction.timeFormat(nightWork);
      }
    } else {
      if (work.startTime.day == detail.day) {
        return AppFunction.timeFormat(const Duration(hours: 4, minutes: 00));
      } else {
        final time = DateTime(
            work.endTime!.year, work.endTime!.month, work.endTime!.day, 00, 00);
        final nightWorking = work.endTime!.difference(time);
        if (nightWorking.inHours >= 6) {
          return AppFunction.timeFormat(const Duration(hours: 6, minutes: 00));
        } else {
          return AppFunction.timeFormat(nightWorking);
        }
      }
    }
  } else {
    if (work.startTime.day == DateTime.now().day) {
      final time = DateTime(DateTime.now().year, DateTime.now().month,
          DateTime.now().day, 20, 00);
      Duration nightWork = DateTime.now().difference(time);
      if (nightWork.isNegative) {
        return '--:--';
      } else {
        return AppFunction.timeFormat(nightWork);
      }
    } else {
      if (work.startTime.day == detail.day) {
        return AppFunction.timeFormat(const Duration(hours: 4, minutes: 00));
      } else {
        final time = DateTime(DateTime.now().year, DateTime.now().month,
            DateTime.now().day, 00, 00);
        final nightWorking = DateTime.now().difference(time);
        if (nightWorking.inHours >= 6) {
          return AppFunction.timeFormat(const Duration(hours: 6, minutes: 00));
        } else {
          return AppFunction.timeFormat(nightWorking);
        }
      }
    }
  }
}

String getActiveWorking(WorkModel work, DateTime detail) {
  if (work.endTime != null) {
    if (work.startTime.day == work.endTime!.day) {
      return AppFunction.timeFormat(work.endTime!.difference(work.startTime));
    } else {
      if (work.startTime.day == detail.day) {
        final time = DateTime(work.startTime.year, work.startTime.month,
            work.startTime.day, 24, 00);
        final activeWorking = time.difference(work.startTime);
        return AppFunction.timeFormat(activeWorking);
      } else {
        final time = DateTime(
            work.endTime!.year, work.endTime!.month, work.endTime!.day, 00, 00);
        return AppFunction.timeFormat(work.endTime!.difference(time));
      }
    }
  } else {
    if (work.startTime.day == DateTime.now().day) {
      return AppFunction.timeFormat(DateTime.now().difference(work.startTime));
    } else {
      if (work.startTime.day == detail.day) {
        final time = DateTime(work.startTime.year, work.startTime.month,
            work.startTime.day, 24, 00);
        final activeWorking = time.difference(work.startTime);

        return AppFunction.timeFormat(activeWorking);
      } else {
        final time = DateTime(DateTime.now().year, DateTime.now().month,
            DateTime.now().day, 00, 00);
        return AppFunction.timeFormat(DateTime.now().difference(time));
      }
    }
  }
}

String trainNumber(int? data) {
  if (data == null) {
    return '-----';
  } else {
    return data.toString();
  }
}
