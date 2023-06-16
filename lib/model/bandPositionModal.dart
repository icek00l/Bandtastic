// ignore_for_file: file_names

import 'dart:convert';

BandPositionDataModal bandPositionFromJson(String str) =>
    BandPositionDataModal.fromJson(json.decode(str) as Map<String, dynamic>);

String bandPositionToJson(BandPositionDataModal data) => json.encode(data.toJson());


class BandPositionDataModal {
  bool? status;
  String? message;
  List<BandPositonData>? result;

  BandPositionDataModal({this.status, this.message, this.result});

  BandPositionDataModal.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['result'] != null) {
      result = <BandPositonData>[];
      json['result'].forEach((v) {
        result!.add(BandPositonData.fromJson(v));
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

class BandPositonData {
  int? id;
  String? position;
  String? createdAt;
  String? updatedAt;

  BandPositonData({this.id, this.position, this.createdAt, this.updatedAt});

  BandPositonData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    position = json['position'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['position'] = position;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}
