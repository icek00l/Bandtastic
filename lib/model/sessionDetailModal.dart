// ignore_for_file: file_names

import 'dart:convert';

SessionDataModal sessionDataFromJson(String str) =>
    SessionDataModal.fromJson(json.decode(str) as Map<String, dynamic>);

String sessionDataToJson(SessionDataModal data) => json.encode(data.toJson());

class SessionDataModal {
  int? status;
  dynamic message;
  SessionData? data;

  SessionDataModal({this.status, this.message, this.data});

  SessionDataModal.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? SessionData.fromJson(json['data']) : null;
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

class SessionData {
  int? id;
  dynamic name;
  dynamic video;
  dynamic createdAt;
  dynamic updatedAt;
  bool? sessionComplete;
  dynamic days;
  List<ExerciseTypeInfo>? exerciseTypeInfo;

  SessionData(
      {this.id,
      this.name,
      this.video,
      this.createdAt,
      this.updatedAt,
      this.sessionComplete,
      this.days,
      this.exerciseTypeInfo});

  SessionData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    video = json['video'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    sessionComplete = json['session_complete'];
    days = json['days'];
    if (json['exercise_type_info'] != null) {
      exerciseTypeInfo = <ExerciseTypeInfo>[];
      json['exercise_type_info'].forEach((v) {
        exerciseTypeInfo!.add(ExerciseTypeInfo.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['video'] = video;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['session_complete'] = sessionComplete;
    data['days'] = days;
    if (exerciseTypeInfo != null) {
      data['exercise_type_info'] =
          exerciseTypeInfo!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ExerciseTypeInfo {
  int? id;
  int? exerciseId;
  dynamic name;
  dynamic anchor;
  dynamic url;
  dynamic createdAt;
  dynamic updatedAt;
  int? laravelThroughKey;
  bool? isUserExcercise;
  UserExcercise? userExcercise;
  List<ResponseSession>? responseDataSession=[];

  ExerciseTypeInfo(
      {this.id,
      this.exerciseId,
      this.name,
      this.anchor,
      this.url,
      this.createdAt,
      this.updatedAt,
      this.laravelThroughKey,
      this.isUserExcercise,
      this.userExcercise,
      this.responseDataSession});

  ExerciseTypeInfo.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    exerciseId = json['exercise_id'];
    name = json['name'];
    anchor = json['anchor'];
    url = json['url'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    laravelThroughKey = json['laravel_through_key'];
    isUserExcercise = json['is_user_Excercise'];
    userExcercise = json['user_excercise'] != null
        ? UserExcercise.fromJson(json['user_excercise'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['exercise_id'] = exerciseId;
    data['name'] = name;
    data['anchor'] = anchor;
    data['url'] = url;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['laravel_through_key'] = laravelThroughKey;
    data['is_user_Excercise'] = isUserExcercise;
    if (userExcercise != null) {
      data['user_excercise'] = userExcercise!.toJson();
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
  dynamic sessionType;
  int? bandPositionId;
  dynamic reps;
  dynamic beyondFailure;
  dynamic notes;
  dynamic power;
  dynamic createdAt;
  dynamic updatedAt;
  dynamic status;
  BandPosition? bandPosition;
  List<UserExcerciseBand>? userExcerciseBand;

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
      this.power,
      this.createdAt,
      this.updatedAt,
      this.status,
      this.bandPosition,
      this.userExcerciseBand});

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
    power = json['power'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    status = json['status'];
    bandPosition = json['band_position'] != null
        ? BandPosition.fromJson(json['band_position'])
        : null;
    if (json['user_excercise_band'] != null) {
      userExcerciseBand = <UserExcerciseBand>[];
      json['user_excercise_band'].forEach((v) {
        userExcerciseBand!.add(UserExcerciseBand.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['user_id'] = userId;
    data['session_id'] = sessionId;
    data['excercise_id'] = excerciseId;
    data['excercise_type_id'] = excerciseTypeId;
    data['session_type'] = sessionType;
    data['band_position_id'] = bandPositionId;
    data['reps'] = reps;
    data['beyond_failure'] = beyondFailure;
    data['notes'] = notes;
    data['power'] = power;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['status'] = status;
    if (bandPosition != null) {
      data['band_position'] = bandPosition!.toJson();
    }
    if (userExcerciseBand != null) {
      data['user_excercise_band'] =
          userExcerciseBand!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class BandPosition {
  int? id;
  dynamic position;
  dynamic createdAt;
  dynamic updatedAt;

  BandPosition({this.id, this.position, this.createdAt, this.updatedAt});

  BandPosition.fromJson(Map<String, dynamic> json) {
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

class UserExcerciseBand {
  int? id;
  int? bandId;
  int? userExcerciseId;
  dynamic createdAt;
  dynamic updatedAt;
  dynamic bandName;
  dynamic power;
  Band? band;

  UserExcerciseBand(
      {this.id,
      this.bandId,
      this.userExcerciseId,
      this.createdAt,
      this.updatedAt,
      this.bandName,
      this.power,
      this.band});

  UserExcerciseBand.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    bandId = json['band_id'];
    userExcerciseId = json['user_excercise_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    bandName = json['band_name'];
    power = json['power'];
    band = json['band'] != null ? Band.fromJson(json['band']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['band_id'] = bandId;
    data['user_excercise_id'] = userExcerciseId;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['band_name'] = bandName;
    data['power'] = power;
    if (band != null) {
      data['band'] = band!.toJson();
    }
    return data;
  }
}

class Band {
  int? id;
  dynamic band;
  dynamic power;
  dynamic createdAt;
  dynamic updatedAt;

  Band({this.id, this.band, this.power, this.createdAt, this.updatedAt});

  Band.fromJson(Map<String, dynamic> json) {
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

class ResponseSession {
  String? name;
  String? value;

  ResponseSession({this.name, this.value});
}
