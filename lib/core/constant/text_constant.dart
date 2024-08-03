import 'package:syncfusion_flutter_calendar/calendar.dart';

import '../function/hour_function.dart';
import '../model/work_model.dart';

final class TextConstant {
  static List<String> data({required WorkModel model, required CalendarAppointmentDetails detail}) {
    return [
      model.machinist,
      'Giden: ${model.trainNumber}  -  Gelen: ${HourFunction.trainNumber(model.trainNumberTwo)}',
      'İşe Başlama: ${HourFunction.getStartTime(model, detail.date)}, İş Bitiş: ${HourFunction.getEndTime(model, detail.date)}',
      'Gece Çalışması: ${HourFunction.getNightWorking(model, detail.date)}',
      'Fiili Çalışma: ${HourFunction.getActiveWorking(model, detail.date)}',
      'Gece Çalışması Aşan Kısım: ${HourFunction.getNightWorkShift(model, detail.date)}',
    ];
  }
}
