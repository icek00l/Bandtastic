
import 'dart:convert';

WeeklyCycleModal weeklyCycleDataFromJson(String str) =>
    WeeklyCycleModal.fromJson(json.decode(str) as Map<String, dynamic>);

String weeklyCycleDataToJson(WeeklyCycleModal data) => json.encode(data.toJson());

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
        weeklyData!.add(WeeklyData.fromJson(v));
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
  String? session;
  int? sessionId;
  List<Data>? data;

  WeeklyData({this.session, this.sessionId, this.data});

  WeeklyData.fromJson(Map<String, dynamic> json) {
    session = json['session'];
    sessionId = json['session_id'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['session'] = session;
    data['session_id'] = sessionId;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  String? exerciseType;
  int? exerciseTypeId;
  dynamic power;

  Data({this.exerciseType, this.exerciseTypeId, this.power});

  Data.fromJson(Map<String, dynamic> json) {
    exerciseType = json['Exercise Type'];
    exerciseTypeId = json['Exercise Type Id'];
    power = json['Power'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['Exercise Type'] = exerciseType;
    data['Exercise Type Id'] = exerciseTypeId;
    data['Power'] = power;
    return data;
  }
}

