// ignore_for_file: file_names

import 'package:bandapp/appstyle/app_colors.dart';
import 'package:bandapp/appstyle/app_dimensions.dart';
import 'package:flutter/material.dart';

class LinearGradientMask extends StatelessWidget {
  const LinearGradientMask({
    super.key,
    required this.child,
    required this.primary,
    required this.secondary,
  });
  final Widget child;
  final Color primary;
  final Color secondary;
  @override
  Widget build(BuildContext context) {
    return ShaderMask(
      shaderCallback: (bounds) => LinearGradient(
        begin: Alignment.centerLeft,
        end: Alignment.centerRight,
        colors: [primary, secondary],
        tileMode: TileMode.mirror,
      ).createShader(bounds),
      child: child,
    );
  }
}

class CustomLine extends StatelessWidget {
  const CustomLine({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 35,
      color: Colors.white,
      child: Stack(
        children: <Widget>[
          Positioned(
            left: 0,
            top: 0,
            right: 0,
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: 30,
              decoration: BoxDecoration(
                  borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(60.0),
                      topRight: Radius.circular(12.0)),
                  border: Border.all(
                      width: 1.0, color: AppColors.dividerLineColor)),
            ),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: 12.0,
              color: Colors.white,
            ),
          ),
          Positioned(
            top: 0,
            right: 0,
            bottom: 0,
            child: Container(
              width: 12.0,
              height: 68,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}

class CustomStraightLine extends StatelessWidget {
  const CustomStraightLine({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Divider(
        thickness: AppDimensions.one,
        indent: MediaQuery.of(context).size.width / 4,
        height: AppDimensions.one,
        color: AppColors.dividerLineColor);
  }
}

class CustomCenterLine extends StatelessWidget {
  const CustomCenterLine({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Divider(
        thickness: AppDimensions.one,endIndent: MediaQuery.of(context).size.width / 5,
        indent: MediaQuery.of(context).size.width / 6,
        height: AppDimensions.one,
        color: AppColors.dividerLineColor);
  }
}