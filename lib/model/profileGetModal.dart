// ignore_for_file: file_names

import 'dart:convert';

ProfileGetModal profileDataFromJson(String str) =>
    ProfileGetModal.fromJson(json.decode(str) as Map<String, dynamic>);

String profileDataToJson(ProfileGetModal data) => json.encode(data.toJson());


class ProfileGetModal {
  int? status;
  String? message;
  Data? data;

  ProfileGetModal({this.status, this.message, this.data});

  ProfileGetModal.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['message'] = message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  int? id;
  String? name;
  String? email;
  dynamic profile;
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
      this.profile,
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
    profile = json['profile'];
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
    data['profile'] = profile;
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
