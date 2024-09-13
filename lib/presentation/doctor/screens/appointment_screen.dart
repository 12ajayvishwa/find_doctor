import 'package:find_doctor/core/constants/app_export.dart';
import 'package:find_doctor/utils/custom_toast.dart';
import 'package:find_doctor/widgets/custom_horizontal_calendar_filter_widget.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../dashboard.dart';
import '../controller/appointment_controller.dart';
import '../../../utils/date_time_timeline.dart';
import '../widgets/requests_tab_widget.dart';
import '../widgets/upcoming_request_widget.dart';
// ignore: depend_on_referenced_packages
import 'package:intl/intl.dart';

class AppointmentScreen extends StatefulWidget {
  const AppointmentScreen({super.key});

  @override
  State<AppointmentScreen> createState() => _AppointmentScreenState();
}

class _AppointmentScreenState extends State<AppointmentScreen>
    with TickerProviderStateMixin {
  DayStructerController dayStructerController =
      Get.put(DayStructerController());
  AppointmentController appointmentController =
      Get.put(AppointmentController());

  static List<Tab> tabs = <Tab>[
    const Tab(
      text: "Upcoming",
    ),
    const Tab(
      text: 'Requests',
    ),
  ];
  late TabController _tabController;

  @override
  void initState() {
    dayStructerController.selectedDate.value = null;
    toast.init(context);
    super.initState();
    _tabController = TabController(
        vsync: this, length: tabs.length, initialIndex: tabIndexOfApn ?? 0);
    _tabController.addListener(() {
      _onTabChanged(_tabController.index);
    });
  }

  bool? isSelected = false;
  int? tabIndex = 0;

  void _onTabChanged(int index) {
    setState(() {
      tabIndex = index;
      dayStructerController.selectedDategetMonth = null;
      appointmentController.month.value = DateTime.now().month;
      appointmentController.year.value = DateTime.now().year;
      dayStructerController.month.value = DateTime.now().month;
      dayStructerController.selectedYear.value = DateTime.now().year;
      dayStructerController.isDateSelected.value = false;
    });
  }

  @override
  void dispose() {
    _tabController.removeListener(() {
      _onTabChanged(_tabController.index);
    });
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    print("tabIndexOfApn");
    return Scaffold(
        body: Column(
      children: [
        appBarContainer(size,
            title: "Appointments",
            isTabBar: true,
            tabBar: TabBar(
                indicatorColor: AppColors.kprimary,
                indicatorSize: TabBarIndicatorSize.tab,
                indicatorWeight: 3.h,
                physics: const NeverScrollableScrollPhysics(),
                labelStyle: AppTextStyles.text16BlackBold.copyWith(
                  fontSize: 14.sp,
                ),
                onTap: (value) {
                  _onTabChanged(value);
                  print(value);
                },
                indicatorPadding: const EdgeInsets.all(0),
                labelColor: AppColors.kprimary,
                unselectedLabelColor: AppColors.gray,
                controller: _tabController,
                tabs: tabs)),
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
              print(tabIndex);
              tabIndex == 0
                  ? appointmentController.getUpcommingAppointment(
                      status: "accepted")
                  : appointmentController.getRequestAppointments(
                      status: "pending");
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
              print(tabIndex);
              tabIndex == 0
                  ? appointmentController.getUpcommingAppointment(
                      status: "accepted")
                  : appointmentController.getRequestAppointments(
                      status: "pending");
            },
          ),
        ),
        SizedBox(
          height: 20.h,
        ),
        Expanded(
          child: TabBarView(
              physics: const NeverScrollableScrollPhysics(),
              controller: _tabController,
              children: [UpcomingRequestWidget(), const RequestTabWidget()]),
        )
      ],
    ));
  }
}
