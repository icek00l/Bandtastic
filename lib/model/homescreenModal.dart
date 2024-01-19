// ignore_for_file: file_names, unrelated_type_equality_checks

import 'dart:convert';

HomeSessionModal homeDataFromJson(String str) =>
    HomeSessionModal.fromJson(json.decode(str) as Map<String, dynamic>);

String homeDataToJson(HomeSessionModal data) => json.encode(data.toJson());


class HomeSessionModal {
  bool? status;
  dynamic message;
  HomeDataType? result;

  HomeSessionModal({this.status, this.message, this.result});

  HomeSessionModal.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    result =
        json['result'] != null ? HomeDataType.fromJson(json['result']) : null;
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

class HomeDataType {
  int? id;
  dynamic name;
  dynamic createdAt;
  dynamic updatedAt;
  Session? session;

  HomeDataType({this.id, this.name, this.createdAt, this.updatedAt, this.session});

  HomeDataType.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    session =
        json['session'] != null ? Session.fromJson(json['session']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    if (session != null) {
      data['session'] = session!.toJson();
    }
    return data;
  }
}

class Session {
  int? id;
  dynamic name;
  dynamic video;
  dynamic createdAt;
  dynamic updatedAt;
  bool? sessionComplete;
  dynamic days;
  List<ExerciseInfo>? exerciseInfo;

  Session(
      {this.id,
      this.name,
      this.video,
      this.createdAt,
      this.updatedAt,
      this.sessionComplete,
      this.days,
      this.exerciseInfo});

  Session.fromJson(Map<String, dynamic> json) {
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
        exerciseInfo!.add(ExerciseInfo.fromJson(v));
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
    if (exerciseInfo != null) {
      data['exercise_info'] =
          exerciseInfo!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ExerciseInfo {
  int? id;
  dynamic name;
  dynamic isExtra;
  dynamic createdAt;
  dynamic updatedAt;
  ExerciseType? exerciseType;

  ExerciseInfo(
      {this.id,
      this.name,
      this.isExtra,
      this.createdAt,
      this.updatedAt,
      this.exerciseType});

  ExerciseInfo.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    isExtra = json['is_extra'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    exerciseType = json['exercise_type'] != null
        ? ExerciseType.fromJson(json['exercise_type'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['is_extra'] = isExtra;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    if (exerciseType != null) {
      data['exercise_type'] = exerciseType!.toJson();
    }
    return data;
  }
}

class ExerciseType {
  int? id;
  int? sessionId;
  int? exerciseId;
  int? exerciseTypeId;
  dynamic createdAt;
  dynamic updatedAt;
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
        ? ExerciseTypeInfo.fromJson(json['exercise_type_info'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['session_id'] = sessionId;
    data['exercise_id'] = exerciseId;
    data['exercise_type_id'] = exerciseTypeId;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    if (exerciseTypeInfo != null) {
      data['exercise_type_info'] = exerciseTypeInfo!.toJson();
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
  dynamic image;
  dynamic createdAt;
  dynamic updatedAt;
  bool? isUserExcercise;
  dynamic isTrue;
  

  ExerciseTypeInfo(
      {this.id,
      this.exerciseId,
      this.name,
      this.anchor,
      this.url,
      this.image,
      this.createdAt,
      this.updatedAt,
      this.isUserExcercise,
      this.isTrue});

  ExerciseTypeInfo.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    exerciseId = json['exercise_id'];
    name = json['name'];
    anchor = json['anchor'];
    url = json['url'];
    image = json['image'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    isUserExcercise = json['is_user_Excercise'];
    isTrue = json['is_true'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['exercise_id'] = exerciseId;
    data['name'] = name;
    data['anchor'] = anchor;
    data['url'] = url;
    data['image'] = image;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['is_user_Excercise'] = isUserExcercise;
    data['is_true'] = isTrue;
   
    return data;
  }
}


class BandPosition {
  int? id;
  dynamic position;
  dynamic value;
  dynamic createdAt;
  dynamic updatedAt;

  BandPosition(
      {this.id, this.position, this.value, this.createdAt, this.updatedAt});

  BandPosition.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    position = json['position'];
    value = json['value'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['position'] = position;
    data['value'] = value;
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
  double? power;
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


