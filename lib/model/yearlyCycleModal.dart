// ignore_for_file: file_names

import 'dart:convert';

CycleYearlyModel cycleYearDataFromJson(String str) =>
    CycleYearlyModel.fromJson(json.decode(str) as Map<String, dynamic>);

String cycleYearDataToJson(CycleYearlyModel data) => json.encode(data.toJson());


class CycleYearlyModel {
  int? status;
  String? message;
  List<YearlyData>? yearlyData;

  CycleYearlyModel({this.status, this.message, this.yearlyData});

  CycleYearlyModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['yearlyData'] != null) {
      yearlyData = <YearlyData>[];
      json['yearlyData'].forEach((v) {
        yearlyData!.add(YearlyData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['message'] = message;
    if (yearlyData != null) {
      data['yearlyData'] = yearlyData!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class YearlyData {
  int? cycleId;
  String? cycle;
  List<Data>? data;

  YearlyData({this.cycleId, this.cycle, this.data});

  YearlyData.fromJson(Map<String, dynamic> json) {
    cycleId = json['cycle_id'];
    cycle = json['cycle'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['cycle_id'] = cycleId;
    data['cycle'] = cycle;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  String? exercise;
  dynamic power;

  Data({this.exercise, this.power});

  Data.fromJson(Map<String, dynamic> json) {
    exercise = json['Exercise'];
    power = json['Power'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['Exercise'] = exercise;
    data['Power'] = power;
    return data;
  }
}

