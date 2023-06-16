// ignore_for_file: file_names

import 'dart:convert';

HomeSessionModal homeDataFromJson(String str) =>
    HomeSessionModal.fromJson(json.decode(str) as Map<String, dynamic>);

String homeDataToJson(HomeSessionModal data) => json.encode(data.toJson());

class HomeSessionModal {
  bool? status;
  String? message;
  HomeDataMain? result;

  HomeSessionModal({this.status, this.message, this.result});

  HomeSessionModal.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    result =
        json['result'] != null ? new HomeDataMain.fromJson(json['result']) : null;
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

class HomeDataMain {
  String? day;
  HomeDataType? data;

  HomeDataMain({this.day, this.data});

  HomeDataMain.fromJson(Map<String, dynamic> json) {
    day = json['day'];
    data = json['data'] != null ? new HomeDataType.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['day'] = this.day;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class HomeDataType {
  int? id;
  String? name;
  String? video;
  String? createdAt;
  String? updatedAt;
  bool? sessionComplete;
  String? days;
   List<ExerciseInfo>? exerciseInfo;

  HomeDataType(
      {this.id,
      this.name,
      this.video,
      this.createdAt,
      this.updatedAt,
      this.sessionComplete,
      this.days,
      this.exerciseInfo});

  HomeDataType.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    video = json['video'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    sessionComplete = json['session_complete'];
    days = json['days'];
    if (json['exercise_info'] != null) {
      exerciseInfo = <ExerciseInfo>[];
      json['exercise_info'].forEach((v) {
        exerciseInfo!.add(new ExerciseInfo.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['video'] = this.video;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['session_complete'] = this.sessionComplete;
    data['days'] = this.days;
    if (this.exerciseInfo != null) {
      data['exercise_info'] =
          this.exerciseInfo!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ExerciseInfo {
  int? id;
  String? name;
  String? isExtra;
  String? createdAt;
  String? updatedAt;
  int? laravelThroughKey;
  ExerciseType? exerciseType;

  ExerciseInfo(
      {this.id,
      this.name,
      this.isExtra,
      this.createdAt,
      this.updatedAt,
      this.laravelThroughKey,
      this.exerciseType});

  ExerciseInfo.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    isExtra = json['is_extra'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    laravelThroughKey = json['laravel_through_key'];
    exerciseType = json['exercise_type'] != null
        ? new ExerciseType.fromJson(json['exercise_type'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['is_extra'] = this.isExtra;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['laravel_through_key'] = this.laravelThroughKey;
    if (this.exerciseType != null) {
      data['exercise_type'] = this.exerciseType!.toJson();
    }
    return data;
  }
}

class ExerciseType {
  int? id;
  int? sessionId;
  int? exerciseId;
  int? exerciseTypeId;
  String? createdAt;
  String? updatedAt;
  ExerciseTypeInfo? exerciseTypeInfo;

  ExerciseType(
      {this.id,
      this.sessionId,
      this.exerciseId,
      this.exerciseTypeId,
      this.createdAt,
      this.updatedAt,
      this.exerciseTypeInfo});

  ExerciseType.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    sessionId = json['session_id'];
    exerciseId = json['exercise_id'];
    exerciseTypeId = json['exercise_type_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    exerciseTypeInfo = json['exercise_type_info'] != null
        ? new ExerciseTypeInfo.fromJson(json['exercise_type_info'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['session_id'] = this.sessionId;
    data['exercise_id'] = this.exerciseId;
    data['exercise_type_id'] = this.exerciseTypeId;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    if (this.exerciseTypeInfo != null) {
      data['exercise_type_info'] = this.exerciseTypeInfo!.toJson();
    }
    return data;
  }
}

class ExerciseTypeInfo {
  int? id;
  int? exerciseId;
  String? name;
  String? anchor;
  String? url;
  String? createdAt;
  String? updatedAt;
  bool? isUserExcercise;
  UserExcercise? userExcercise;

  ExerciseTypeInfo(
      {this.id,
      this.exerciseId,
      this.name,
      this.anchor,
      this.url,
      this.createdAt,
      this.updatedAt,
      this.isUserExcercise,
      this.userExcercise});

  ExerciseTypeInfo.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    exerciseId = json['exercise_id'];
    name = json['name'];
    anchor = json['anchor'];
    url = json['url'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    isUserExcercise = json['is_user_Excercise'];
    userExcercise = json['user_excercise'] != null
        ? new UserExcercise.fromJson(json['user_excercise'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['exercise_id'] = this.exerciseId;
    data['name'] = this.name;
    data['anchor'] = this.anchor;
    data['url'] = this.url;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['is_user_Excercise'] = this.isUserExcercise;
    if (this.userExcercise != null) {
      data['user_excercise'] = this.userExcercise!.toJson();
    }
    return data;
  }
}

class UserExcercise {
  int? id;
  int? userId;
  int? sessionId;
  int? excerciseId;
  int? excerciseTypeId;
  String? sessionType;
  int? bandPositionId;
  String? reps;
  String? beyondFailure;
  String? notes;
  String? status;
  String? power;
  String? createdAt;
  String? updatedAt;

  UserExcercise(
      {this.id,
      this.userId,
      this.sessionId,
      this.excerciseId,
      this.excerciseTypeId,
      this.sessionType,
      this.bandPositionId,
      this.reps,
      this.beyondFailure,
      this.notes,
      this.status,
      this.power,
      this.createdAt,
      this.updatedAt});

  UserExcercise.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    sessionId = json['session_id'];
    excerciseId = json['excercise_id'];
    excerciseTypeId = json['excercise_type_id'];
    sessionType = json['session_type'];
    bandPositionId = json['band_position_id'];
    reps = json['reps'];
    beyondFailure = json['beyond_failure'];
    notes = json['notes'];
    status = json['status'];
    power = json['power'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user_id'] = this.userId;
    data['session_id'] = this.sessionId;
    data['excercise_id'] = this.excerciseId;
    data['excercise_type_id'] = this.excerciseTypeId;
    data['session_type'] = this.sessionType;
    data['band_position_id'] = this.bandPositionId;
    data['reps'] = this.reps;
    data['beyond_failure'] = this.beyondFailure;
    data['notes'] = this.notes;
    data['status'] = this.status;
    data['power'] = this.power;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}