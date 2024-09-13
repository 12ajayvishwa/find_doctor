import 'package:find_doctor/data/model/send_request_appoinment_model.dart';
import 'package:find_doctor/data/model/send_request_model.dart';
import 'package:find_doctor/utils/custom_toast.dart';
import 'package:find_doctor/widgets/custom_horizontal_calendar_filter_widget.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../core/constants/app_export.dart';
import '../../../utils/empty_container.dart';
import '../../doctor/all_doc_records/widgets/card_widget.dart';
import '../../../utils/date_time_timeline.dart';
import 'package:intl/intl.dart';

// ignore: must_be_immutable
class RequestVerify extends StatefulWidget {
  RequestVerify({super.key});

  @override
  State<RequestVerify> createState() => _RequestVerifyState();
}

class _RequestVerifyState extends State<RequestVerify> {
  DayStructerController dayStructerController =
      Get.put(DayStructerController());
  RequestController requestController = Get.put(RequestController());

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      dayStructerController.selectedDategetMonth = null;
      requestController.month.value = DateTime.now().month;
      requestController.year.value = DateTime.now().year;
      dayStructerController.isDateSelected.value = false;
      requestController.clearData();
      requestController.getRequest(status: "completed");
    });

    toast.init(context);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Column(children: [
        appBarContainer(size,
            title: "Request Verify",
            isLeading: true,
            leading: IconButton(
                onPressed: () {
                  Get.offAllNamed(AppRoutes.DASHBOARD, arguments: [4,0]);
                },
                icon: Icon(
                  Icons.arrow_back,
                  color: AppColors.black900,
                ))),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: CustomHorizontalCalendarWidget(
            onChangedMonths: (value) {
              requestController.clearData();

              setState(() {
                requestController.day.value = 0;
                dayStructerController.selectedMonth.value =
                    DateFormat('MMM').parse(value!).month;
                dayStructerController.selectedDategetMonth = DateTime(
                    dayStructerController.selectedYear.value,
                    dayStructerController.selectedMonth.value);
                dayStructerController.resetSelectedDate();
                dayStructerController.isDateSelected.value = false;
                requestController.month.value =
                    dayStructerController.selectedDategetMonth!.month;
              });

              requestController.getRequest(status: "completed");
            },
            onChangedYears: (value) {
              requestController.clearData();
              setState(() {
                requestController.month.value = 0;
                dayStructerController.selectedYear.value = value!;
                dayStructerController.selectedDategetMonth = DateTime(
                    dayStructerController.selectedYear.value,
                    dayStructerController.selectedMonth.value);
                dayStructerController.resetSelectedDate();
                requestController.year.value =
                    dayStructerController.selectedYear.value;
              });

              requestController.getRequest(status: "completed");
            },
          ),
        ),
        SizedBox(
          height: 20.h,
        ),
        Expanded(
          child: Obx(() {
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
                    return requestController.getRequest(
                        status: "completed");
                  },
                  child: ListView.builder(
                    padding: const EdgeInsets.all(0.0),
                    shrinkWrap: true,
                    itemCount: filteredSurgeries.length,
                    itemBuilder: (context, index) {
                      final surgery = filteredSurgeries[index];
                      DateTime surgeryDate =
                          DateFormat("yyyy-MM-ddTHH:mm:ss.SSSZ")
                              .parse(surgery.surgeryDate);
                      final dateFormat = DateFormat('dd');
                      final dateDay = DateFormat('EEE');
                      // final formattedYear = DateFormat('yyyy')
                      //     .format(surgery.request!.surgeryDate!);
                      // final formattedMonth = DateFormat('M')
                      //     .format(surgery.request!.surgeryDate!);
                      final formattedDate = dateFormat
                          .format(surgeryDate!)
                          .toUpperCase();
                      final formattedDay = dateDay
                          .format(surgeryDate!)
                          .toUpperCase();

                      return CardWidget(
                          date: formattedDate,
                          day: formattedDay,
                          startTime: surgery.startTime!,
                          endTime: surgery.endTime!,
                          title: surgery.title!,
                          status: surgery.status!,
                          onTap: () {
                            Get.toNamed(
                              AppRoutes.REQUEST_APPROVE,
                              arguments: 
                                surgery,
                                
                              
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
