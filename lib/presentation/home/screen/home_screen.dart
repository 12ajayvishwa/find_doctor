import 'dart:convert';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:find_doctor/core/constants/app_export.dart';
import 'package:find_doctor/core/constants/api_network.dart';
import 'package:find_doctor/data/model/send_request_model.dart';
import 'package:find_doctor/presentation/doctor/controller/appointment_controller.dart';
import 'package:find_doctor/presentation/home/home_controller.dart';
import 'package:find_doctor/utils/custom_toast.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/constants/exit_app.dart';
import '../../../utils/empty_container.dart';
import 'package:intl/intl.dart';

import '../../notification/controller.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  HomeController homeController = Get.put(HomeController());
  CarouselController buttonCarouselController = CarouselController();
  AppointmentController appointmentController =
      Get.put(AppointmentController());
  RequestController requestController = Get.put(RequestController());
  NotificationController notificationController =
      Get.put(NotificationController());

  // ignore: prefer_typing_uninitialized_variables
  var _user;
  @override
  void initState() {
    _user = json.decode(SessionManager.getUser().toString());
    requestController.clearData();
    appointmentController.clearData();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      homeController.getCategory();
      notificationController.getNotification();
      SessionManager.getUserTypeId() == "2"
          ? requestController.clearData()
          : appointmentController.clearData();
      SessionManager.getUserTypeId() == "2"
          ? requestController.getRequest(status: "accepted")
          : appointmentController.getUpcommingAppointment(status: "accepted");
    });

    toast.init(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    var userType = SessionManager.getUserTypeId();
    // ignore: deprecated_member_use
    return WillPopScope(
      onWillPop: () => backButtonPressed(context),
      child: Scaffold(
        body: Obx(() {
          return SizedBox(
            height: double.infinity,
            width: double.infinity,
            child: Stack(
              children: [
                Positioned(
                  left: -91.w,
                  top: -73.h,
                  child: Container(
                    width: 342.w,
                    height: 342.h,
                    decoration: ShapeDecoration(
                      gradient: AppGradient.kCircleGradient(),
                      shape: const OvalBorder(),
                    ),
                  ),
                ),
                Positioned(
                    child: SvgPicture.asset(
                  "assets/icons/elips_circle.svg",
                )),
                AnimatedPositioned(
                  duration: const Duration(milliseconds: 500),
                  bottom: homeController.isExpanded.value ? 0 : 0,
                  top: homeController.isExpanded.value ? 0 : 60.h,
                  left: homeController.isExpanded.value ? 0 : 37.w,
                  right: homeController.isExpanded.value ? 0 : 0,
                  child: GestureDetector(
                    onPanUpdate: homeController.onPanUpdate,
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 500),
                      decoration: BoxDecoration(
                        color: AppColors.whiteA700,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(
                              homeController.isExpanded.value ? 0 : 40.r),
                        ),
                      ),
                      child: CustomScrollView(
                        shrinkWrap: true, // Added to prevent overflow
                        physics: homeController.isExpanded.value
                            ? const BouncingScrollPhysics()
                            : const NeverScrollableScrollPhysics(),
                        slivers: [
                          SliverAppBar(
                            title: _buildUserCard(),
                            backgroundColor: homeController.isExpanded.value
                                ? Colors.white
                                : Colors.transparent,
                            expandedHeight: userType == "2"
                                ? homeController.isExpanded.value
                                    ? 460.h
                                    : 450.h
                                : homeController.isExpanded.value
                                    ? 460.h
                                    : 440.h,
                            pinned: true,
                            snap: false,
                            flexibleSpace: FlexibleSpaceBar(
                              background: Container(
                                color: homeController.isExpanded.value
                                    ? Colors.white
                                    : Colors.transparent,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    SessionManager.getUserTypeId() == "2"
                                        ? _buildHospitalCard()
                                        : _buildDoctorCard(),
                                    SizedBox(height: 10.h),
                                    _buildCategorySection(
                                        SessionManager.getUserTypeId() == "2"),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          SliverToBoxAdapter(
                            child: Padding(
                              padding: EdgeInsets.only(
                                left: 10.w,
                                top: 10.w,
                                bottom: 10.h,
                                right: 10.w,
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  // userType == "2"
                                  //     ? CustomTextFormField(
                                  //         hintText: "Search",
                                  //         fillColor:
                                  //             Colors.black.withOpacity(0.15),
                                  //         filled: true,
                                  //         prefix: Padding(
                                  //           padding: const EdgeInsets.all(12.0),
                                  //           child: SvgPicture.asset(
                                  //               "assets/svg/search.svg"),
                                  //         ),
                                  //       )
                                  //     : Container(),
                                  Padding(
                                    padding: EdgeInsets.only(top: 10.h),
                                    child: Text(
                                      userType == "2"
                                          ? "Upcoming Requests"
                                          : "Upcoming Appointments",
                                      style: AppTextStyles.text32Black600
                                          .copyWith(fontSize: 22.sp),
                                    ),
                                  ),
                                  userType == "2"
                                      ? _buildRequestAccepted(size)
                                      : _buildUpcomingAppointments(size),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        }),
      ),
    );
  }

  _buildUpcomingAppointments(Size size) {
    return Obx(() {
      if (appointmentController.rxRequestStatus.value == Status.loading) {
        return SizedBox(
            height: size.height * 0.3, child: Center(child: CustomLoading()));
      }
      if (appointmentController.upcommingAppointmentsList.isEmpty) {
        return Padding(
          padding: EdgeInsets.symmetric(vertical: 10.h),
          child: EmptyContainer(
            msg: "Currently you don't have upcoming appointment",
          ),
        );
      }
      return SizedBox(
        height: size.height / 1.30,
        child: ListView.builder(
            padding: EdgeInsets.all(0.0),
            itemCount: appointmentController.upcommingAppointmentsList.length,
            shrinkWrap: true,
            itemBuilder: (context, index) {
              var upcomingAppointment =
                  appointmentController.upcommingAppointmentsList[index];

              DateTime surgeryDate = DateFormat("yyyy-MM-ddTHH:mm:ss.SSSZ")
                  .parse(upcomingAppointment.request!.surgeryDate!);
              final dateFormat = DateFormat('dd');
              final dateDay = DateFormat('EEE');
              final formattedDate =
                  dateFormat.format(surgeryDate).toUpperCase();
              final formattedDay = dateDay.format(surgeryDate).toUpperCase();
              return AnimatedContainer(
                duration: const Duration(milliseconds: 500),
                margin: EdgeInsets.only(
                    bottom: 5.h, right: 10.w, left: 10.w, top: 10.h),
                width: double.maxFinite,
                decoration: BoxDecoration(
                  color: AppColors.ksecondaryColor,
                  borderRadius: BorderRadius.circular(
                    15.r,
                  ),
                ),
                child: InkWell(
                  onTap: () {
                    Get.toNamed(AppRoutes.UPCOMMING_APPOINTMENT_SCREEN,
                        arguments: [upcomingAppointment, "Upcoming"]);
                  },
                  child: Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: 15.w, vertical: 15.h),
                    child: Stack(
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 10.w, vertical: 15.h),
                              decoration: BoxDecoration(
                                  color: AppColors.whiteA700,
                                  borderRadius: BorderRadius.circular(15.r)),
                              child: Center(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    SizedBox(
                                      width: 50.w,
                                      child: Text(
                                        formattedDate.toString() ?? "",
                                        textAlign: TextAlign.center,
                                        style: AppTextStyles.text18Black800
                                            .copyWith(fontSize: 16.sp),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 5.h,
                                    ),
                                    SizedBox(
                                      width: 50.w,
                                      child: Text(
                                        formattedDay.toString() ?? "",
                                        textAlign: TextAlign.center,
                                        style: AppTextStyles.text18Black800
                                            .copyWith(fontSize: 16.sp),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 10.w,
                            ),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    "${upcomingAppointment.request!.startTime} - ${upcomingAppointment.request!.endTime}",
                                    style: AppTextStyles.text10White400,
                                  ),
                                  SizedBox(
                                    height: 5.h,
                                  ),
                                  SizedBox(
                                    width: 240.w,
                                    child: Text(
                                      upcomingAppointment.request!.title
                                          .toString(),
                                      style: AppTextStyles.text15White500
                                          .copyWith(
                                              fontWeight: FontWeight.w600),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 5.h,
                                  ),
                                  SizedBox(
                                    width: 240.w,
                                    child: Text(
                                      upcomingAppointment
                                              .request!.description ??
                                          "",
                                      style: AppTextStyles.text10White400,
                                      maxLines: 2,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        // Positioned(
                        //   right: 10.w,
                        //   top: 0.h,
                        //   child: InkWell(
                        //     onTap: () {
                        //       Get.toNamed(AppRoutes.UPCOMMING_APPOINTMENT_SCREEN,
                        //           arguments: [upcomingAppointment, "Upcoming"]);
                        //     },
                        //     child: SvgPicture.asset(
                        //       "assets/svg/menu_second.svg",
                        //       color: AppColors.whiteA700,
                        //       height: 25.h,
                        //     ),
                        //   ),
                        // ),
                      ],
                    ),
                  ),
                ),
              );
            }),
      );
    });
  }

  _buildRequestAccepted(Size size) {
    return Obx(() {
      if (requestController.rxRequestStatus.value == Status.loading) {
        return SizedBox(
            height: size.height * 0.3, child: Center(child: CustomLoading()));
      }
      if (requestController.requestsList.isEmpty) {
        return Padding(
          padding: EdgeInsets.symmetric(vertical: 10.h),
          child: EmptyContainer(
            msg: "No Request Found",
          ),
        );
      }
      return SizedBox(
        height: size.height / 1.4,
        child: ListView.builder(
            padding: EdgeInsets.all(0),
            itemCount: requestController.requestsList.length,
            shrinkWrap: true,
            itemBuilder: (context, index) {
              var acceptedRequest = requestController.requestsList[index];

              DateTime surgeryDate = DateFormat("yyyy-MM-ddTHH:mm:ss.SSSZ")
                  .parse(acceptedRequest.surgeryDate!);
              final dateFormat = DateFormat('dd');
              final dateDay = DateFormat('EEE');
              final formattedDate =
                  dateFormat.format(surgeryDate).toUpperCase();
              final formattedDay = dateDay.format(surgeryDate).toUpperCase();
              return AnimatedContainer(
                duration: const Duration(milliseconds: 500),
                margin: EdgeInsets.only(
                    bottom: 5.h, right: 0.w, left: 0.w, top: 10.h),
                width: double.maxFinite,
                decoration: BoxDecoration(
                  color: AppColors.ksecondaryColor,
                  borderRadius: BorderRadius.circular(
                    15.r,
                  ),
                ),
                child: InkWell(
                  onTap: () {
                    Get.toNamed(AppRoutes.REQUEST_DETAIL,
                        arguments: [acceptedRequest, 1]);
                  },
                  child: Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: 15.w, vertical: 15.h),
                    child: Stack(
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 10.w, vertical: 15.h),
                              decoration: BoxDecoration(
                                  color: AppColors.whiteA700,
                                  borderRadius: BorderRadius.circular(15.r)),
                              child: Center(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    SizedBox(
                                      width: 50.w,
                                      child: Text(
                                        formattedDate.toString() ?? "",
                                        textAlign: TextAlign.center,
                                        style: AppTextStyles.text18Black800
                                            .copyWith(fontSize: 16.sp),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 5.h,
                                    ),
                                    SizedBox(
                                      width: 50.w,
                                      child: Text(
                                        formattedDay.toString() ?? "",
                                        textAlign: TextAlign.center,
                                        style: AppTextStyles.text18Black800
                                            .copyWith(fontSize: 16.sp),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 10.w,
                            ),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    "${acceptedRequest.startTime} - ${acceptedRequest.endTime}",
                                    style: AppTextStyles.text10White400,
                                  ),
                                  SizedBox(
                                    height: 5.h,
                                  ),
                                  SizedBox(
                                    width: 240.w,
                                    child: Text(
                                      acceptedRequest.title.toString(),
                                      style: AppTextStyles.text15White500
                                          .copyWith(
                                              fontWeight: FontWeight.w600),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 5.h,
                                  ),
                                  SizedBox(
                                    width: 240.w,
                                    child: Text(
                                      acceptedRequest.description!,
                                      style: AppTextStyles.text10White400,
                                      maxLines: 2,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        // Positioned(
                        //   right: 10.w,
                        //   top: 0.h,
                        //   child: InkWell(
                        //     onTap: () {
                        //       print("object");
                        //       // Get.toNamed(AppRoutes.REQUEST_DETAIL,
                        //       //     arguments: [acceptedRequest, 1]);
                        //     },
                        //     child: SvgPicture.asset(
                        //       "assets/svg/menu_second.svg",
                        //       color: AppColors.whiteA700,
                        //       height: 25.h,
                        //     ),
                        //   ),
                        // ),
                      ],
                    ),
                  ),
                ),
              );
            }),
      );
    });
  }

  Container _buildCategorySection(isHopital) {
    return Container(
      margin: EdgeInsets.only(left: 15.w, right: 15.w),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Categories",
                style: AppTextStyles.text18Black600,
              ),
              isHopital == true
                  ? InkWell(
                      onTap: () {
                        Get.toNamed(AppRoutes.CATOGROIES_SCREEN);
                      },
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            "See All",
                            style: AppTextStyles.text16Gray400
                                .copyWith(fontSize: 14.sp),
                          ),
                          Icon(
                            Icons.arrow_forward_ios,
                            size: 14.w,
                            color: AppColors.gray,
                          )
                        ],
                      ),
                    )
                  : Container(),
            ],
          ),
          SizedBox(
            height: 10.h,
          ),
          SizedBox(
            height: homeController.isExpanded.value ? 125.h : 125.h,
            width: double.infinity,
            child: isHopital == true
                ? homeController.rxRequestStatus.value == Status.loading
                    ? const CustomLoading()
                    : homeController.categoryList.isEmpty
                        ? Center(
                            child: Text(
                            "No category available",
                            style: AppTextStyles.bodyText,
                          ))
                        : ListView.builder(
                            padding: EdgeInsets.all(0.h),
                            scrollDirection: Axis.horizontal,
                            physics: homeController.isExpanded.value
                                ? const BouncingScrollPhysics()
                                : const NeverScrollableScrollPhysics(),
                            itemCount: homeController.categoryList.length,
                            itemBuilder: (context, index) {
                              return InkWell(
                                onTap: () {
                                  Get.offAllNamed(AppRoutes.DASHBOARD,arguments:[3,0]);
                                },
                                splashColor: AppColors.whiteA700,
                                child: AnimatedContainer(
                                  duration: const Duration(milliseconds: 300),
                                  width: homeController.isExpanded.value
                                      ? 115.w
                                      : 100.w,
                                  margin: EdgeInsets.only(right: 38.w),
                                  decoration: BoxDecoration(
                                      color: AppColors.whiteA700,
                                      borderRadius:
                                          BorderRadius.circular(15.r)),
                                  child: Stack(
                                    alignment: Alignment.topCenter,
                                    children: [
                                      Container(
                                          padding: EdgeInsets.all(15.h),
                                          height: 86.h,
                                          width: 86.w,
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(17.r),
                                              border: Border.all(
                                                color: AppColors.black900
                                                    .withOpacity(0.2),
                                                width: 1,
                                              )),
                                          child: CustomImageView(
                                            url: homeController
                                                .categoryList[index]['icon'],
                                          )),
                                      Positioned(
                                        bottom: 10.h,
                                        child: SizedBox(
                                          child: Text(
                                            homeController.categoryList[index]
                                                ['name'],
                                            softWrap: true,
                                            style: AppTextStyles
                                                .text10DarkGreen400
                                                .copyWith(fontSize: 12.sp),
                                            textAlign: TextAlign.center,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            })
                : ListView.builder(
                    scrollDirection: Axis.horizontal,
                    physics: homeController.isExpanded.value
                        ? const BouncingScrollPhysics()
                        : const NeverScrollableScrollPhysics(),
                    itemCount: doctorOperation.length,
                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap: () {
                          Get.toNamed(doctorOperation[index]['route'],
                              arguments: [0, 0]);
                              // print("object");
                        },
                        splashColor: AppColors.whiteA700,
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 300),
                          width:
                              homeController.isExpanded.value ? 110.w : 100.w,
                          margin: EdgeInsets.only(right: 16.w, left: 16.w),
                          decoration: BoxDecoration(
                              color: AppColors.whiteA700,
                              borderRadius: BorderRadius.circular(15.r)),
                          child: Stack(
                            alignment: Alignment.topCenter,
                            children: [
                              Container(
                                  padding: EdgeInsets.all(15.h),
                                  height: 86.h,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(17.r),
                                      border: Border.all(
                                        color:
                                            AppColors.black900.withOpacity(0.2),
                                        width: 1,
                                      )),
                                  child: CustomImageView(
                                    svgPath: doctorOperation[index]['image'],
                                  )),
                              Positioned(
                                bottom: 0.h,
                                child: Container(
                                  width: 100.w,
                                  height: 35.h,
                                  alignment: Alignment.topCenter,
                                  child: Text(
                                    doctorOperation[index]['name'],
                                    //softWrap: true,
                                    style: AppTextStyles.text10DarkGreen400
                                        .copyWith(fontSize: 12.sp),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              ),
                              // Positioned(
                              //     bottom: 30.h,
                              //     right: 0.w,
                              //     child: Container(
                              //       decoration: BoxDecoration(
                              //         color: AppColors.green600,
                              //         shape: BoxShape.circle,
                              //       ),
                              //       child: Padding(
                              //         padding: const EdgeInsets.all(8.0),
                              //         child: Center(
                              //           child: Text(

                              //             doctorOperation[index]['value'],
                              //             softWrap: true,
                              //             style:
                              //                 AppTextStyles.text12WhiteRegular,
                              //             textAlign: TextAlign.center,
                              //           ),
                              //         ),
                              //       ),
                              //     ))
                            ],
                          ),
                        ),
                      );
                    }),
          )
        ],
      ),
    );
  }

  _buildHospitalCard() {
    List<Widget> items = [
      sliderCardHospital(),
    ];
    return CarouselSlider(
        items: items,
        options: CarouselOptions(
          autoPlay: items.length > 1,
          aspectRatio: homeController.isExpanded.value ? 1.7.h : 1.62.h,
          viewportFraction: 1,
          enlargeCenterPage: true,
          enableInfiniteScroll: items.length > 1,
          scrollPhysics:
              items.length > 1 ? null : const NeverScrollableScrollPhysics(),
        ));

    sliderCardHospital();
  }

  sliderCardHospital() {
    return Container(
      height: 200.h,
      margin: EdgeInsets.only(
        left: 12.w,
        right: 12.w,
        top: 130.h,
      ),
      width: double.infinity,
      decoration: BoxDecoration(
          color: AppColors.hospitalCardColor,
          borderRadius: BorderRadius.circular(15.r)),
      child: Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AnimatedContainer(
              width: 180.w,
              duration: const Duration(milliseconds: 500),
              child: Column(
                children: [
                  Text(
                    "Medical Center",
                    style: AppTextStyles.text18White600.copyWith(fontSize: 20),
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                  Text(
                    "Yorem ipsum dolor sit amet, consectetur adipiscing elit. Nunc vulputate libero et velit interdum, ac aliquet odio mattis.",
                    textAlign: TextAlign.start,
                    style: AppTextStyles.text10White400,
                  )
                ],
              ),
            ),
          ],
        ),
        Image.asset(
          "assets/images/doctor.png",
        ),
      ]),
    );
  }

  _buildDoctorCard() {
    List<Widget> items = [
      sliderCardDoctor(),
    ];
    return CarouselSlider(
        items: items,
        options: CarouselOptions(
          autoPlay: items.length > 1,
          aspectRatio: homeController.isExpanded.value ? 1.46 : 1.4,
          viewportFraction: 1,
          enlargeCenterPage: true,
          enableInfiniteScroll: items.length > 1,
          scrollPhysics:
              items.length > 1 ? null : const NeverScrollableScrollPhysics(),
        ));

    sliderCardDoctor();
  }

  Container sliderCardDoctor() {
    return Container(
      height: 200.h,
      margin: EdgeInsets.only(
        left: 12.w,
        right: 20.w,
        top: 100.h,
      ),
      width: double.infinity,
      child: Stack(children: [
        Positioned(
          bottom: 0.h,
          left: 0.w,
          right: 0.w,
          top: 25.h,
          child: Container(
            decoration: BoxDecoration(
                color: AppColors.whiteA700,
                gradient: AppGradient.kContainerGradient(),
                borderRadius: BorderRadius.circular(15.r)),
          ),
        ),
        Positioned(
          top: 64.h,
          left: 20.w,
          child: AnimatedContainer(
            width: 162.w,
            duration: const Duration(milliseconds: 500),
            child: Column(
              children: [
                Text(
                  "Get the Best Medical Services",
                  textAlign: TextAlign.left,
                  style: AppTextStyles.text17PersianGreen700,
                ),
                SizedBox(
                  height: 10.h,
                ),
                Text(
                  "We provide best quality medical services without further cost",
                  textAlign: TextAlign.left,
                  style: AppTextStyles.text9black400,
                ),
              ],
            ),
          ),
        ),
        Positioned(
          right: -10.w,
          top: -30.h,
          bottom: -25.h,
          left: 162.w,
          child: Image.asset(
            "assets/images/doctor.png",
          ),
        ),
      ]),
    );
  }

  ListTile _buildUserCard() {
    return ListTile(
      contentPadding: EdgeInsets.only(left: 10.w, right: 10.h),
      title: Text(
        "Hi, Welcome",
        style: AppTextStyles.text16Black400,
      ),
      subtitle: Text(
        _user['name'].toString().capitalizeFirst!,
        style: AppTextStyles.text32Black600.copyWith(fontSize: 24.sp),
      ),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          InkWell(
            onTap: () {
              Get.toNamed(AppRoutes.NOTIFICATION);
            },
            child: SizedBox(
              height: 50.h,
              width: 35.w,
              child: Stack(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: CustomImageView(
                      svgPath: "assets/icons/notification.svg",
                      height: 45.h,
                      width: 45.w,
                    ),
                  ),
                  unreadNotification == 0 || unreadNotification == null
                      ? Container()
                      : Positioned(
                          top: 4.h,
                          left: 16.h,
                          child: Container(
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: AppColors.red600D8),
                            child: Padding(
                              padding: const EdgeInsets.all(4.0),
                              child: Text(unreadNotification.toString(),
                                  style: AppTextStyles.smallText.copyWith(
                                      fontSize: 8, color: AppColors.whiteA700)),
                            ),
                          ),
                        ),
                ],
              ),
            ),
          ),
          SizedBox(
            width: 15.w,
          ),
          InkWell(
            onTap: () {
              Get.toNamed(AppRoutes.PROFILE);
            },
            child: CircleAvatar(
              radius: 27.r,
              backgroundColor: AppColors.kprimary.withOpacity(0.1),
              backgroundImage: _user['avatar'] == null
                  ? const AssetImage("assets/images/user_avatar.png")
                  : NetworkImage(ApiNetwork.imageUrl + _user['avatar'])
                      as ImageProvider,
            ),
          ),
        ],
      ),
    );
  }

  List doctorOperation = [
    // {
    //   "name": "Appointments",
    //   "image": "assets/icons/appointment.svg",
    //   "value": "25",
    //   "route": AppRoutes.DASHBOARD
    // },
    {
      "name": "Pending Request",
      "image": "assets/svg/heart_pulse.svg",
      "value": "06",
      "route": AppRoutes.SUCCESFULLYSURGERIESCOMPLETE
    },
    {
      "name": "completed",
      "image": "assets/svg/success_check.svg",
      "value": "33",
      "route": AppRoutes.COMPLETED_SURGERY_SCREEN
    },
    {
      "name": "All Request",
      "image": "assets/icons/all_request.svg",
      "value": "1408",
      "route": AppRoutes.ALL_REQUEST
    },
  ];
}
