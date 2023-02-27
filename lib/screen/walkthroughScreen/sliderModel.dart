// ignore_for_file: file_names

import 'package:bandapp/appstyle/app_strings.dart';

class OnBoardingContent{
   String? name;
   String? title;
   String? des;
  OnBoardingContent( this.name,this.title,this.des);
}

List<OnBoardingContent> contents= [
  OnBoardingContent( AppStrings.welcomTextTwo,"Awesome!", AppStrings.descriptionText),
  OnBoardingContent( AppStrings.welcomTextTwo,"Bandtastic! training", AppStrings.descriptionText),
  OnBoardingContent(AppStrings.welcomTextTwo, "About the app",AppStrings.descriptionText),
];