// ignore_for_file: file_names

import 'dart:convert';

IntroDuctionModal introDataFromJson(String str) =>
    IntroDuctionModal.fromJson(json.decode(str) as Map<String, dynamic>);

String introDataToJson(IntroDuctionModal data) => json.encode(data.toJson());

class IntroDuctionModal {
  dynamic status;
  String? message;
  List<IntroData>? result;
  dynamic sessionID;
  dynamic day;


  IntroDuctionModal({this.status, this.message, this.result,this.sessionID,this.day});

  IntroDuctionModal.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['result'] != null) {
      result = <IntroData>[];
      json['result'].forEach((v) {
        result!.add(IntroData.fromJson(v));
      });
    }
    sessionID = json['session_id'];
    day = json['day'];

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['message'] = message;
    if (result != null) {
      data['result'] = result!.map((v) => v.toJson()).toList();
    }
    data['session_id'] = sessionID;
    data['day'] = day;

    return data;
  }
}

class IntroData {
  int? id;
  String? title;
  String? url;
  String? createdAt;
  String? updatedAt;
  bool isListSelect = false;
  List<IntroContent>? introContent;

  IntroData(
      {this.id,
      this.title,
      this.url,
      this.createdAt,
      this.updatedAt,
      this.introContent});

  IntroData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    url = json['url'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    if (json['intro_content'] != null) {
      introContent = <IntroContent>[];
      json['intro_content'].forEach((v) {
        introContent!.add(IntroContent.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['title'] = title;
    data['url'] = url;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    if (introContent != null) {
      data['intro_content'] = introContent!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class IntroContent {
  int? id;
  int? introId;
  String? title;
  String? url;
  String? createdAt;
  String? updatedAt;

  IntroContent(
      {this.id,
      this.introId,
      this.title,
      this.url,
      this.createdAt,
      this.updatedAt});

  IntroContent.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    introId = json['intro_id'];
    title = json['title'];
    url = json['url'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['intro_id'] = introId;
    data['title'] = title;
    data['url'] = url;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}
