import 'package:find_doctor/widgets/custom_horizontal_calendar_filter_widget.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import '../../../../core/constants/app_export.dart';
import '../../../../utils/custom_toast.dart';
import '../../../dashboard.dart';
import '../../../doctor/controller/appointment_controller.dart';
import '../../../../utils/date_time_timeline.dart';
import 'request_tab_widgets/request_accepted_tab_widget.dart';
import 'request_tab_widgets/request_sended_tab_widget.dart';

class AllRequestScreen extends StatefulWidget {
  const AllRequestScreen({super.key});

  @override
  State<AllRequestScreen> createState() => _AllRequestScreenState();
}

class _AllRequestScreenState extends State<AllRequestScreen>
    with SingleTickerProviderStateMixin {
  DayStructerController dayStructerController =
      Get.put(DayStructerController());
  RequestController requestController = Get.put(RequestController());
  AppointmentController appointmentController =
      Get.put(AppointmentController());

  static List<Tab> tabs = <Tab>[
    const Tab(
      text: "Request Send",
    ),
    const Tab(text: 'Requests Accepted'),
  ];
  late TabController _tabController;

  int? tabIndex = 0;

  bool? isSelected = false;
  void _onTabChanged(int index) {
    setState(() {
      tabIndex = index;
      dayStructerController.selectedDategetMonth = null;
      requestController.month.value = DateTime.now().month;
      requestController.year.value = DateTime.now().year;
      dayStructerController.month.value = DateTime.now().month;
      dayStructerController.selectedYear.value = DateTime.now().year;
      dayStructerController.isDateSelected.value = false;
    });
  }

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
       dayStructerController.selectedDate.value = null;
    });
   
    toast.init(context);
    super.initState();
    _tabController = TabController(
        vsync: this, length: tabs.length, initialIndex: tabIndexOfApn ?? 0);
    _tabController.addListener(() {
      _onTabChanged(_tabController.index);
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Column(
        children: [
          appBarContainer(size,
              title: "All Request",
              isTabBar: true,
              tabBar: TabBar(
                  indicatorColor: AppColors.kprimary,
                  indicatorSize: TabBarIndicatorSize.tab,
                  indicatorWeight: 3.h,
                  labelStyle: AppTextStyles.text16BlackBold.copyWith(
                    fontSize: 14.sp,
                  ),
                  onTap: (value) {
                    _onTabChanged(value);
                  },
                  indicatorPadding: const EdgeInsets.all(0),
                  labelColor: AppColors.kprimary,
                  unselectedLabelColor: AppColors.gray,
                  controller: _tabController,
                  tabs: tabs)),
          SizedBox(
            height: 10.h,
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 10.w),
              child: Container(
                decoration: BoxDecoration(
                    color: AppColors.whiteA700,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(25.r),
                        topRight: Radius.circular(25.r)),
                    boxShadow: [
                      BoxShadow(
                          color: AppColors.gray.withOpacity(0.1),
                          spreadRadius: 5,
                          blurRadius: 12)
                    ]),
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 0.w),
                      child: CustomHorizontalCalendarWidget(
                        onChangedMonths: (value) {
                          requestController.clearData();

                          setState(() {
                            dayStructerController.selectedMonth.value =
                                DateFormat('MMM').parse(value!).month;
                            dayStructerController.selectedDategetMonth =
                                DateTime(
                                    dayStructerController.selectedYear.value,
                                    dayStructerController.selectedMonth.value);
                            dayStructerController.resetSelectedDate();
                            requestController.month.value =
                                dayStructerController.selectedMonth.value;
                          });
                          print(dayStructerController.selectedMonth.value);
                          print(tabIndex);
                          tabIndex == 0
                              ? requestController.getRequest(status: "pending")
                              : requestController.getRequest(
                                  status: "accepted");
                        },
                        onChangedYears: (value) {
                          requestController.clearData();
                          setState(() {
                            requestController.month.value = 0;
                            dayStructerController.selectedYear.value = value!;
                            dayStructerController.selectedDategetMonth =
                                DateTime(
                                    dayStructerController.selectedYear.value,
                                    dayStructerController.selectedMonth.value);
                            dayStructerController.resetSelectedDate();
                            requestController.year.value =
                                dayStructerController.selectedYear.value;
                          });

                          tabIndex == 0
                              ? requestController.getRequest(status: "pending")
                              : requestController.getRequest(
                                  status: "accepted");
                        },
                      ),
                    ),
                    Expanded(
                      child: TabBarView(
                          physics: const NeverScrollableScrollPhysics(),
                          controller: _tabController,
                          children: const [
                            RequestSendedTabWidget(),
                            RequestAcceptedTabWidget()
                          ]),
                    ),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
