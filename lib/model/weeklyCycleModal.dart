class WeeklyCycleModal {
  int? status;
  String? message;
  List<WeeklyData>? weeklyData;

  WeeklyCycleModal({this.status, this.message, this.weeklyData});

  WeeklyCycleModal.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['weeklyData'] != null) {
      weeklyData = <WeeklyData>[];
      json['weeklyData'].forEach((v) {
        weeklyData!.add(new WeeklyData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['message'] = message;
    if (weeklyData != null) {
      data['weeklyData'] = weeklyData!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class WeeklyData {
  String? thisWeek;
  String? day;
  List<Data>? data;

  WeeklyData({this.thisWeek, this.day, this.data});

  WeeklyData.fromJson(Map<String, dynamic> json) {
    thisWeek = json['thisWeek'];
    day = json['day'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add( Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['thisWeek'] = thisWeek;
    data['day'] = day;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  String? exercise;
  String? date;
  int? power;

  Data({this.exercise, this.date, this.power});

  Data.fromJson(Map<String, dynamic> json) {
    exercise = json['Exercise'];
    date = json['Date'];
    power = json['Power'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['Exercise'] = exercise;
    data['Date'] = date;
    data['Power'] = power;
    return data;
  }
}
