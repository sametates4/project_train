import '../function/hour_function.dart';
import '../model/mileage_compensation_model.dart';
import '../model/work_model.dart';

final class TextConstant {
  static List<String> data({required WorkModel model, required DateTime date}) {

    return [
      model.machinist ?? '',
      'Giden: ${HourFunction.trainNumber(model.trainNumber)}  -  Gelen: ${HourFunction.trainNumber(model.trainNumberTwo)}',
      'Görev Alma: ${HourFunction.getStartTime(model, date)}, İş Bitiş: ${HourFunction.getEndTime(model, date)}',
      'Fiili Çalışma: ${HourFunction.getActiveWorking(model, date)}',
      'Gece Çalışması: ${HourFunction.getNightWorking(model, date)}',
      'Gece Çalışması Aşan Kısım: ${HourFunction.getNightWorkShift(model, date)}',
      // for(var mileage in model.mileageList ?? []) ... [
      //   'Çıkış: ${mileage.startStation} - Varış: ${mileage.intermediateStation == null ? mileage.endStation : ' ${mileage.intermediateStation} / ${mileage.endStation}'}',
      //   '45 Açılış: ${HourFunction.getTime(mileage.startTime)}, 45 Kapanış: ${HourFunction.getTime(mileage.endTime)}',
      //   'Vazifeli: ${HourFunction.getMileageTime(mileage.startTime, mileage.endTime)}, '
      //       'Tren Şefi: ${HourFunction.getChefTime(mileage.startTime, mileage.endTime, model.trainNumber)}'
      // ]

    ];
  }

  static List<String> mileageDate({required MileageCompensationModel mileage, required int trainNumber}) {
    return [
      'Çıkış: ${mileage.startStation} - Varış: ${mileage.intermediateStation == null ? mileage.endStation : ' ${mileage.intermediateStation} / ${mileage.endStation}'}',
      '45 Açılış: ${HourFunction.getTime(mileage.startTime)}, 45 Kapanış: ${HourFunction.getTime(mileage.endTime)}',
      'Vazifeli: ${HourFunction.getMileageTime(mileage.startTime, mileage.endTime)}, '
          'Tren Şefi: ${HourFunction.getChefTime(mileage.startTime, mileage.endTime, trainNumber)}'

    ];
  }
}
