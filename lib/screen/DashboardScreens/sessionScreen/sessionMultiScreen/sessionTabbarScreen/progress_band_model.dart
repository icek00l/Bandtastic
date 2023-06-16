
import 'dart:convert';

BandModalList bandModalFromJson(String str) =>
    BandModalList.fromJson(json.decode(str) as Map<String, dynamic>);

String bandModalToJson(BandModalList data) => json.encode(data.toJson());


class BandModalList {
  bool? status;
  String? message;
  List<BandData>? result;

  BandModalList({this.status, this.message, this.result});

  BandModalList.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['result'] != null) {
      result = <BandData>[];
      json['result'].forEach((v) {
        result!.add(BandData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['message'] = message;
    if (result != null) {
      data['result'] = result!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class BandData {
  int? id;
  String? band;
  dynamic power;
  String? createdAt;
  String? updatedAt;

  BandData({this.id, this.band, this.power, this.createdAt, this.updatedAt});

  BandData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    band = json['band'];
    power = json['power'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['band'] = band;
    data['power'] = power;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}

class BandProgress {
  String number;
  BandProgress(
    this.number
  );
  
}
List<BandProgress> bandNumber= [
  BandProgress("1."),
  BandProgress("2."),
  BandProgress("3."),
  BandProgress("4."),
  BandProgress("5."),
  BandProgress("6."),
  BandProgress("7."),
  BandProgress("8."),
  BandProgress("9."),
  BandProgress("10."),
  BandProgress("11."),
  BandProgress("12."),
  BandProgress("13."),
  BandProgress("14."),
  BandProgress("15."),
  BandProgress("16."),
  BandProgress("17."),
  BandProgress("18."),
];