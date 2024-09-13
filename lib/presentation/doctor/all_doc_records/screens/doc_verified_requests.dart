import 'package:find_doctor/presentation/doctor/all_doc_records/widgets/card_widget.dart';
import 'package:find_doctor/utils/custom_toast.dart';
import 'package:find_doctor/widgets/custom_horizontal_calendar_filter_widget.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/constants/app_export.dart';
import '../../../../utils/empty_container.dart';
import '../../controller/appointment_controller.dart';
import '../../../../utils/date_time_timeline.dart';
import 'package:intl/intl.dart';

import '../../models/appointments_request_model.dart';

// ignore: must_be_immutable
class VerifiedRequestOfDoc extends StatefulWidget {
  const VerifiedRequestOfDoc({super.key});

  @override
  State<VerifiedRequestOfDoc> createState() => _VerifiedRequestOfDocState();
}

class _VerifiedRequestOfDocState extends State<VerifiedRequestOfDoc> {
  DayStructerController dayStructerController =
      Get.put(DayStructerController());
  AppointmentController appointmentController =
      Get.put(AppointmentController());

  @override
  void initState() {
    toast.init(context);
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      dayStructerController.selectedDategetMonth = null;
      appointmentController.month.value = DateTime.now().month;
      appointmentController.year.value = DateTime.now().year;
      dayStructerController.isDateSelected.value = false;
      appointmentController.clearData();
      appointmentController.getRequestAppointments(status: "approved");
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Column(children: [
        appBarContainer(size,
            title: "Doctor Verified Requests", isLeading: true),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: CustomHorizontalCalendarWidget(
            onChangedMonths: (value) {
              appointmentController.clearData();

              setState(() {
                dayStructerController.selectedMonth.value =
                    DateFormat('MMM').parse(value!).month;
                dayStructerController.selectedDategetMonth = DateTime(
                    dayStructerController.selectedYear.value,
                    dayStructerController.selectedMonth.value);
                dayStructerController.resetSelectedDate();
                appointmentController.month.value =
                    dayStructerController.selectedMonth.value;
              });
              print(dayStructerController.selectedMonth.value);

              appointmentController.getRequestAppointments(status: "approved");
            },
            onChangedYears: (value) {
              appointmentController.clearData();
              setState(() {
                appointmentController.month.value = 0;
                dayStructerController.selectedYear.value = value!;
                dayStructerController.selectedDategetMonth = DateTime(
                    dayStructerController.selectedYear.value,
                    dayStructerController.selectedMonth.value);
                dayStructerController.resetSelectedDate();
                appointmentController.year.value =
                    dayStructerController.selectedYear.value;
              });

              appointmentController.getRequestAppointments(status: "approved");
            },
          ),
        ),
        SizedBox(
          height: 20.h,
        ),
        Expanded(
          child: Obx(() {
            if (appointmentController.rxRequestStatus.value == Status.loading) {
              return CustomLoading();
            }

            List<AppointmentRequestModel> filteredSurgeries = [];
            DateTime? selectedDate = dayStructerController.selectedDate.value;
            if (selectedDate == null) {
              filteredSurgeries = appointmentController.requestAppointments;
            } else {
              filteredSurgeries =
                  appointmentController.requestAppointments.where((surgery) {
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
            return SizedBox(
                height: 0.h,
                child: RefreshIndicator(
                  color: AppColors.kprimary,
                  onRefresh: () {
                    appointmentController.clearData();

                    dayStructerController.selectedDate.value = null;

                    return appointmentController.getRequestAppointments(
                        status: "approved");
                  },
                  child: ListView.builder(
                    padding: const EdgeInsets.all(0.0),
                    shrinkWrap: true,
                    itemCount: filteredSurgeries.length,
                    itemBuilder: (context, index) {
                      final surgery = filteredSurgeries[index];
                      DateTime surgeryDate =
                          DateFormat("yyyy-MM-ddTHH:mm:ss.SSSZ")
                              .parse(surgery.request!.surgeryDate!);
                      final dateFormat = DateFormat('dd');
                      final dateDay = DateFormat('EEE');
                      final formattedDate =
                          dateFormat.format(surgeryDate).toUpperCase();
                      final formattedDay =
                          dateDay.format(surgeryDate).toUpperCase();

                      return CardWidget(
                          date: formattedDate,
                          day: formattedDay,
                          startTime: surgery.request!.startTime!,
                          endTime: surgery.request!.endTime!,
                          title: surgery.request!.title!,
                          status: surgery.status!,
                          onTap: () {
                            Get.toNamed(
                              AppRoutes.REQUEST_VERIFICATION_DETAILS_DOC,

                              arguments: surgery,
                            );
                          });
                    },
                  ),
                ));
          }),
        ),
      ]),
    );
  }
}
