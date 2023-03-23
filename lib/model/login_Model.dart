// ignore_for_file: file_names
import 'dart:convert';

LoginModel loginFromJson(String str) =>
    LoginModel.fromJson(json.decode(str) as Map<String, dynamic>);

String loginToJson(LoginModel data) => json.encode(data.toJson());

class LoginModel {
  bool? status;
  String? message;
  Result? result;

  LoginModel({this.status, this.message, this.result});

  LoginModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    result =
        json['result'] != null ?  Result.fromJson(json['result']) : null;
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
  int? id;
  String? title;
  String? code;
  String? redBeltQty;
  String? greenBeltQty;
  String? yellowBeltQty;
  String? blackBeltQty;
  String? purpleBeltQty;
  String? createdAt;
  String? updatedAt;
  int? deleteStatus;
  int? assignStatus;
  String? token;
  List<UserInfo>? userInfo;

  Result(
      {this.id,
      this.title,
      this.code,
      this.redBeltQty,
      this.greenBeltQty,
      this.yellowBeltQty,
      this.blackBeltQty,
      this.purpleBeltQty,
      this.createdAt,
      this.updatedAt,
      this.deleteStatus,
      this.assignStatus,
      this.token,
      this.userInfo});

  Result.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    code = json['code'];
    redBeltQty = json['red_belt_qty'];
    greenBeltQty = json['green_belt_qty'];
    yellowBeltQty = json['yellow_belt_qty'];
    blackBeltQty = json['black_belt_qty'];
    purpleBeltQty = json['purple_belt_qty'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    deleteStatus = json['delete_status'];
    assignStatus = json['assign_status'];
    token = json['token'];
    if (json['user_info'] != null) {
      userInfo = <UserInfo>[];
      json['user_info'].forEach((v) {
        userInfo!.add( UserInfo.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['title'] = title;
    data['code'] = code;
    data['red_belt_qty'] = redBeltQty;
    data['green_belt_qty'] = greenBeltQty;
    data['yellow_belt_qty'] = yellowBeltQty;
    data['black_belt_qty'] = blackBeltQty;
    data['purple_belt_qty'] = purpleBeltQty;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['delete_status'] = deleteStatus;
    data['assign_status'] = assignStatus;
    data['token'] = token;
    if (userInfo != null) {
      data['user_info'] = userInfo!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class UserInfo {
  int? id;
  String? name;
  String? email;
  dynamic emailVerifiedAt;
  String? createdAt;
  String? updatedAt;
  String? userType;
  String? code;
  int? emailVerifiedStatus;

  UserInfo(
      {this.id,
      this.name,
      this.email,
      this.emailVerifiedAt,
      this.createdAt,
      this.updatedAt,
      this.userType,
      this.code,
      this.emailVerifiedStatus});

  UserInfo.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    emailVerifiedAt = json['email_verified_at'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    userType = json['user_type'];
    code = json['code'];
    emailVerifiedStatus = json['email_verified_status'];
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
    return data;
  }
}