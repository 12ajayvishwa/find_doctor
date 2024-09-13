
import 'package:find_doctor/theme/color_constants.dart';
import 'package:find_doctor/theme/text_style.dart';
import 'package:find_doctor/widgets/app_bar_container.dart';
import 'package:find_doctor/widgets/custom_image_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
// import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';


class SuccessfullyCompleteSurgeries extends StatefulWidget {
  const SuccessfullyCompleteSurgeries({super.key});

  @override
  State<SuccessfullyCompleteSurgeries> createState() =>
      _SuccessfullyCompleteSurgeriesState();
}

class _SuccessfullyCompleteSurgeriesState
    extends State<SuccessfullyCompleteSurgeries> {
  double _currentValue = 45;
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: SizedBox(
        height: size.height,
        width: size.width,
        child: _buildBody(size),
      ),
    );
  }

  _buildBody(size) {
    return Stack(
      children: [
        appBarContainer(size,
            title: 'Successfully Complete Surgeries',
            isLeading: true,
            leading: IconButton(
                onPressed: () {
                  Get.back();
                },
                icon: Icon(
                  Icons.arrow_back,
                  color: AppColors.black900,
                ))),
        Positioned(
          bottom: -40.h,
          right: -15.w,
          child: SvgPicture.asset("assets/svg/Rectangle 5904.svg"),
        ),
        bodyWidget()
      ],
    );
  }

  bodyWidget() {
    return Positioned(
      top: 140.h,
      right: 20.w,
      left: 20.w,
      child: Column(
        children: [
          SizedBox(
            height: 154.h,
            width: double.maxFinite,
            child: Row(
              children: [
                Expanded(
                    child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text("Total Surgeries",
                        style: AppTextStyles.text18White600.copyWith(
                            color: AppColors.black900,
                            fontWeight: FontWeight.bold)),
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          "250",
                          style: AppTextStyles.appBarHeadingText.copyWith(
                              fontSize: 48.sp, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          width: 5.w,
                        ),
                        CustomImageView(
                          svgPath: "assets/icons/Icon (from Tabler.io).svg",
                          height: 32.h,
                          width: 32.w,
                        )
                      ],
                    )
                  ],
                )),
                Expanded(
                    child: Card(
                        surfaceTintColor: Colors.white,
                        elevation: 3,
                        child: Stack(
                          alignment: Alignment.center,
                          children: [
                            SizedBox(height: 10.h,),
                            SfRadialGauge(
                              axes: <RadialAxis>[
                                
                                RadialAxis(
                                  minimum: 0,
                                  maximum: 45,
                                  startAngle: 180,
                                  endAngle: 360,
                                  showLabels: false,
                                  showTicks: false,
                                  axisLineStyle: AxisLineStyle(
                                    cornerStyle:CornerStyle.bothCurve,
                                    thickness: 0.15,
                                    thicknessUnit: GaugeSizeUnit.factor,
                                    color: Colors.grey.shade300,
                                  ),
                                  ranges: <GaugeRange>[
                                    GaugeRange(
                                      startValue: 0,
                                      endValue: 35,
                                      startWidth: 0.15,
                                      endWidth: 0.15,
                                      color: Colors.green,
                                      sizeUnit: GaugeSizeUnit.factor,
                                    ),
                                    GaugeRange(
                                      startValue: 35,
                                      endValue: _currentValue,
                                      startWidth: 0.15,
                                      endWidth: 0.15,
                                      color: Colors.grey.withOpacity(0.2),
                                      sizeUnit: GaugeSizeUnit.factor,
                                    ),
                                  ],
                                  pointers: const <GaugePointer>[
                                    // NeedlePointer(
                                    //   value: _currentValue,
                                    //   needleStartWidth: 1,
                                    //   needleEndWidth: 4,
                                    //   needleColor: Colors.black,
                                    //   knobStyle: const KnobStyle(
                                    //     knobRadius: 0.06,
                                    //     sizeUnit: GaugeSizeUnit.factor,
                                    //     color: Colors.black,
                                    //   ),
                                    //   lengthUnit: GaugeSizeUnit.factor,
                                    //   needleLength: 0.8,
                                    // ),
                                  ],
                                  annotations: <GaugeAnnotation>[
                                    GaugeAnnotation(
                                      widget: Stack(
                                        children: [],
                                      ),
                                      positionFactor: 0.75,
                                      angle: 90,
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            Positioned(
                              top: 60.h,
                              child: Text('${_currentValue.toInt()}/45',
                                  style: AppTextStyles.bodyText),
                            ),
                            Positioned(
                              top: 80.h,
                              child: const Text(
                                'Request report',
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.normal,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                          ],
                        ))),
              ],
            ),
          ),
          SizedBox(
            height: 10.h,
          ),
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Growth",
                    style: AppTextStyles.text18Black800
                        .copyWith(fontSize: 16.sp, fontWeight: FontWeight.w600),
                  ),
                  InkWell(
                    onTap: () {
                      // showAdaptiveDialog(
                      //   context: context,
                      //   builder: (context) {
                      //     return AlertDialog(
                      //       title: const Text("Select Year"),
                      //       content: Column(
                      //         mainAxisSize: MainAxisSize.min,
                      //         children: [
                      //           ListTile(
                      //             onTap: () {
                      //               Navigator.pop(context);
                      //             },
                      //             title: const Text("2021"),
                      //           ),
                      //           ListTile(
                      //             onTap: () {
                      //               Navigator.pop(context);
                      //             },
                      //             title: const Text("2022"),
                      //           ),
                      //           ListTile(
                      //             onTap: () {
                      //               Navigator.pop(context);
                      //             },
                      //             title: const Text("2023"),
                      //           ),
                      //         ],
                      //       ),
                      //     );
                      //   },
                      // );
                    },
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          "2021",
                          style: AppTextStyles.text18Black800.copyWith(
                              fontSize: 16.sp, fontWeight: FontWeight.w600),
                        ),
                        Icon(
                          Icons.arrow_drop_down,
                          size: 30.sp,
                        )
                      ],
                    ),
                  )
                ],
              ),
              // SizedBox(
              //   height: 180.h,
              //   width: double.maxFinite,
              //   child: SfCartesianChart(
              //     primaryXAxis: CategoryAxis(),
              //     // plotAreaBackgroundColor: AppColors.kprimary,
              //     // plotAreaBorderColor:  AppColors.kprimary,

              //     series: <ChartSeries<SurgeryData, String>>[
              //       SplineAreaSeries<SurgeryData, String>(
              //         dataSource: <SurgeryData>[
              //           SurgeryData('2016', 0),
              //           SurgeryData('2017', 150),
              //           SurgeryData('2018', 0),
              //           SurgeryData('2019', 100),
              //           SurgeryData('2020', 150),
              //           SurgeryData('2021', 0),
              //           SurgeryData('2023', 150),
              //         ],
              //         xValueMapper: (SurgeryData surgery, _) => surgery.year,
              //         yValueMapper: (SurgeryData surgery, _) => surgery.surgery,
              //         color: AppColors.kprimary,
              //         borderDrawMode: BorderDrawMode.top,
              //         borderColor: AppColors.green600,
              //         borderWidth: 1,
              //         enableTooltip: true,
              //         gradient: const LinearGradient(
              //             begin: Alignment.topCenter,
              //             end: Alignment.bottomCenter,
              //             colors: [
              //               Color.fromARGB(255, 177, 236, 177),
              //               Color(0xFFFFFFFF),
              //             ]),
              //       ),
              //     ],
              //     tooltipBehavior: TooltipBehavior(
              //       enable: true,
              //       shouldAlwaysShow: true,
              //       tooltipPosition: TooltipPosition.pointer,
              //       builder: (dynamic data, dynamic point, dynamic series,
              //           int pointIndex, int seriesIndex) {
              //         return Container(
              //           padding: const EdgeInsets.all(8),
              //           decoration: BoxDecoration(
              //             color: AppColors.green600,
              //             borderRadius: BorderRadius.circular(5),
              //             border: Border.all(color: Colors.white, width: 2),
              //           ),
              //           child: Column(
              //             mainAxisSize: MainAxisSize.min,
              //             children: <Widget>[
              //               Text(
              //                 'Year: ${data.year}',
              //                 style: const TextStyle(color: Colors.white),
              //               ),
              //               Text(
              //                 'Surgery: ${data.surgery}',
              //                 style: const TextStyle(color: Colors.white),
              //               ),
              //             ],
              //           ),
              //         );
              //       },
              //     ),
              //   ),
              // ),
            ],
          ),
          SizedBox(
            height: 10.h,
          ),
          SizedBox(
            height: 160.h,
            width: double.maxFinite,
            child: Row(
              children: [
                Expanded(
                    child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Card(
                    surfaceTintColor: Colors.white,
                    elevation: 5,
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: 15.w, vertical: 14.h),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Top month",
                            style: AppTextStyles.text16Black600.copyWith(
                                color: AppColors.gray, fontSize: 16.sp),
                          ),
                          const Spacer(),
                          Text(
                            "November",
                            style: AppTextStyles.text18White600.copyWith(
                                color: AppColors.kprimary, fontSize: 22.sp),
                          ),
                          Text(
                            "2018",
                            style: AppTextStyles.text18White600.copyWith(
                                color: AppColors.gray,
                                fontSize: 16.sp,
                                fontWeight: FontWeight.w500),
                          )
                        ],
                      ),
                    ),
                  ),
                )),
                Expanded(
                    child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Card(
                    surfaceTintColor: Colors.white,
                    elevation: 5,
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: 15.w, vertical: 14.h),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Top year",
                            style: AppTextStyles.text16Black600.copyWith(
                                color: AppColors.gray, fontSize: 16.sp),
                          ),
                          const Spacer(),
                          Text(
                            "2023",
                            style: AppTextStyles.text18White600.copyWith(
                                color: AppColors.kprimary, fontSize: 22.sp),
                          ),
                          Text(
                            "100 surgeries",
                            style: AppTextStyles.text18White600.copyWith(
                                color: AppColors.gray,
                                fontSize: 16.sp,
                                fontWeight: FontWeight.w500),
                          )
                        ],
                      ),
                    ),
                  ),
                )),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class SurgeryData {
  SurgeryData(this.year, this.surgery);
  final String year;
  final double surgery;
}
