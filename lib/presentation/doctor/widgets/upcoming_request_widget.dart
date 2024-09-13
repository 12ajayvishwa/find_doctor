import 'package:find_doctor/data/model/send_request_appoinment_model.dart';
import 'package:find_doctor/presentation/doctor/models/appointments_request_model.dart';
import 'package:find_doctor/utils/date_time_timeline.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/constants/app_export.dart';
import '../../../utils/empty_container.dart';
import '../controller/appointment_controller.dart';
import 'package:intl/intl.dart';

class UpcomingRequestWidget extends StatefulWidget {
  UpcomingRequestWidget({super.key});

  @override
  State<UpcomingRequestWidget> createState() => _UpcomingRequestWidgetState();
}

class _UpcomingRequestWidgetState extends State<UpcomingRequestWidget> {
  AppointmentController appointmentController =
      Get.put(AppointmentController());
  DayStructerController dayStructerController =
      Get.put(DayStructerController());

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      appointmentController.clearData();
      dayStructerController.selectedDate.value = null;
      dayStructerController.isDateSelected.value = false;
      appointmentController.day.value = 0;
      appointmentController.month.value = DateTime.now().month;
      appointmentController.year.value = DateTime.now().year;

      appointmentController.getUpcommingAppointment(status: "accepted");
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      // print(dayStructerController.selectedDate.value);
      // print(dayStructerController.month.value);

     
      if (appointmentController.rxRequestStatus.value == Status.loading) {
        return CustomLoading();
      }

      List<AppointmentRequestModel> filteredSurgeries = [];
      DateTime? selectedDate = dayStructerController.selectedDate.value;
      if (selectedDate == null) {
        filteredSurgeries = appointmentController.upcommingAppointmentsList;
      } else {
        filteredSurgeries =
            appointmentController.upcommingAppointmentsList.where((surgery) {
          DateTime surgeryDate = DateFormat("yyyy-MM-ddTHH:mm:ss.SSSZ")
              .parse(surgery.request!.surgeryDate!);
          return surgeryDate.day == selectedDate.day &&
              surgeryDate.month == selectedDate.month &&
              surgeryDate.year == selectedDate.year;
        }).toList();
      }
      if (filteredSurgeries.isEmpty) {
        return EmptyContainer(
          msg: dayStructerController.selectedDate.value == null
              ? "you don't have appointment"
              : "No appointment for ${dayStructerController.selectedDate.value.toString().replaceRange(11, 23, "")}",
        );
      }
      // var formatedDate = DateFormat('dd-MM-yyyy').format(
      //     DateTime.parse(dayStructerController.selectedDate.value.toString()));

      return SizedBox(
        height: 300.h,
        child: ListView.builder(
            padding: EdgeInsets.zero,
            itemCount: filteredSurgeries.length,
            shrinkWrap: true,
            itemBuilder: (context, index) {
              print(filteredSurgeries.length);
              var upcomingAppointment = filteredSurgeries[index];

              DateTime surgeryDate = DateFormat("yyyy-MM-ddTHH:mm:ss.SSSZ")
                  .parse(upcomingAppointment.request!.surgeryDate!);
              final dateFormat = DateFormat('dd');
              final dateDay = DateFormat('EEE');
              final formattedDate =
                  dateFormat.format(surgeryDate).toUpperCase();
              final formattedDay = dateDay.format(surgeryDate).toUpperCase();
              return InkWell(
                onTap: () {
                  Get.toNamed(AppRoutes.UPCOMMING_APPOINTMENT_SCREEN,
                      arguments: [upcomingAppointment, "Upcoming"]);
                },
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 500),
                  margin: EdgeInsets.only(
                      bottom: 5.h, right: 30.w, left: 30.w, top: 10.h),
                  width: double.maxFinite,
                  decoration: BoxDecoration(
                    color: AppColors.ksecondaryColor,
                    borderRadius: BorderRadius.circular(
                      15.r,
                    ),
                  ),
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
                                    "${upcomingAppointment.request!.startTime ?? ""} - ${upcomingAppointment.request!.endTime ?? ""}",
                                    style: AppTextStyles.text10White400,
                                  ),
                                  SizedBox(
                                    height: 5.h,
                                  ),
                                  SizedBox(
                                    width: 240.w,
                                    child: Text(
                                      upcomingAppointment.request!.title
                                         ??"",
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
                                      upcomingAppointment.request!.description ?? "",
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
}
