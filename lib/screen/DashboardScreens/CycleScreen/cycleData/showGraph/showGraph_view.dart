// ignore_for_file: file_names

import 'package:bandapp/appstyle/app_colors.dart';
import 'package:bandapp/appstyle/app_dimensions.dart';
import 'package:bandapp/screen/DashboardScreens/CycleScreen/cycleData/showGraph/showGraph_controller.dart';
import 'package:bandapp/widgets/customBackButton.dart';
import 'package:fcharts/fcharts.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ShowGraphView extends StatefulWidget {
   ShowGraphView({super.key,required this.getName});
String getName = '';
  @override
  State<ShowGraphView> createState() => _ShowGraphViewState();
}

class _ShowGraphViewState extends State<ShowGraphView> {
  var dsh = Get.isRegistered<ShowGraphController>()
      ? Get.find<ShowGraphController>()
      : Get.put(ShowGraphController());

  @override
  Widget build(BuildContext context) => GetBuilder<ShowGraphController>(
      builder: (controller) =>
           Scaffold(
            appBar: PreferredSize(
              preferredSize: Size.fromHeight(
                  AppDimensions.seventy), // here the desired height
              child: AppBar(
                automaticallyImplyLeading: false,
                backgroundColor: Colors.white,
                elevation: AppDimensions.zero,
                title: CustomWithTextHeader(
                  getHeadingText: widget.getName.isNotEmpty ? widget.getName : "",
                  isBackAllow: true,
                ),
              )),
            body: Container(
            
              margin: EdgeInsets.only(right: AppDimensions.twenty),
            child: const Center(child: SimpleLineChart()))));
}

class SimpleLineChart extends StatelessWidget {
  static const myData = [
    ["W1", " 18"],
    ["W2", " 20"],
    ["W3", " 28"],
    ["W4", " 30"],
  ];

  const SimpleLineChart({super.key});

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 4 / 3,
      child: LineChart(
        lines: [
          Line<List<String>, String, String>(
            data: myData,
            curve: LineCurves.cardinalSpline,
            marker: const MarkerOptions(
                paint: PaintOptions.fill(
              color: AppColors.buttonColor,
              strokeCap: StrokeCap.round,
            )),
            stroke: PaintOptions.stroke(
              color: AppColors.buttonColor,
              strokeWidth: AppDimensions.three,
            ),
            xFn: (datum) => datum[0],
            yFn: (datum) => datum[1],
            xAxis: ChartAxis(
                hideTickNotch: true,
                paint: PaintOptions.fill(
                    color: AppColors.lineGraphColor,
                    strokeCap: StrokeCap.round,
                    strokeWidth: AppDimensions.two)),
            yAxis: ChartAxis(
                opposite: true,
                hideTickNotch: true,
                paint: PaintOptions.fill(
                    color: AppColors.lineGraphColor,
                    strokeCap: StrokeCap.round,
                    strokeWidth: AppDimensions.two)),
          ),
        ],
      ),
    );
  }
}
