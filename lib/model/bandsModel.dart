// ignore_for_file: file_names

import 'package:flutter/material.dart';

class BandsModel {
   String? bandName;
  String? colorName;
  Color? colorValue;
 
  BandsModel({
    this.bandName,
    this.colorName,
    this.colorValue,
  });
}

class ExerciseVideoList {
  String? exerciseName;
 int? value;

  ExerciseVideoList({
    this.exerciseName,
    this.value,
  });
}

class ExtraDataList {
  String? name;
 String? value;

  ExtraDataList({
    this.name,
    this.value,
  });
}

class LastSessionPrepData {
   String? names;
  String? value;
  
 
  LastSessionPrepData({
    this.names,
    this.value,
  });
}


class ThisSessionData {
   String? names;
  
 
  ThisSessionData({
    this.names,
  });
}

class IntroDataModel {
   String? names;
  
 
  IntroDataModel({
    this.names,
  });
}