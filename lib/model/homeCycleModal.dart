// ignore_for_file: file_names

import 'dart:convert';

HomeCycleModal cycleDataFromJson(String str) =>
    HomeCycleModal.fromJson(json.decode(str) as Map<String, dynamic>);

String cycleDataToJson(HomeCycleModal data) => json.encode(data.toJson());

class HomeCycleModal {
  int? status;
  String? message;
  dynamic weekNumber;
  List<CycleHomeData>? data;
  dynamic dailySessionNumber;

  HomeCycleModal({this.status, this.message,this.weekNumber, this.data,this.dailySessionNumber});

  HomeCycleModal.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    weekNumber = json['Week Number'];
    if (json['data'] != null) {
      data = <CycleHomeData>[];
      json['data'].forEach((v) {
        data!.add(CycleHomeData.fromJson(v));
      });
    }
    dailySessionNumber = json['daily_session_number'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['message'] = message;
    data['Week Number'] = weekNumber;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    data['daily_session_number'] = dailySessionNumber;
    return data;
  }
}

class CycleHomeData {
  String? name;
  dynamic power;

  CycleHomeData({this.name, this.power});

  CycleHomeData.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    power = json['power'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['power'] = power;
    return data;
  }
}
