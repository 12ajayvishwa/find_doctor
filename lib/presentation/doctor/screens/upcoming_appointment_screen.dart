import 'package:find_doctor/core/constants/app_export.dart';
import 'package:find_doctor/presentation/doctor/controller/appointment_controller.dart';
import 'package:find_doctor/utils/custom_toast.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../widgets/custom_checkbox.dart';
import '../../notification/notification_service.dart';
import '../models/appointments_request_model.dart';
import 'package:intl/intl.dart';

class UpcommingAppointmentScreen extends StatefulWidget {
  const UpcommingAppointmentScreen({super.key});

  @override
  State<UpcommingAppointmentScreen> createState() =>
      _UpcommingAppointmentScreenState();
}

class _UpcommingAppointmentScreenState
    extends State<UpcommingAppointmentScreen> {
  AppointmentController appointmentController =
      Get.put(AppointmentController());
  TextEditingController surgeryDescriptionController = TextEditingController();
  bool isChecked = false;
  var _user;
  @override
  void initState() {
    toast.init(context);
    _user = json.decode(SessionManager.getUser().toString());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    AppointmentRequestModel appointmentData = Get.arguments[0];
    var upcoming = Get.arguments[1];
    DateTime surgeryDate = DateFormat("yyyy-MM-ddTHH:mm:ss.SSSZ")
        .parse(appointmentData.request!.surgeryDate!);
    String formattedDate = DateFormat('dd/MM/yyyy').format(surgeryDate);
    return Scaffold(body: Obx(() {
      return Stack(
        children: [
          appointmentController.rxRequestStatus.value == Status.loading
              ? CustomLoading()
              : CustomScrollView(
                  physics: const AlwaysScrollableScrollPhysics(),
                  slivers: [
                    SliverAppBar(
                      title: Text(
                        upcoming == "Upcoming"
                            ? "Upcoming Appointment Detail"
                            : "Appointment Details",
                        style: AppTextStyles.text16Black600.copyWith(
                            fontWeight: FontWeight.w700, fontSize: 20.sp),
                      ),
                      centerTitle: true,
                      backgroundColor: Colors.white,
                      expandedHeight: 400.h,
                      // collapsedHeight: 70.h,
                      pinned: true,
                      snap: false,
                      flexibleSpace: FlexibleSpaceBar(
                        background: SizedBox(
                          height: 388.h,
                          width: double.infinity,
                          child: Stack(
                            alignment: Alignment.center,
                            children: [
                              Container(
                                width: 594.w,
                                height: 604.h,
                                decoration: ShapeDecoration(
                                  gradient: const LinearGradient(
                                    begin: Alignment(0.00, -1.00),
                                    end: Alignment(0, 1),
                                    colors: [
                                      Color(0xFF0CC58B),
                                      Color(0x000CC58B)
                                    ],
                                  ),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.only(
                                        bottomRight: Radius.circular(165.r)),
                                  ),
                                ),
                              ),
                              Positioned(
                                  top: 0.h,
                                  left: -50.w,
                                  child: SvgPicture.asset(
                                    "assets/icons/elips_circle.svg",
                                    height: 294.h,
                                  )),
                              Positioned(
                                  top: 0.h,
                                  right: 0.w,
                                  child: Image.asset(
                                    "assets/images/bload cell.png",
                                  )),
                              Positioned(
                                  right: 40.w,
                                  top: 120.h,
                                  bottom: 140.h,
                                  left: 40.w,
                                  child: Container(
                                    decoration: BoxDecoration(
                                        color: AppColors.whiteA700,
                                        borderRadius:
                                            BorderRadius.circular(10.r),
                                        gradient:
                                            AppGradient.kContainerGradient(),
                                        boxShadow: [
                                          BoxShadow(
                                              blurRadius: 30,
                                              offset: Offset(0, 10.w),
                                              spreadRadius: 5,
                                              color:
                                                  Colors.white.withOpacity(0.8))
                                        ]),
                                    child: Padding(
                                      padding: EdgeInsets.only(left: 16.w),
                                      child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: <Widget>[
                                            SizedBox(
                                              width: 150.w,
                                              child: Center(
                                                child: Text(
                                                    appointmentData.request!
                                                        .hospital!.name!,
                                                    style: AppTextStyles
                                                        .headline
                                                        .copyWith(
                                                            color: AppColors
                                                                .kprimary)),
                                              ),
                                            ),
                                            SizedBox(height: 5.h),
                                            SizedBox(
                                              width: 160.w,
                                              child: Center(
                                                child: Text(
                                                  appointmentData
                                                          .request!
                                                          .hospital!
                                                          .description ??
                                                      "lorem ipsum dolor, consectetur adipiscing elit. Nunc v libero et velit interdum, ac  ",
                                                  style: AppTextStyles
                                                      .text9black400,
                                                  textAlign: TextAlign.center,
                                                ),
                                              ),
                                            )
                                          ]),
                                    ),
                                  )),
                              Positioned(
                                  top: 100.h,
                                  right: 50.w,
                                  child: Image.asset(
                                    "assets/svg/appointment_doc.svg",
                                    height: 185.h,
                                  )),
                              Positioned(
                                bottom: 7.h,
                                left: 15.w,
                                child: Container(
                                  height: 100.h,
                                  width: 100.w,
                                  decoration: BoxDecoration(
                                      border: Border.all(
                                          color: Colors.white, width: 4),
                                      borderRadius:
                                          BorderRadius.circular(10.r)),
                                  child: ClipRRect(
                                      borderRadius: BorderRadius.circular(10.r),
                                      child: Image.asset(
                                        appointmentData
                                                .request!.hospital!.avatar ??
                                            "assets/images/hospital_dummy.jpg",
                                        height: 80.h,
                                        width: 80.w,
                                        fit: BoxFit.fill,
                                      )),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                    SliverToBoxAdapter(
                      child: Column(
                        children: [
                          SizedBox(
                            height: 10.h,
                          ),
                          _buildAboutWidget(appointmentData),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 10.w),
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 15.w, vertical: 10.h),
                              margin: EdgeInsets.symmetric(
                                  horizontal: 10.w, vertical: 15.h),
                              decoration: BoxDecoration(
                                  color: AppColors.whiteA700,
                                  borderRadius: BorderRadius.circular(30.r),
                                  boxShadow: [
                                    BoxShadow(
                                        blurRadius: 24.r,
                                        offset: const Offset(0, 0),
                                        color: AppColors.black121212
                                            .withOpacity(.08))
                                  ]),
                              alignment: Alignment.centerLeft,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  _buildTileWidget(
                                      title: "Amount",
                                      value: Text(
                                        "₹ ${appointmentData.request!.amount.toString() ?? "N/A"}",
                                        style: AppTextStyles.text16Black600
                                            .copyWith(
                                          color: AppColors.black900,
                                          fontWeight: FontWeight.w700,
                                        ),
                                      )),
                                  _buildTileWidget(
                                      title: "Title",
                                      value: Text(
                                        appointmentData.request!.title ?? "N/A",
                                        style: AppTextStyles.text16Black600
                                            .copyWith(
                                          color: AppColors.black900,
                                          fontWeight: FontWeight.w700,
                                        ),
                                      )),
                                  _buildTileWidget(
                                      title: "Patient Name",
                                      value: Text(
                                        appointmentData.request!.patientName ??
                                            "N/A",
                                        style: AppTextStyles.text16Black600
                                            .copyWith(
                                          color: AppColors.black900,
                                          fontWeight: FontWeight.w700,
                                        ),
                                      )),
                                  _buildTileWidget(
                                      title: "Patient Age ",
                                      value: Text(
                                        appointmentData.request!.patientAge ==
                                                null
                                            ? "N/A"
                                            : "${appointmentData.request!.patientAge} year Old",
                                        style: AppTextStyles.text16Black600
                                            .copyWith(
                                          color: AppColors.black900,
                                          fontWeight: FontWeight.w700,
                                        ),
                                      )),
                                  _buildTileWidget(
                                    title: "Syrgery Date & Time : ",
                                    value: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          formattedDate,
                                          style: AppTextStyles.text16Black600
                                              .copyWith(
                                            color: AppColors.black900,
                                            fontWeight: FontWeight.w700,
                                          ),
                                        ),
                                        Divider(
                                          color: AppColors.gray,
                                        ),
                                        SizedBox(
                                          height: 10.h,
                                        ),
                                        Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            _buildTileWidget(
                                                title: "Start Time",
                                                value: Container(
                                                  padding:
                                                      const EdgeInsets.all(14),
                                                  decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10),
                                                      color:
                                                          AppColors.kprimary),
                                                  child: Text(
                                                    appointmentData.request!
                                                            .startTime ??
                                                        "N/A",
                                                    style: AppTextStyles
                                                        .text16Black600
                                                        .copyWith(
                                                      color:
                                                          AppColors.whiteA700,
                                                      fontWeight:
                                                          FontWeight.w700,
                                                    ),
                                                  ),
                                                )),
                                            SizedBox(
                                              width: 30.h,
                                            ),
                                            _buildTileWidget(
                                                title: "End Time",
                                                value: Container(
                                                  padding:
                                                      const EdgeInsets.all(14),
                                                  decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10),
                                                      color:
                                                          AppColors.kprimary),
                                                  child: Text(
                                                    appointmentData
                                                            .request!.endTime ??
                                                        "N/A",
                                                    style: AppTextStyles
                                                        .text16Black600
                                                        .copyWith(
                                                      color:
                                                          AppColors.whiteA700,
                                                      fontWeight:
                                                          FontWeight.w700,
                                                    ),
                                                  ),
                                                )),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                  _buildTileWidget(
                                      title: "Description : ",
                                      value: Text(
                                          appointmentData
                                                  .request!.description ??
                                              "N/A",
                                          style: AppTextStyles.text16Black600)),
                                  SizedBox(
                                    height: 10.h,
                                  ),
                                  upcoming == "Upcoming"
                                      ? CustomTextFormField(
                                          maxLines: 3,
                                          hintText: "Message",
                                          controller:
                                              surgeryDescriptionController,
                                        )
                                      : Container(),
                                  // _buildAllowCardWidget((bool? newVlaue) {
                                  //     setState(() {
                                  //       isChecked = newVlaue!;
                                  //     });
                                  //   }, isChecked),
                                  SizedBox(
                                    height: 10.h,
                                  ),
                                  upcoming == "Upcoming"
                                      ? Row(
                                          children: [
                                            Expanded(
                                              child: CustomElevatedButton(
                                                text: "Completed",
                                                onTap: () {
                                                  appointmentController
                                                      .appointmentAction(
                                                          id: appointmentData
                                                              .id!,
                                                          surgeryDescription:
                                                              surgeryDescriptionController
                                                                  .value.text,
                                                          action: "completed");
                                                },
                                              ),
                                            ),
                                            // SizedBox(
                                            //   width: 10.w,
                                            // ),
                                            // Expanded(
                                            //   child: CustomElevatedButton(
                                            //     text: "Decline",
                                            //     buttonStyle: ElevatedButton.styleFrom(
                                            //         backgroundColor:
                                            //             AppColors.red600D8,
                                            //         shape:
                                            //             RoundedRectangleBorder(
                                            //                 borderRadius:
                                            //                     BorderRadius
                                            //                         .circular(
                                            //                             10.r))),
                                            //     onTap: () {
                                            //       appointmentController
                                            //           .appointmentAction(
                                            //               id: appointmentData
                                            //                   .id!,
                                            //               action: "rejected");
                                            //     },
                                            //   ),
                                            // )
                                          ],
                                        )
                                      : Row(
                                          children: [
                                            Expanded(
                                              child: CustomElevatedButton(
                                                text: "Accept",
                                                onTap: () async {
                                                  appointmentController
                                                      .appointmentAction(
                                                          id: appointmentData
                                                              .id,
                                                          action: "accepted");
                                                },
                                              ),
                                            ),
                                            SizedBox(
                                              width: 10.w,
                                            ),
                                            Expanded(
                                              child: CustomElevatedButton(
                                                text: "Decline",
                                                buttonStyle: ElevatedButton.styleFrom(
                                                    backgroundColor:
                                                        AppColors.red600D8,
                                                    shape:
                                                        RoundedRectangleBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        10.r))),
                                                onTap: () {
                                                  appointmentController
                                                      .appointmentAction(
                                                          id: appointmentData
                                                              .id,
                                                          action: "decline");
                                                },
                                              ),
                                            )
                                          ],
                                        )
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                ),
        ],
      );
    }));
  }

  _buildTileWidget({String? title, Widget? value}) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 5.h),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title!,
            style: AppTextStyles.text16Black600,
          ),
          SizedBox(
            height: 5.h,
          ),
          value!,
          const Divider()
        ],
      ),
    );
  }

  _buildAboutWidget(AppointmentRequestModel appointmentData) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: 15.w,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "About",
            style: AppTextStyles.text16Black600,
          ),
          SizedBox(
            height: 5.h,
          ),
          Text(
            appointmentData.request!.hospital!.description ??
                "Bansal Hospital, Bhopal, is a 300 bedded Super Specialty Hospital is born of a dream. A dream that the people of Bhopal and Central India get the best healthcare at affordable prices. Here are various health care departments and doctors and surgeonsor Orthopedics, Joint, Knee and Hip Replacement Surgery, a dedicated team for IVF, Infertility and Gynecology, Neurosurgery, Brain Surgery Read More. . . ",
            style: AppTextStyles.text12WhiteRegular.copyWith(
                color: const Color(0xFF878787), fontWeight: FontWeight.w500),
          )
        ],
      ),
    );
  }

  _buildAllowCardWidget(dynamic Function(bool?) onChanged, bool isChecked) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
      decoration: BoxDecoration(
          color: AppColors.black121212.withOpacity(0.05),
          borderRadius: BorderRadius.circular(10.r),
          border: Border.all(color: AppColors.black900, width: 0.2)),
      child: Row(
        children: [
          CustomCheckbox(value: isChecked, onChanged: onChanged, title: ""),
          SizedBox(
            width: 240.w,
            child: Text(
                "Allow me as an alternate doctor if the primary doctor is not availabl",
                style: TextStyle(fontSize: 14.sp, color: AppColors.red600D8)),
          )
        ],
      ),
    );
  }
}
