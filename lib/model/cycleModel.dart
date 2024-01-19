// ignore_for_file: file_names

class CycleModel {
   String? exerName;
  String? value;
 
  CycleModel({
    this.exerName,
    this.value,
  });
}
class WeekName {
   String? weekName;
 
  WeekName({
    this.weekName,
  });
}

class WeekDataModel {
   String? weekDay;
  dynamic power;
  String? value;
 
  WeekDataModel({
    this.weekDay,
    this.power,
    this.value,
  });
}