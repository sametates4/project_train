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
        } else if (work.endTime!.day == detail.day) {
          return AppFunction.timeFormat(Duration(hours: work.endTime!.hour, minutes: work.endTime!.minute));
        } else if(work.endTime!.day != detail.day && detail.day != DateTime.now().day) {
          return AppFunction.timeFormat(const Duration(hours: 00, minutes: 00));
        } else {
          final duration = Duration(hours: work.endTime!.hour, minutes: work.endTime!.minute);
          return AppFunction.timeFormat(duration);
        }
      }
    } else {
      if (work.startTime.day == DateTime.now().day) {
        return '--:--';
      } else {
        if (work.startTime.day == detail.day) {
          return AppFunction.timeFormat(const Duration(hours: 00, minutes: 00));
        } else if (work.startTime.day != detail.day && detail.day != DateTime.now().day) {
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
        final duration = Duration(
            hours: work.startTime.hour, minutes: work.startTime.minute);
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
        final duration = Duration(
            hours: work.startTime.hour, minutes: work.startTime.minute);
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
    DateTime currentDayMorning = DateTime(work.startTime.year, work.startTime.month, work.startTime.day, 06, 00);
    Duration nightDuration = Duration.zero;
    if (work.endTime != null) {
      if (work.startTime.day == work.endTime!.day) {
        Duration morningDuration = Duration.zero;
        if (work.startTime.hour <= 6) {
          morningDuration = currentDayMorning.difference(work.startTime);
        }

        if(work.startTime.hour >= 0) {
          if(work.startTime.hour <= 6) {
            final time = DateTime(work.endTime!.year, work.endTime!.month, work.endTime!.day, 06, 00);
            nightDuration = time.difference(work.startTime);
          }
        }

        final time = DateTime(work.endTime!.year, work.endTime!.month, work.endTime!.day, 20, 00);
        Duration nightWork = work.endTime!.difference(time);
        Duration finalDuration = nightWork + morningDuration;
        return nightWork.isNegative ? AppFunction.timeFormat(nightDuration) : AppFunction.timeFormat(finalDuration);
      } else {
        if (work.startTime.day == detail.day) {
          Duration morningDuration = Duration.zero;
          if (work.startTime.hour <= 6) {
            morningDuration = currentDayMorning.difference(work.startTime);
          }

          if (work.startTime.hour >= 20) {
            final time = DateTime(work.startTime.year, work.startTime.month, work.startTime.day, 24, 00);
            final duration = time.difference(work.startTime);
            final finalDuration = duration + morningDuration;
            return AppFunction.timeFormat(finalDuration);
          } else {
            final nightWorkTime = morningDuration + const Duration(hours: 4, minutes: 00);
            return AppFunction.timeFormat(nightWorkTime);
          }
        } else if (work.endTime!.day == detail.day) {
          Duration duration = Duration.zero;

          if (work.endTime!.hour >= 20) {
            final time = DateTime(work.endTime!.year, work.endTime!.month, work.endTime!.day, 20, 00);
            final nightDuration = work.endTime!.difference(time);
            duration = nightDuration + const Duration(hours: 6, minutes: 0);
            return AppFunction.timeFormat(duration);
          } else {
            if(work.endTime!.hour >= 6) {
              return AppFunction.timeFormat(const Duration(hours: 6, minutes: 0));
            }else {
              final duration = Duration(hours: work.endTime!.hour, minutes: work.endTime!.minute);
              return AppFunction.timeFormat(duration);
            }

          }
        } else if(work.endTime!.day != detail.day && detail.day != DateTime.now().day) {
          return AppFunction.timeFormat(const Duration(hours: 10, minutes: 00));
        } else {
          final time = DateTime(work.endTime!.year, work.endTime!.month, work.endTime!.day, 00, 00);
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
        Duration morningDuration = Duration.zero;
        if (work.startTime.hour <= 6) {
          morningDuration = currentDayMorning.difference(work.startTime);
        }
        if (work.startTime.hour > 20) {
          Duration nightWork = DateTime.now().difference(work.startTime);
          final nightWorkTime = nightWork + morningDuration;
          return nightWork.isNegative ? '--:--' : AppFunction.timeFormat(nightWorkTime);
        } else {

          if(work.startTime.hour >= 0) {
            if(work.startTime.hour <= 6) {
              final time = DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day, 06, 00);
              nightDuration = time.difference(work.startTime);
            }
          }

          final time = DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day, 20, 00);
          Duration nightWork = DateTime.now().difference(time);
          final nightWorkTime = nightWork + morningDuration;
          return nightWork.isNegative ? AppFunction.timeFormat(nightDuration) : AppFunction.timeFormat(nightWorkTime);
        }
      } else {
        if (work.startTime.day == detail.day) {
          Duration morningDuration = Duration.zero;
          if(work.startTime.hour >= 20) {
            final time = DateTime(detail.year, detail.month, detail.day, 24, 00);
            final duration = time.difference(work.startTime);
            return AppFunction.timeFormat(duration);
          }else {
            if (work.startTime.hour <= 6) {
              morningDuration = currentDayMorning.difference(work.startTime);
            }
            final nightWorkTime = morningDuration + const Duration(hours: 4, minutes: 00);
            return AppFunction.timeFormat(nightWorkTime);
          }

        } else {
          final time = DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day, 00, 00);
          final nightWorking = DateTime.now().difference(time);
          if (nightWorking.inHours >= 6) {
            return AppFunction.timeFormat(
                const Duration(hours: 6, minutes: 00));
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
        } else if(work.endTime!.day == detail.day) {
          return AppFunction.timeFormat(Duration(hours: work.endTime!.hour, minutes: work.endTime!.minute));
        } else if (work.startTime.day != detail.day && detail.day != DateTime.now().day) {
          return AppFunction.timeFormat(const Duration(hours: 24, minutes: 00));
        } else {
          final time = DateTime(work.endTime!.year, work.endTime!.month, work.endTime!.day, 00, 00);
          return AppFunction.timeFormat(work.endTime!.difference(time));
        }
      }
    } else {
      if (work.startTime.day == DateTime.now().day) {
        return AppFunction.timeFormat(
            DateTime.now().difference(work.startTime));
      } else {
        if (work.startTime.day == detail.day) {
          final time = DateTime(work.startTime.year, work.startTime.month,
              work.startTime.day, 24, 00);
          final activeWorking = time.difference(work.startTime);

          return AppFunction.timeFormat(activeWorking);
        } else if (work.startTime.day != detail.day && detail.day != DateTime.now().day) {
          return AppFunction.timeFormat(const Duration(hours: 24, minutes: 00));
        } else {
          final time = DateTime(DateTime.now().year, DateTime.now().month,
              DateTime.now().day, 00, 00);
          return AppFunction.timeFormat(DateTime.now().difference(time));
        }
      }
    }
  }

  static String getNightWorkShift(WorkModel work, DateTime detail) {
    // toplam gece çalışmasını bulma başlama saati 20.00 bitiş 06.00
    Duration totalDuration = Duration.zero;
    DateTime currentDayMorning = DateTime(
        work.startTime.year, work.startTime.month, work.startTime.day, 06, 00);
    if (work.endTime != null) {
      Duration morningDuration = Duration.zero;
      if (work.startTime.hour <= 6) {
        morningDuration = currentDayMorning.difference(work.startTime);
        totalDuration = totalDuration + morningDuration;
      }

      // toplam gece çalışmasını bulma
      DateTime currentDay = DateTime(work.startTime.year, work.startTime.month,
          work.startTime.day, 20, 00);
      while (currentDay.isBefore(work.endTime!)) {
        DateTime nextMorning = currentDay.add(const Duration(hours: 10));

        if (work.startTime.isBefore(nextMorning) &&
            work.endTime!.isAfter(currentDay)) {
          DateTime effectiveStart =
              work.startTime.isAfter(currentDay) ? work.startTime : currentDay;
          DateTime effectiveEnd =
              work.endTime!.isBefore(nextMorning) ? work.endTime! : nextMorning;
          totalDuration += effectiveEnd.difference(effectiveStart);
        }
        // Bir sonraki günün 20:00'sine geç
        currentDay = DateTime(
            currentDay.year, currentDay.month, currentDay.day + 1, 20, 0);
      }
    } else {
      Duration morningDuration = Duration.zero;
      if (work.startTime.hour <= 6) {
        morningDuration = currentDayMorning.difference(work.startTime);
        totalDuration = totalDuration + morningDuration;
      }

      DateTime currentDay = DateTime(
          work.startTime.year, work.startTime.month, work.startTime.day, 20, 0);
      while (currentDay.isBefore(DateTime.now())) {
        DateTime nextMorning = currentDay.add(const Duration(hours: 10));

        if (work.startTime.isBefore(nextMorning) &&
            DateTime.now().isAfter(currentDay)) {
          DateTime effectiveStart =
              work.startTime.isAfter(currentDay) ? work.startTime : currentDay;
          DateTime effectiveEnd = DateTime.now().isBefore(nextMorning)
              ? DateTime.now()
              : nextMorning;
          totalDuration += effectiveEnd.difference(effectiveStart);
        }
        // Bir sonraki günün 20:00'sine geç
        currentDay = DateTime(
            currentDay.year, currentDay.month, currentDay.day + 1, 20, 0);
      }
    }
    final shift = totalDuration - const Duration(hours: 7, minutes: 30);
    return shift.isNegative ? '--:--' : AppFunction.timeFormat(shift);
  }

  static String trainNumber(int? data) => data?.toString() ?? '-----';
}
