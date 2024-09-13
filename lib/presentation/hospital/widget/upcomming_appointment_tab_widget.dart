import 'package:find_doctor/presentation/doctor/controller/appointment_controller.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/constants/app_export.dart';
import '../../../utils/empty_container.dart';

import 'package:intl/intl.dart';
import 'package:timeago/timeago.dart' as timeago;
import '../../../widgets/custom_time_ago.dart';
import '../../../widgets/request_card_widget.dart';
import '../../../utils/date_time_timeline.dart';

class UpcommingAppointmentTabWidget extends StatefulWidget {
  const UpcommingAppointmentTabWidget({super.key});

  @override
  State<UpcommingAppointmentTabWidget> createState() =>
      _UpcommingAppointmentTabWidgetState();
}

class _UpcommingAppointmentTabWidgetState
    extends State<UpcommingAppointmentTabWidget> {
  //RequestController requestController = Get.put(RequestController());
  AppointmentController appointmentController =
      Get.put(AppointmentController());
  DayStructerController dayStructerController =
      Get.put(DayStructerController());

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      dayStructerController.selectedDate.value = null;
      dayStructerController.isDateSelected.value = false;
      appointmentController.clearData();
      appointmentController.getRequestAppointments(status: "accepted");
    });

    super.initState();
  }

  @override
  void dispose() {
    Get.delete<AppointmentController>();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    print(appointmentController.requestAppointments.length);
    return Obx(() {
      if (appointmentController.rxRequestStatus.value == Status.loading) {
        return const CustomLoading();
      }
      print('rahul ${appointmentController.requestAppointments.length}');
      if (appointmentController.requestAppointments.isEmpty) {
        return EmptyContainer(
          msg: dayStructerController.selectedDate.value == null
              ? "you don't have any request"
              : "No appointment for ${DateFormat('dd/MM/yyyy').format(dayStructerController.selectedDate.value!)}",
        );
      }
      return SizedBox(
        height: 300.h,
        child: RefreshIndicator(
          color: AppColors.kprimary,
          onRefresh: () {
            appointmentController.clearData();

            dayStructerController.selectedDate.value = null;

            return appointmentController.getRequestAppointments(status: "accepted");
          },
          child: ListView.builder(
            padding: EdgeInsets.zero,
            itemCount: appointmentController.requestAppointments.length,
            shrinkWrap: true,
            itemBuilder: (context, index) {
              final surgery = appointmentController.requestAppointments[index];
              DateTime surgeryDate = DateFormat("yyyy-MM-ddTHH:mm:ss.SSSZ")
                  .parse(surgery.request!.surgeryDate!);
              final dateFormat = DateFormat('dd');
              final dateDay = DateFormat('EEE');
              final formattedDate =
                  dateFormat.format(surgeryDate).toUpperCase();
              final formattedDay = dateDay.format(surgeryDate).toUpperCase();
              DateTime sentAt = DateTime.parse(surgery.createdAt.toString());
              timeago.setLocaleMessages('custom', CustomTimeMessages());
              String timeAgo = timeago.format(sentAt, locale: 'custom');
              return InkWell(
                onTap: () {
                  Get.toNamed(AppRoutes.REQUEST_DETAIL,
                      arguments: [surgery, 0]);
                },
                child: RequestCardWidget(
                  onTap: () {
                    Get.toNamed(AppRoutes.REQUEST_DETAIL,
                        arguments: [surgery, 0]);
                  },
                  date: formattedDate,
                  dateDay: formattedDay,
                  timeAgo: timeAgo,
                  titile: surgery.request!.title,
                  msg: surgery.request!.description,
                ),
              );
            },
          ),
        ),
      );
    });
  }
}
