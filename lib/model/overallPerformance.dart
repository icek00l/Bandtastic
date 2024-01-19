// ignore_for_file: file_names

import 'dart:convert';

OverallPerformanceModal overallDataFromJson(String str) =>
    OverallPerformanceModal.fromJson(json.decode(str) as Map<String, dynamic>);

String overallDataToJson(OverallPerformanceModal data) => json.encode(data.toJson());


class OverallPerformanceModal {
  int? status;
  String? message;
  List<ExerciseData>? exerciseData;

  OverallPerformanceModal({this.status, this.message, this.exerciseData});

  OverallPerformanceModal.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['ExerciseData'] != null) {
      exerciseData = <ExerciseData>[];
      json['ExerciseData'].forEach((v) {
        exerciseData!.add(ExerciseData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['message'] = message;
    if (exerciseData != null) {
      data['ExerciseData'] = exerciseData!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ExerciseData {
  String? exercise;
  List<GraphData>? data;

  ExerciseData({this.exercise, this.data});

  ExerciseData.fromJson(Map<String, dynamic> json) {
    exercise = json['name'];
    if (json['data'] != null) {
      data = <GraphData>[];
      json['data'].forEach((v) {
        data!.add(GraphData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = exercise;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class GraphData {
  String? name;
  dynamic value;

  GraphData({this.name, this.value});

  GraphData.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    value = json['value'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['value'] = value;
    return data;
  }
}
