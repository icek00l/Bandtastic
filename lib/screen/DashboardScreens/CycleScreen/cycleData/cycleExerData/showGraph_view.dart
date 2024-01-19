// ignore_for_file: file_names, must_be_immutable

import 'package:bandapp/appstyle/app_colors.dart';
import 'package:bandapp/appstyle/app_dimensions.dart';
import 'package:bandapp/model/dayreview_modal.dart';
import 'package:bandapp/widgets/customBackButton.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class ShowGraphView extends StatefulWidget {
  ShowGraphView({
    super.key,
    this.getName,
    required this.getGraphPoints,
  });
  String? getName = '';
  List<Data> getGraphPoints = List.empty(growable: true);

  @override
  State<ShowGraphView> createState() => _ShowGraphViewState();
}

class _ShowGraphViewState extends State<ShowGraphView> {
  num convertValue(value) {
    double getValue = value;
    int integerValue = getValue.toInt();
    return integerValue;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: PreferredSize(
            preferredSize: Size.fromHeight(
                AppDimensions.seventy), // here the desired height
            child: AppBar(
              automaticallyImplyLeading: false,
              backgroundColor: Colors.white,
              elevation: AppDimensions.zero,
              title: CustomWithTextHeader(
                getHeadingText: widget.getName ?? "",
                isBackAllow: true,
                navigateBack: () {
                  Navigator.pop(context);
                },
              ),
            )),
        body: Center(
          child: AspectRatio(
            aspectRatio: 4 / 3,
            child: widget.getGraphPoints.isEmpty
                ? const IgnorePointer()
                : SfCartesianChart(
                    tooltipBehavior: TooltipBehavior(enable: true),
                    plotAreaBorderWidth: 0,
                    series: <ChartSeries>[
                      SplineSeries<Data, String>(
                        dataSource: widget.getGraphPoints,
                        xValueMapper: (Data point, _) => point.name ?? "",
                        // yValueMapper: (Data point, _) => int.parse(point.totalPower),

                        yValueMapper: (Data point, _) {
                          try {
                            double powerParsedValue =
                                double.parse(point.totalPower.toString());

                            int powervalue = powerParsedValue.toInt();
                            return powervalue;
                          } catch (e) {
                            return 0;
                          }
                        },
                        color: AppColors.lineGraphColor,
                        markerSettings: MarkerSettings(
                            isVisible: true,
                            borderWidth: AppDimensions.three,
                            height: AppDimensions.twelve,
                            width: AppDimensions.twelve,
                            borderColor: AppColors.markerColor),
                        splineType: SplineType.natural,
                      ),
                    ],
                    primaryXAxis: CategoryAxis(
                      axisLine: AxisLine(
                          color: AppColors.lineColor, width: AppDimensions.two),
                      majorGridLines: MajorGridLines(width: 0),
                      minorGridLines: MinorGridLines(width: 0),
                    ),
                    primaryYAxis: NumericAxis(
                      opposedPosition: true,
                      axisLine: AxisLine(
                          color: AppColors.lineColor, width: AppDimensions.two),
                      tickPosition: TickPosition.outside,
                      majorGridLines: MajorGridLines(
                          width: AppDimensions.one, dashArray: [5, 5]),
                      minorGridLines: MinorGridLines(
                          width: AppDimensions.one, dashArray: [5, 5]),
                    ),
                  ),
          ),
        ));
  }
}
