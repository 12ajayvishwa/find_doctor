import 'package:find_doctor/core/constants/app_export.dart';
import 'package:find_doctor/presentation/hospital/controller/global_search_controller.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../widgets/request_card_widget.dart';
import '../../../../utils/date_time_timeline.dart';
import 'package:intl/intl.dart';

class HospitalPaymentProcessScreen extends StatefulWidget {
  const HospitalPaymentProcessScreen({super.key});

  @override
  State<HospitalPaymentProcessScreen> createState() =>
      _HospitalPaymentProcessScreenState();
}

class _HospitalPaymentProcessScreenState
    extends State<HospitalPaymentProcessScreen>
    with SingleTickerProviderStateMixin {
  DayStructerController dayStructerController =
      Get.put(DayStructerController());
  GlobalSearchController globalSearchController =
      Get.put(GlobalSearchController());
  static List<Tab> tabs = <Tab>[
    const Tab(
      text: "Update Status",
    ),
    const Tab(
      text: 'Payment Record',
    ),
  ];
  late TabController _tabController;
  @override
  void initState() {
    super.initState();
    _tabController = TabController(vsync: this, length: tabs.length);
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
      body: SingleChildScrollView(
        child: SizedBox(
          height: size.height,
          width: double.infinity,
          child: Stack(
            children: [
              appBarContainer(size,
                  title: "Payment Process",
                  isLeading: true,
                  isTabBar: true,
                  leading: IconButton(onPressed: (){
                    Get.offAndToNamed(AppRoutes.DASHBOARD,arguments:[4,0]);
                  }, icon: Icon(Icons.arrow_back)),
                  tabBar: TabBar(
                    indicatorColor: AppColors.kprimary,
                    indicatorSize: TabBarIndicatorSize.tab,
                    indicatorWeight: 3.h,
                    labelStyle: AppTextStyles.text16BlackBold.copyWith(
                      fontSize: 14.sp,
                    ),
                    indicatorPadding: const EdgeInsets.all(0),
                    labelColor: AppColors.kprimary,
                    unselectedLabelColor: AppColors.gray,
                    controller: _tabController,
                    tabs: tabs,
                  )),
              Positioned(
                bottom: -40.h,
                right: -15.w,
                child: SvgPicture.asset("assets/svg/Rectangle 5904.svg"),
              ),
              Positioned(
                top: 150.h,
                right: 10.w,
                left: 10.w,
                child: dayStructerController.changeDayStructureExample(),
              ),
              Positioned(
                top: 310.h,
                right: 10.w,
                left: 10.w,
                child: const CustomTextFormField(
                  hintText: "Search",
                  // labelText: "Search",
                  prefix: Icon(Icons.search),
                ),
              ),
              Positioned(
                top: 375.h,
                right: 0.w,
                left: 0.w,
                bottom: 10.h,
                child: TabBarView(
                    controller: _tabController,
                    children: [statusUpdate(), paymentRecord(size)]),
              )
            ],
          ),
        ),
      ),
    );
  }

  paymentRecord(size) {
    return Padding(
      padding:  EdgeInsets.symmetric(
          // horizontal: 10.w,
          ),
      child: SizedBox(
        height: 300.h,
        width: 300.w,
        child: ListView.builder(
          itemCount: 8,
          shrinkWrap: true,
          itemBuilder: (context, index) {
            return surgeryDetailsCard(context);
          },
        ),
      ),
    );
  }

  surgeryDetailsCard(size) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
      child: Container(
        height: 150.h,
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
            Positioned(
              top: 0,
              right: 0,
              child: IconButton(
                  onPressed: () {},
                  icon: Icon(
                    Icons.more_vert,
                    color: AppColors.gray,
                  )),
            ),
            Positioned(
                bottom: 10.w,
                right: 15.w,
                child: Row(
                  children: [
                    IconButton(onPressed: () {}, icon: const Icon(Icons.print)),
                    IconButton(
                        onPressed: () {}, icon: const Icon(Icons.visibility))
                  ],
                )),
            Positioned(
                top: 20.w,
                right: 40.w,
                child: Container(
                  padding:
                      EdgeInsets.symmetric(horizontal: 10.w, vertical: 5.h),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30.r),
                      border: Border.all(color: Colors.orange)),
                  child: Text(
                    "Pending",
                    style:
                        AppTextStyles.bodyText.copyWith(color: Colors.orange),
                  ),
                )),
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
                    "02:30 PM - 05:00 PM",
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
                      height: 80.h,
                      padding: EdgeInsets.symmetric(
                          horizontal: 20.w, vertical: 10.h),
                      decoration: BoxDecoration(
                        color: AppColors.kprimary,
                        borderRadius: BorderRadius.circular(15.r),
                      ),
                      child: Center(
                        child: Text("335",
                            textAlign: TextAlign.center,
                            style: AppTextStyles.text14White400),
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
                          child: const Text(
                            "Tooth Extraction",
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
                            "Bansal hospital",
                            overflow: TextOverflow.ellipsis,
                            style: AppTextStyles.text12WhiteRegular
                                .copyWith(color: AppColors.kprimary),
                          ),
                        ),
                        SizedBox(
                          height: 5.h,
                        ),
                        SizedBox(
                          width: 250.w,
                          child: Text(
                            "Dr. Shruti Kedia",
                            overflow: TextOverflow.ellipsis,
                            style: AppTextStyles.text12WhiteRegular
                                .copyWith(color: AppColors.gray),
                          ),
                        )
                      ],
                    )
                  ],
                ))
          ],
        ),
      ),
    );
  }

  statusUpdate() {
    return SizedBox(
      child: ListView.builder(
          padding: EdgeInsets.zero,
          itemCount: globalSearchController.surgeries.length,
          shrinkWrap: true,
          itemBuilder: (context, index) {
            final surgery = globalSearchController.surgeries[index];
            final dateFormat = DateFormat('dd');
            final dateDay = DateFormat('EEE');
            final formattedDate =
                dateFormat.format(surgery.date!).toUpperCase();
            final formattedDay = dateDay.format(surgery.date!).toUpperCase();

            return GetBuilder(
                init: GlobalSearchController(),
                builder: (context) {
                  final timeAgo =
                      globalSearchController.getTimeAgo(surgery.date!);
                  return InkWell(
                    onTap: () {
                      Get.toNamed(AppRoutes.UPADTE_PAYMENT_STATUS);
                    },
                    child: RequestCardWidget(
                      // onTap: () {
                      //   Get.toNamed(AppRoutes.REQUEST_DETAIL);
                      // },
                      date: formattedDate.toString(),
                      // startTime: surgery.startTime,
                      dateDay: formattedDay,
                      // endTime: surgery.endTime,
                      //  timeAgo: timeAgo,
                      titile: surgery.category,
                      msg:
                          "Dr. Rahul needs approval for Tooth Extraction payment verification.",
                    ),
                  );
                });
          }),
    );
  }
}
