// ignore_for_file: file_names

import 'package:bandapp/appstyle/app_strings.dart';

class HowWorkContent{
   String? name;
   String? title;
   String? des;
  HowWorkContent( this.name,this.title,this.des);
}

List<HowWorkContent> howWorkModel= [
  HowWorkContent( AppStrings.howWork,"High Intensity Training", AppStrings.descriptionText),
  HowWorkContent( AppStrings.howWork,"High Intensity Training", AppStrings.descriptionText),
  HowWorkContent(AppStrings.howWork, "High Intensity Training",AppStrings.descriptionText),
  HowWorkContent(AppStrings.howWork, "High Intensity Training",AppStrings.descriptionText),
  HowWorkContent(AppStrings.howWork, "High Intensity Training",AppStrings.descriptionText),
];