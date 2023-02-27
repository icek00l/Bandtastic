import 'package:bandapp/appstyle/app_dimensions.dart';
import 'package:bandapp/appstyle/app_strings.dart';
import 'package:bandapp/appstyle/app_themestyle.dart';
import 'package:bandapp/screen/DashboardScreens/sessionScreen/sessionMultiScreen/sessionTabbarScreen/progress_band_model.dart';
import 'package:bandapp/widgets/customBackButton.dart';
import 'package:flutter/material.dart';

class ProgressionList extends StatelessWidget {
  const ProgressionList({super.key});

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
                        bandPower[index].number.toString(),
                        textAlign: TextAlign.end,
                style: AppThemeStyle.robotoregular16,

                      ),
                      SizedBox(width: AppDimensions.five),
                      Text(
                        bandPower[index].bandName.toString(),
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
