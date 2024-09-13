import 'package:find_doctor/data/model/send_request_appoinment_model.dart';
import 'package:find_doctor/utils/date_time_timeline.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/constants/app_export.dart';
import '../../../../../data/model/send_request_model.dart';
import 'package:intl/intl.dart';

import '../../../../../utils/empty_container.dart';
import '../../../../../widgets/custom_time_ago.dart';
import 'package:timeago/timeago.dart' as timeago;

import '../../../../../widgets/request_card_widget.dart';

class RequestSendedTabWidget extends StatefulWidget {
  const RequestSendedTabWidget({super.key});

  @override
  State<RequestSendedTabWidget> createState() => _RequestSendedTabWidgetState();
}

class _RequestSendedTabWidgetState extends State<RequestSendedTabWidget> {
  RequestController requestController = Get.put(RequestController());
  DayStructerController dayStructerController =
      Get.put(DayStructerController());

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      requestController.clearData();
      dayStructerController.selectedDate.value = null;
      dayStructerController.isDateSelected.value = false;
      requestController.day.value = 0;
      requestController.month.value = DateTime.now().month;
      requestController.year.value = DateTime.now().year;
      requestController.getRequest(status: "pending");
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (requestController.rxRequestStatus.value == Status.loading) {
        return CustomLoading();
      }

      List<SendRequestModel> filteredSurgeries = [];
      DateTime? selectedDate = dayStructerController.selectedDate.value;
      if (selectedDate == null) {
        filteredSurgeries = requestController.requestsList;
      } else {
        filteredSurgeries =
            requestController.requestsList.where((surgery) {
          DateTime surgeryDate = DateFormat("yyyy-MM-ddTHH:mm:ss.SSSZ")
              .parse(surgery.surgeryDate!);
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
      return SizedBox(
        height: 300.h,
        child: RefreshIndicator(
          color: AppColors.kprimary,
          onRefresh: () {
            requestController.clearData();

            dayStructerController.selectedDate.value = null;

            return requestController.getRequest(status: "pending");
          },
          child: ListView.builder(
            padding: EdgeInsets.zero,
            itemCount: filteredSurgeries.length,
            shrinkWrap: true,
            itemBuilder: (context, index) {
              final surgery = filteredSurgeries[index];
              DateTime surgeryDate = DateFormat("yyyy-MM-ddTHH:mm:ss.SSSZ")
                  .parse(surgery.surgeryDate!);
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
                  titile: surgery.title,
                  msg: surgery.title!,
                ),
              );
            },
          ),
        ),
      );
    });
  }
}
