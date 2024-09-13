import 'package:find_doctor/data/model/send_request_model.dart';
import 'package:find_doctor/presentation/hospital/widget/surgery_details_card.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../core/constants/api_network.dart';
import '../../../core/constants/app_export.dart';
import '../../../utils/empty_container.dart';
import 'package:intl/intl.dart';

import '../../../widgets/doctor_card_widget.dart';

class AppointmentSendedWidget extends StatefulWidget {
  final dynamic data;
  const AppointmentSendedWidget({super.key, required this.data});

  @override
  State<AppointmentSendedWidget> createState() =>
      _AppointmentSendedWidgetState();
}

class _AppointmentSendedWidgetState extends State<AppointmentSendedWidget> {
  RequestController requestController = Get.put(RequestController());

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      requestController.clearData();

      requestController.getRequestAppoinments(
          requestId: widget.data.id, status: "pending");
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
    return Obx(() {
      if (requestController.rxRequestStatus.value == Status.loading) {
        return const CustomLoading();
      }

      if (requestController.requestAppointmentList.isEmpty) {
        return EmptyContainer(
          imageUrl: "assets/svg/accepted.svg",
          msg: 'All Doctor Accepted Request',
        );
      }
      return Column(
        children: [
          SurgeryDetailsCard(
            isAccept: true,
            data: widget.data,
          ),
          SizedBox(
            height: size.height / 1.6,
            child: ListView.builder(
              padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 2.w),
              shrinkWrap: true,
              itemCount: requestController.requestAppointmentList.length,
              itemBuilder: (context, index) {
                var data = requestController.requestAppointmentList[index];
                DateFormat format = DateFormat.Hm();
                DateTime time = format.parse(data.request!.startTime!);
                return DoctorCardWidget(
                    onTap: () {
                      Get.toNamed(AppRoutes.DOCTOR_PROFILE,
                          arguments: data.doctor);
                    },
                     gender: data.doctor!.gender ?? "male",
                    imageUrl: data.doctor!.avatar == null
                        ? null
                        : ApiNetwork.imageUrl + data.doctor!.avatar,
                    name: "Dr. ${data.doctor!.name ?? "N/A"}",
                    designation: data.doctor!.specialization!.name ?? "N/A",
                    experince: data.doctor!.experience == null
                        ? "No experience"
                        : "${data.doctor!.experience} Years experience",
                    // patientStories: "78 Patient Stories",
                    // percent: "85%",
                    isVerified: data.doctor!.verified == 0 ? "false" : "true",
                   // isSeen: data.request!.status == "pending" ? false : true
                    );
              },
            ),
          ),
        ],
      );
    });
  }
}
