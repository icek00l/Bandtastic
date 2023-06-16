// ignore_for_file: avoid_print

import 'dart:convert';

import 'package:bandapp/appstyle/app_dimensions.dart';
import 'package:bandapp/appstyle/app_strings.dart';
import 'package:bandapp/appstyle/app_themestyle.dart';
import 'package:bandapp/navigation/app_route_maps.dart';
import 'package:bandapp/network_requests/network_requests.dart';
import 'package:bandapp/screen/DashboardScreens/sessionScreen/sessionMultiScreen/sessionTabbarScreen/progress_band_model.dart';
import 'package:bandapp/utility/sharePrefs/shared_pref_key.dart';
import 'package:bandapp/utility/sharePrefs/shared_prefs.dart';
import 'package:bandapp/widgets/customBackButton.dart';
import 'package:flutter/material.dart';

class ProgressionList extends StatefulWidget {
  const ProgressionList({super.key});

  @override
  State<ProgressionList> createState() => _ProgressionListState();
}

class _ProgressionListState extends State<ProgressionList> {
  String getToken = '';
  var apiClient = ApiClient();
  List<BandData> bandPower = List.empty(growable: true);
  @override
  void initState() {
    SharedPrefs.getString(SharedPrefKeys.token).then((value) {
      if (value != "0") {
        getToken = value;
        print("value has data $getToken");
        getBandProgressList();
      }
    });
    super.initState();
  }

  void getBandProgressList() async {
    bandPower.clear();
    var res = await apiClient.getBandProgressData(token: getToken, isLoading: true);

    print(res);

    if (jsonDecode(res.body)['status'] != false) {
      var data1 = bandModalFromJson(res.body);

      print(data1);
      bandPower = data1.result!;
      print(bandPower);
    } else {
       if (jsonDecode(res.body)['message'] == "Unauthenticated.") {
        SharedPrefs.clear();
        AppRouteMaps.goTowalkthrough();
      }
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) => Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
          preferredSize:
              Size.fromHeight(AppDimensions.seventy), // here the desired height
          child: AppBar(
            automaticallyImplyLeading: false,
            backgroundColor: Colors.white,
            elevation: AppDimensions.zero,
            title: CustomWithTextHeader(
              getHeadingText: "Band  Progression  List",
              isBackAllow: true,
              navigateBack: () {
                Navigator.pop(context);
              },
            ),
          )),
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: AppDimensions.twenty),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    width: AppDimensions.twoFifty,
                    alignment: Alignment.centerLeft,
                    child: Text(
                      AppStrings.bandtext.toUpperCase(),
                      textAlign: TextAlign.end,
                      style: AppThemeStyle.bandProgess,
                    ),
                  ),
                  Expanded(
                      child: Text(
                    AppStrings.powerText.toUpperCase(),
                    style: AppThemeStyle.bandProgess,
                  )),
                ],
              ),
              SizedBox(height: AppDimensions.twenty),
              powerValueandName(),
              // SizedBox(height: AppDimensions.fifty),
            ],
          ),
        ),
      ));

  Widget powerValueandName() {
    return ListView.builder(
      itemCount: bandPower.length,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) {
        return Container(
          margin: EdgeInsets.only(bottom: AppDimensions.five),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                  width: AppDimensions.twoFifty,
                  alignment: Alignment.centerLeft,
                  child: Row(
                    children: [
                      Text(
                        bandNumber[index].number.toString(),
                        textAlign: TextAlign.end,
                        style: AppThemeStyle.robotoregular16,
                      ),
                      SizedBox(width: AppDimensions.five),
                      Text(
                        bandPower[index].band.toString(),
                        textAlign: TextAlign.start,
                        style: AppThemeStyle.robotoregular16,
                      ),
                    ],
                  )),
              Expanded(
                  child: Text(
                bandPower[index].power.toString(),
                style: AppThemeStyle.robotoregular16,
              )),
            ],
          ),
        );
      },
    );
  }
}
