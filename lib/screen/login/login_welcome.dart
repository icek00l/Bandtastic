import 'package:bandapp/appstyle/app_colors.dart';
import 'package:bandapp/appstyle/app_dimensions.dart';
import 'package:bandapp/appstyle/app_themestyle.dart';
import 'package:bandapp/appstyle/assetbase.dart';
import 'package:bandapp/navigation/app_route_maps.dart';
import 'package:bandapp/widgets/buttonBackground.dart';
import 'package:flutter/material.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:flutter_svg/svg.dart';

class LoginWelcomeView extends StatefulWidget {
  const LoginWelcomeView({Key? key}) : super(key: key);

  @override
  State<LoginWelcomeView> createState() => _LoginWelcomeViewState();
}

class _LoginWelcomeViewState extends State<LoginWelcomeView> {
  

  @override
  Widget build(BuildContext context) => Scaffold(
          body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Image.asset(contents[i].image!,height:MediaQuery.of(context).size.height /1.7,width: double.infinity,fit: BoxFit.cover,),
          ClipPath(
              clipper: DiagonalPathClipperOne(),
              child: Container(
                height: MediaQuery.of(context).size.height / 1.6,
                width: double.infinity,
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                    colors: [
                      AppColors.gradientColor1,
                      AppColors.gradientColor2
                    ],
                  ),
                ),
                alignment: Alignment.center,
                child: SvgPicture.asset(AssetsBase.playCircleSvg),
              )),
          Container(
            margin: EdgeInsets.symmetric(
              horizontal: AppDimensions.twenty,
            ),
            child: Text("High M.O.R.A.L.E \nClub",
                maxLines: 2, style: AppThemeStyle.heading28Bold),
          ),
          ButtonCommon16Class(
              onTap: (p0) {
                AppRouteMaps.goToLoginPage(false);
              },
              buttonText: "LET’S GO!",
              isMargin: true),
          SizedBox(height: AppDimensions.forty)
        ],
      ));
}
