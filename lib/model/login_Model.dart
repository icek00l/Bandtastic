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
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.result != null) {
      data['result'] = this.result!.toJson();
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
        userInfo!.add(new UserInfo.fromJson(v));
      });
    }
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['code'] = this.code;
    data['red_belt_qty'] = this.redBeltQty;
    data['green_belt_qty'] = this.greenBeltQty;
    data['yellow_belt_qty'] = this.yellowBeltQty;
    data['black_belt_qty'] = this.blackBeltQty;
    data['purple_belt_qty'] = this.purpleBeltQty;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['delete_status'] = this.deleteStatus;
    data['assign_status'] = this.assignStatus;
    data['token'] = this.token;
    if (this.userInfo != null) {
      data['user_info'] = this.userInfo!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class UserInfo {
  int? id;
  String? name;
  String? email;
  Null? emailVerifiedAt;
  String? createdAt;
  String? updatedAt;
  String? userType;
  String? code;
  int? emailVerifiedStatus;
  String? firstDay;
  String? secondDay;
  UserInfo(
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
    firstDay = json['first_day'];
    secondDay = json['second_day'];
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['email'] = this.email;
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
