import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../core/constants/app_export.dart';
import '../../../utils/empty_container.dart';
import 'package:intl/intl.dart';
import '../../doctor/controller/appointment_controller.dart';
import 'accept_request_widget.dart';
import 'surgery_details_card.dart';

class AppointmentAcceptedWidget extends StatefulWidget {
  final dynamic data;
  const AppointmentAcceptedWidget({super.key, required this.data});

  @override
  State<AppointmentAcceptedWidget> createState() =>
      _AppointmentAcceptedWidgetState();
}

class _AppointmentAcceptedWidgetState extends State<AppointmentAcceptedWidget> {
  RequestController requestController = Get.put(RequestController());
  AppointmentController appointmentController =
      Get.put(AppointmentController());
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      requestController.clearData();
      appointmentController.clearData();
      requestController.getRequestAppoinments(
          requestId: widget.data.id, status: "accepted");
    });

    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    print(widget.data.id);
    return Obx(() {
      if (requestController.rxRequestStatus.value == Status.loading) {
        return const CustomLoading();
      }

      if (requestController.requestAppointmentList.isEmpty) {
        return EmptyContainer(
          imageUrl: "assets/svg/pending.svg",
          msg: 'No one accepted request',
        );
      }
      return Stack(
        children: [
          Column(
            children: [
              SurgeryDetailsCard(
                isAccept: true,
                data: widget.data,
              ),
              SizedBox(
                height: size.height / 1.6,
                child: ListView.builder(
                  padding:
                      EdgeInsets.symmetric(vertical: 10.h, horizontal: 2.w),
                  shrinkWrap: true,
                  itemCount: requestController.requestAppointmentList.length,
                  itemBuilder: (context, index) {
                    var data = requestController.requestAppointmentList[index];
                    DateFormat format = DateFormat.Hm();
                    DateTime time = format.parse(data.request!.startTime!);
                    return AcceptRequestWidget(
                      // isPrimary: true,
                      // imageUrl: "assets/svg/doctor_image1.png",
                      onTap: () {
                        Get.toNamed(AppRoutes.DOCTOR_PROFILE,
                            arguments: data.doctor);
                      },
                      
                      name: "Dr. ${data.doctor!.name}",
                      designation: data.doctor!.specialization!.name,
                      gender: data.doctor!.gender,
                      experince: data.doctor!.experience == null
                          ? "No experience"
                          : "${data.doctor!.experience} Years experience",
                      // patientStories: "78 Patient Stories",
                      // percent: "85%",
                      // revoked: "01 Revoked",
                      isVerified: data.doctor!.verified == 0 ? "false" : "true",
                      isHideButton: false,
                      isPrimary: data.isPrimary == 1 ? true : false,

                      isAlternet:
                          data.statusMode == "alternate" ? "alternate" : null,
                      available: data.doctor!.active == 1
                          ? "Available"
                          : "Not  Available",
                      surgeryTime: DateFormat('hh:mm a').format(time),
                      surgeryDate: DateFormat('dd MMMM')
                          .format(data.request!.surgeryDate!),

                      onTapPrimary: () {
                        appointmentController.appointmentModeChange(
                            action: "primary", id: data.id);
                      },
                      onTapAlternate: () {
                        appointmentController.appointmentModeChange(
                            action: "alternate", id: data.id);
                      },
                      onTapDecline: () {
                        appointmentController.appointmentModeChange(
                            action: "decline", id: data.id);
                      },
                    );
                  },
                ),
              ),
            ],
          ),
          appointmentController.rxRequestStatus.value == Status.loading
              ? Container(
                  width: size.width,
                  height: size.height,
                  // decoration: BoxDecoration(
                  //   color: AppColors.black121212.withOpacity(0.2),
                  // ),
                  child: Center(
                    child: Container(
                        height: 80.h,
                        width: 80.w,
                        decoration: BoxDecoration(
                            color: AppColors.whiteA700,
                            borderRadius: BorderRadius.circular(8.r),
                            boxShadow: [
                              BoxShadow(
                                color: AppColors.black121212,
                              )
                            ]),
                        child: CustomLoading()),
                  ),
                )
              : Container(),
        ],
      );
    });
  }
}
