// ignore_for_file: file_names

import 'dart:convert';

GeneralDataModel generalDataFromJson(String str) =>
    GeneralDataModel.fromJson(json.decode(str) as Map<String, dynamic>);

String generalDataToJson(GeneralDataModel data) => json.encode(data.toJson());


class GeneralDataModel {
  int? status;
  String? appVersion;
  String? emailVerificationMessage;
  Data? data;

  GeneralDataModel(
      {this.status, this.appVersion, this.emailVerificationMessage, this.data});

  GeneralDataModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    appVersion = json['app_version'];
    emailVerificationMessage = json['email_verification_message'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['app_version'] = appVersion;
    data['email_verification_message'] = emailVerificationMessage;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  List<WelcomeScreens>? welcomeScreens;
  List<TrainingScreens>? trainingScreens;

  Data({this.welcomeScreens, this.trainingScreens});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['welcome_screens'] != null) {
      welcomeScreens = <WelcomeScreens>[];
      json['welcome_screens'].forEach((v) {
        welcomeScreens!.add(WelcomeScreens.fromJson(v));
      });
    }
    if (json['training_screens'] != null) {
      trainingScreens = <TrainingScreens>[];
      json['training_screens'].forEach((v) {
        trainingScreens!.add(TrainingScreens.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (welcomeScreens != null) {
      data['welcome_screens'] =
          welcomeScreens!.map((v) => v.toJson()).toList();
    }
    if (trainingScreens != null) {
      data['training_screens'] =
          trainingScreens!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class WelcomeScreens {
  String? title;
  String? subtitle;
  String? video;

  WelcomeScreens({this.title, this.subtitle, this.video});

  WelcomeScreens.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    subtitle = json['subtitle'];
    video = json['video'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['title'] = title;
    data['subtitle'] = subtitle;
    data['video'] = video;
    return data;
  }
}

class TrainingScreens {
  String? title;
  String? subtitle;
  String? video;

  TrainingScreens({this.title, this.subtitle, this.video});

  TrainingScreens.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    subtitle = json['subtitle'];
    video = json['video'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['title'] = title;
    data['subtitle'] = subtitle;
    data['video'] = video;
    return data;
  }
}
