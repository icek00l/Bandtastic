
import 'dart:convert';

BandModalList bandModalFromJson(String str) =>
    BandModalList.fromJson(json.decode(str) as Map<String, dynamic>);

String bandModalToJson(BandModalList data) => json.encode(data.toJson());


class BandModalList {
  dynamic message;
  List<BandData>? band;
  List<FullList>? fullList;

  BandModalList({this.message, this.band, this.fullList});

  BandModalList.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    if (json['band'] != null) {
      band = <BandData>[];
      json['band'].forEach((v) {
        band!.add(BandData.fromJson(v));
      });
    }
    if (json['full_list'] != null) {
      fullList = <FullList>[];
      json['full_list'].forEach((v) {
        fullList!.add(FullList.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['message'] = message;
    if (band != null) {
      data['band'] = band!.map((v) => v.toJson()).toList();
    }
    if (fullList != null) {
      data['full_list'] = fullList!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class BandData {
  int? id;
  dynamic band;
  dynamic power;
  dynamic showOnHomePage;
  dynamic createdAt;
  dynamic updatedAt;

  BandData(
      {this.id,
      this.band,
      this.power,
      this.showOnHomePage,
      this.createdAt,
      this.updatedAt});

  BandData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    band = json['band'];
    power = json['power'];
    showOnHomePage = json['show_on_home_page'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['band'] = band;
    data['power'] = power;
    data['show_on_home_page'] = showOnHomePage;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}

class FullList {
  int? id;
  dynamic band;
  dynamic power;
  dynamic showOnHomePage;
  dynamic createdAt;
  dynamic updatedAt;

  FullList(
      {this.id,
      this.band,
      this.power,
      this.showOnHomePage,
      this.createdAt,
      this.updatedAt});

  FullList.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    band = json['band'];
    power = json['power'];
    showOnHomePage = json['show_on_home_page'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['band'] = band;
    data['power'] = power;
    data['show_on_home_page'] = showOnHomePage;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}


class BandProgress {
  String number;
  BandProgress(
    this.number
  );
  
}
List<BandProgress> bandNumber= [
  BandProgress("1."),
  BandProgress("2."),
  BandProgress("3."),
  BandProgress("4."),
  BandProgress("5."),
  BandProgress("6."),
  BandProgress("7."),
  BandProgress("8."),
  BandProgress("9."),
  BandProgress("10."),
  BandProgress("11."),
  BandProgress("12."),
  BandProgress("13."),
  BandProgress("14."),
  BandProgress("15."),
  BandProgress("16."),
  BandProgress("17."),
  BandProgress("18."),

  BandProgress("19."),
  BandProgress("20."),
  BandProgress("21."),
  BandProgress("22."),
  BandProgress("23."),
  BandProgress("24."),
  BandProgress("25."),
  BandProgress("26."),
  BandProgress("27."),

  BandProgress("28."),
  BandProgress("29."),
  BandProgress("30."),
];