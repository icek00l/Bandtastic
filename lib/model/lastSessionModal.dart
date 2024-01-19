// ignore_for_file: file_names

import 'dart:convert';

LastinSessionData lastDataFromJson(String str) =>
    LastinSessionData.fromJson(json.decode(str) as Map<String, dynamic>);

String lastDataToJson(LastinSessionData data) => json.encode(data.toJson());



class LastinSessionData {
  dynamic status;
  dynamic message;
  dynamic powerDifference;
  LastData? data;

  LastinSessionData({this.status, this.message,this.powerDifference, this.data});

  LastinSessionData.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    powerDifference = json['power_difference'];
    data = json['data'] != null ? LastData.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['message'] = message;
    data['power_difference'] = powerDifference;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

 class LastData {
  dynamic id;
  dynamic userId;
  dynamic sessionId;
  dynamic cycleId;
  dynamic excerciseId;
  dynamic excerciseTypeId;
  dynamic sessionType;
  dynamic bandPositionId;
  dynamic reps;
  dynamic beyondFailure;
  dynamic notes;
  dynamic matFrom;
  dynamic matTo;
  dynamic status;
  dynamic time;
  dynamic power;
  dynamic createdAt;
  dynamic updatedAt;
  BandPositon? bandPosition;
  List<UserExcerciseBand>? userExcerciseBand;

  LastData(
      {this.id,
      this.userId,
      this.sessionId,
      this.cycleId,
      this.excerciseId,
      this.excerciseTypeId,
      this.sessionType,
      this.bandPositionId,
      this.reps,
      this.beyondFailure,
      this.notes,
      this.matFrom,
      this.matTo,
      this.status,
      this.time,
      this.power,
      this.createdAt,
      this.updatedAt,
      this.bandPosition,
      this.userExcerciseBand});

  LastData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    sessionId = json['session_id'];
    cycleId = json['cycle_id'];
    excerciseId = json['excercise_id'];
    excerciseTypeId = json['excercise_type_id'];
    sessionType = json['session_type'];
    bandPositionId = json['band_position_id'];
    reps = json['reps'];
    beyondFailure = json['beyond_failure'];
    notes = json['notes'];
    matFrom = json['mat_from'];
    matTo = json['mat_to'];
    status = json['status'];
    time = json['time'];
    power = json['power'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    bandPosition = json['band_position'] != null
        ? BandPositon.fromJson(json['band_position'])
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
    data['cycle_id'] = cycleId;
    data['excercise_id'] = excerciseId;
    data['excercise_type_id'] = excerciseTypeId;
    data['session_type'] = sessionType;
    data['band_position_id'] = bandPositionId;
    data['reps'] = reps;
    data['beyond_failure'] = beyondFailure;
    data['notes'] = notes;
    data['mat_from'] = matFrom;
    data['mat_to'] = matTo;
    data['status'] = status;
    data['time'] = time;
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

class BandPositon {
 int? id;
  String? position;
  String? value;
  String? createdAt;
  String? updatedAt;

  BandPositon({this.id, this.position, this.value, this.createdAt, this.updatedAt});

  BandPositon.fromJson(Map<String, dynamic> json) {
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
  dynamic id;
  dynamic bandId;
  dynamic userExcerciseId;
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
  dynamic id;
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
