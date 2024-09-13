import 'package:find_doctor/data/model/send_request_model.dart';
import 'package:find_doctor/presentation/doctor/controller/appointment_controller.dart';
import 'package:find_doctor/utils/custom_toast.dart';
import 'package:find_doctor/utils/date_time_timeline.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/constants/app_export.dart';
import '../../../../data/model/send_request_appoinment_model.dart';
import '../../../../widgets/success_dialog.dart';
import '../../widget/accept_request_widget.dart';
import 'package:intl/intl.dart';

class RequestApproveScreen extends StatefulWidget {
  const RequestApproveScreen({super.key});

  @override
  State<RequestApproveScreen> createState() => _RequestApproveScreenState();
}

class _RequestApproveScreenState extends State<RequestApproveScreen> {
  RequestController requestController = Get.put(RequestController());
  AppointmentController appointmentController =
      Get.put(AppointmentController());
  DayStructerController dayStructerController =
      Get.put(DayStructerController());
  SendRequestModel data = Get.arguments;

  @override
  void initState() {
    toast.init(context);

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      requestController.clearData();

      requestController.getRequestAppoinments(
          requestId: data.id, status: "completed");
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Obx(() {
        isPrimaryDisable = false;
        return Stack(
          children: [
            SizedBox(
              height: double.infinity,
              width: double.infinity,
              child: Stack(children: [
                appBarContainer(size,
                    title: "Approve Request",
                    isLeading: true,
                    leading: IconButton(
                        onPressed: () {
                          Get.offAndToNamed(AppRoutes.REQUEST_VERIFY);
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
                Positioned(
                  top: 120.h,
                  right: 10.w,
                  left: 10.w,
                  child: surgeryDetailsCard(size, true, data),
                ),
                Positioned(
                  top: 280.h,
                  right: 0.w,
                  left: 0.w,
                  bottom: 10.h,
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: requestController.requestAppointmentList.length,
                    itemBuilder: (context, index) {
                      SendRequestAppoinmentModel data =
                          requestController.requestAppointmentList[index];
                      return AcceptRequestWidget(
                        onTap: () {
                          Get.toNamed(AppRoutes.DOCTOR_PROFILE,
                              arguments: data.doctor);
                        },
                        // imageUrl: "assets/svg/doctor_image1.png",
                        name: "Dr. ${data.doctor!.name}",
                        designation: "${data.doctor!.specialization!.name}",
                        experince: data.doctor!.experience == null
                            ? "No experience"
                            : "${data.doctor!.experience} Years experience",
                        // patientStories: "78 Patient Stories",
                        // percent: "85%",
                        // revoked: "01 Revoked",
                        // isVerified: true,

                        isHideButton: data.status == "approved" ||
                                data.status == "decline"
                            ? false
                            : true,
                        isApproved: data.status == "approved"
                            ? "approved"
                            : data.status == "decline"
                                ? "decline"
                                : "",

                        onTapPrimary: () {
                          appointmentController.appointmentApprove(
                              action: "approved", id: data.id);
                          
                        },
                        onTapDecline: () {
                          appointmentController.appointmentApprove(
                              action: "decline", id: data.id);
                        },
                      );
                    },
                  ),
                ),
              ]),
            ),
            appointmentController.rxRequestStatus.value == Status.loading
                ? Container(
                    width: size.width,
                    height: size.height,
                    decoration: BoxDecoration(
                      color: AppColors.black121212.withOpacity(0.6),
                    ),
                    child: Center(
                      child: CustomLoading(),
                    ),
                  )
                : Container(),
          ],
        );
      }),
    );
  }

  surgeryDetailsCard(Size size, isAccept, SendRequestModel data) {
    DateTime surgeryDate =
        DateFormat("yyyy-MM-ddTHH:mm:ss.SSSZ").parse(data.surgeryDate!);
    final dateFormat = DateFormat('dd');
    final dateDay = DateFormat('EEE');
    final formattedDate =
        dateFormat.format(surgeryDate).toUpperCase();
    final formattedDay =
        dateDay.format(surgeryDate).toUpperCase();
    DateTime startTime1 = DateFormat("HH:mm").parse(data.startTime!);
    DateTime endTime1 = DateFormat("HH:mm").parse(data.endTime!);
    String startTime = DateFormat("h:mm a").format(startTime1);
    String endTime = DateFormat("h:mm a").format(endTime1);
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
      child: Container(
        height: size.height * 0.17,
        width: double.infinity,
        decoration: BoxDecoration(
            color: AppColors.whiteA700,
            borderRadius: BorderRadius.circular(15.r),
            boxShadow: [
              BoxShadow(
                  color: AppColors.gray.withOpacity(0.2),
                  spreadRadius: 1,
                  blurRadius: 7)
            ]),
        child: Stack(
          children: [
            // Positioned(
            //   top: 0,
            //   right: 0,
            //   child: IconButton(
            //       onPressed: () {},
            //       icon: Icon(
            //         Icons.more_vert,
            //         color: AppColors.gray,
            //       )),
            // ),
            Positioned(
              bottom: 15.h,
              left: 15.w,
              child: Container(
                decoration: BoxDecoration(
                    color: AppColors.kprimary.withOpacity(0.08),
                    borderRadius: BorderRadius.circular(2.r)),
                child: Padding(
                  padding: const EdgeInsets.all(6.0),
                  child: Text(
                    "$startTime - $endTime",
                    style: AppTextStyles.text12WhiteRegular.copyWith(
                        fontWeight: FontWeight.w500, color: AppColors.kprimary),
                  ),
                ),
              ),
            ),
            Positioned(
                top: 15.h,
                left: 15.w,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: EdgeInsets.symmetric(
                          horizontal: 20.w, vertical: 20.h),
                      decoration: BoxDecoration(
                        color: AppColors.kprimary,
                        borderRadius: BorderRadius.circular(15.r),
                      ),
                      child: Column(
                        children: [
                          Text(formattedDate,
                              textAlign: TextAlign.center,
                              style: AppTextStyles.text14White400),
                          Text(formattedDay,
                              textAlign: TextAlign.center,
                              style: AppTextStyles.text14White400),
                        ],
                      ),
                    ),
                    SizedBox(
                      width: 10.w,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(
                          width: 250.w,
                          child: Text(
                            data.title.toString().capitalizeFirst!,
                            overflow: TextOverflow.ellipsis,
                            style: AppTextStyles.headline,
                          ),
                        ),
                        SizedBox(
                          height: 5.h,
                        ),
                        SizedBox(
                          width: 250.w,
                          child: Text(
                            data.hospital!.name! ?? "",
                            overflow: TextOverflow.ellipsis,
                            style: AppTextStyles.text12WhiteRegular
                                .copyWith(color: AppColors.kprimary),
                          ),
                        ),
                        SizedBox(
                          height: 5.h,
                        ),
                        // SizedBox(
                        //   width: 250.w,
                        //   child: Text(
                        //     isAccept == true
                        //         ? "${data.noOfDoctors} Doctors Available"
                        //         : "${data.noOfDoctors} Request sended",
                        //     overflow: TextOverflow.ellipsis,
                        //     style: AppTextStyles.text12WhiteRegular
                        //         .copyWith(color: AppColors.gray),
                        //   ),
                        // ),
                        // isAccept == false
                        //     ? Container()
                        //     : SizedBox(
                        //         width: 250.w,
                        //         child: Text(
                        //           "${data.noOfDoctors}  Doctor Required",
                        //           overflow: TextOverflow.ellipsis,
                        //           style: AppTextStyles.text12WhiteRegular
                        //               .copyWith(color: AppColors.gray),
                        //         ),
                        //       )
                      ],
                    )
                  ],
                ))
          ],
        ),
      ),
    );
  }
}
