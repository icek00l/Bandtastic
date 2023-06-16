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
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
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
  Null? profile;
  Null? emailVerifiedAt;
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
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['email'] = this.email;
    data['profile'] = this.profile;
    data['email_verified_at'] = this.emailVerifiedAt;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['user_type'] = this.userType;
    data['code'] = this.code;
    data['email_verified_status'] = this.emailVerifiedStatus;
    data['first_day'] = this.firstDay;
    data['second_day'] = this.secondDay;
    return data;
  }
}
