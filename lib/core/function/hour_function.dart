import '../model/work_model.dart';
import 'app_function.dart';

final class HourFunction {

  static String getEndTime(WorkModel work, DateTime detail) {
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

  static String getStartTime(WorkModel work, DateTime detail) {
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

  static String getNightWorking(WorkModel work, DateTime detail) {
    if (work.endTime != null) {
      if (work.startTime.day == work.endTime!.day) {
        final time = DateTime(work.endTime!.year, work.endTime!.month, work.endTime!.day, 20, 00);
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

  static String getActiveWorking(WorkModel work, DateTime detail) {
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

  static String trainNumber(int? data) {
    if (data == null) {
      return '-----';
    } else {
      return data.toString();
    }
  }

}