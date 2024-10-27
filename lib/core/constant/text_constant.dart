import '../function/hour_function.dart';
import '../model/work_model.dart';

final class TextConstant {
  static List<String> data({required WorkModel model, required DateTime date}) {
    return [
      model.machinist ?? '',
      'Giden: ${model.trainNumber}  -  Gelen: ${HourFunction.trainNumber(model.trainNumberTwo)}',
      'İşe Başlama: ${HourFunction.getStartTime(model, date)}, İş Bitiş: ${HourFunction.getEndTime(model, date)}',
      'Gece Çalışması: ${HourFunction.getNightWorking(model, date)}',
      'Fiili Çalışma: ${HourFunction.getActiveWorking(model, date)}',
      'Gece Çalışması Aşan Kısım: ${HourFunction.getNightWorkShift(model, date)}',
    ];
  }
}
