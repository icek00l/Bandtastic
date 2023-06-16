// ignore_for_file: file_names

import 'dart:convert';

LastinSessionData lastDataFromJson(String str) =>
    LastinSessionData.fromJson(json.decode(str) as Map<String, dynamic>);

String lastDataToJson(LastinSessionData data) => json.encode(data.toJson());



class LastinSessionData {
  int? status;
  String? message;
  LastData? data;

  LastinSessionData({this.status, this.message, this.data});

  LastinSessionData.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? LastData.fromJson(json['data']) : null;
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

class LastData {
  int? id;
  int? userId;
  int? sessionId;
  dynamic excerciseId;
  int? excerciseTypeId;
  String? sessionType;
  int? bandPositionId;
  String? reps;
  String? beyondFailure;
  String? notes;
  String? power;
  dynamic createdAt;
  dynamic updatedAt;
  BandPosition? bandPosition;
  List<UserExcerciseBand>? userExcerciseBand;

  LastData(
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
      this.bandPosition,
      this.userExcerciseBand});

  LastData.fromJson(Map<String, dynamic> json) {
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
  String? position;
  String? createdAt;
  String? updatedAt;

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
  Band? band;

  UserExcerciseBand(
      {this.id,
      this.bandId,
      this.userExcerciseId,
      this.createdAt,
      this.updatedAt,
      this.band});

  UserExcerciseBand.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    bandId = json['band_id'];
    userExcerciseId = json['user_excercise_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    band = json['band'] != null ? Band.fromJson(json['band']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['band_id'] = bandId;
    data['user_excercise_id'] = userExcerciseId;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    if (band != null) {
      data['band'] = band!.toJson();
    }
    return data;
  }
}

class Band {
  int? id;
  String? band;
  dynamic power;
  String? createdAt;
  String? updatedAt;

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
