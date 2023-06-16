// ignore_for_file: file_names

import 'dart:convert';

RegisterModel registerFromJson(String str) =>
    RegisterModel.fromJson(json.decode(str) as Map<String, dynamic>);

String registerToJson(RegisterModel data) => json.encode(data.toJson());



class RegisterModel {
  bool? status;
  String? message;
  Result? result;
  RegisterModel({this.status, this.message, this.result});
  RegisterModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    result =
        json['result'] != null ? Result.fromJson(json['result']) : null;
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['message'] = message;
    if (result != null) {
      data['result'] = result!.toJson();
    }
    return data;
  }
}

class Result {
  Data? data;
  String? token;
  MailStatus? mailStatus;
  Result({this.data, this.token, this.mailStatus});
  Result.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
    token = json['token'];
    mailStatus = json['mail_status'] != null
        ? MailStatus.fromJson(json['mail_status'])
        : null;
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    data['token'] = token;
    if (mailStatus != null) {
      data['mail_status'] = mailStatus!.toJson();
    }
    return data;
  }
}

class Data {
  int? id;
  String? name;
  String? email;
  dynamic emailVerifiedAt;
  String? createdAt;
  String? updatedAt;
  String? userType;
  String? code;
  int? emailVerifiedStatus;
  String? firstDay;
  String? secondDay;
  Data(
      {this.id,
      this.name,
      this.email,
      this.emailVerifiedAt,
      this.createdAt,
      this.updatedAt,
      this.userType,
      this.code,
      this.emailVerifiedStatus,
      this.firstDay,
      this.secondDay});
  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    emailVerifiedAt = json['email_verified_at'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    userType = json['user_type'];
    code = json['code'];
    emailVerifiedStatus = json['email_verified_status'];
    firstDay = json['first_day'];
    secondDay = json['second_day'];
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['email'] = email;
    data['email_verified_at'] = emailVerifiedAt;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['user_type'] = userType;
    data['code'] = code;
    data['email_verified_status'] = emailVerifiedStatus;
    data['first_day'] = firstDay;
    data['second_day'] = secondDay;
    return data;
  }
}

class MailStatus {
  bool? staus;
  String? messge;
  MailStatus({this.staus, this.messge});
  MailStatus.fromJson(Map<String, dynamic> json) {
    staus = json['staus'];
    messge = json['messge'];
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['staus'] = staus;
    data['messge'] = messge;
    return data;
  }
}
