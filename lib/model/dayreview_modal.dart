
import 'dart:convert';

DayReviewData dayReviewDataFromJson(String str) =>
    DayReviewData.fromJson(json.decode(str) as Map<String, dynamic>);

String dayReviewDataToJson(DayReviewData data) => json.encode(data.toJson());

class DayReviewData {
  int? status;
  String? message;
  List<ExerciseData>? exerciseData;

  DayReviewData({this.status, this.message, this.exerciseData});

  DayReviewData.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['exerciseData'] != null) {
      exerciseData = <ExerciseData>[];
      json['exerciseData'].forEach((v) {
        exerciseData!.add(ExerciseData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['message'] = message;
    if (exerciseData != null) {
      data['exerciseData'] = exerciseData!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ExerciseData {
  String? exercise;
  dynamic overallTotal;
  List<Data>? data;

  ExerciseData({this.exercise, this.overallTotal, this.data});

  ExerciseData.fromJson(Map<String, dynamic> json) {
    exercise = json['exercise'];
    overallTotal = json['overall_total'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['exercise'] = exercise;
    data['overall_total'] = overallTotal;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  String? name;
  dynamic value;
  dynamic totalPower;

  Data({this.name, this.value, this.totalPower});

  Data.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    value = json['value'];
    totalPower = json['total_power'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['value'] = value;
    data['total_power'] = totalPower;
    return data;
  }
}
