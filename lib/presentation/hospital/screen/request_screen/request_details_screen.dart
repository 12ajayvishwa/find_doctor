import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/constants/app_export.dart';
import '../../../../data/model/send_request_model.dart';

import 'package:intl/intl.dart';

import '../../widget/appointment_accepted_widget.dart';
import '../../widget/appointment_sended_widget.dart';

class RequestDetailScreen extends StatefulWidget {
  const RequestDetailScreen({super.key});

  @override
  State<RequestDetailScreen> createState() => _RequestDetailScreenState();
}

class _RequestDetailScreenState extends State<RequestDetailScreen>
    with SingleTickerProviderStateMixin {
  RequestController requestController = Get.put(RequestController());

  static List<Tab> tabs = <Tab>[
    const Tab(
      text: "Request Send",
    ),
    const Tab(
      text: 'Requests Accepted',
    ),
  ];
  late TabController _tabController;
  SendRequestModel data = Get.arguments[0];
  var tabIndex = Get.arguments[1];
  @override
  void initState() {
    super.initState();
    _tabController =
        TabController(vsync: this, length: tabs.length, initialIndex: tabIndex);
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
        body: SizedBox(
      height: double.infinity,
      width: double.infinity,
      child: Stack(children: [
        appBarContainer(size,
            title: "Request Details",
            isTabBar: true,
            isLeading: true,
            leading: IconButton(
                onPressed: () {
                  Get.offAllNamed(AppRoutes.DASHBOARD, arguments: [2,0]);
                },
                icon: Icon(
                  Icons.arrow_back,
                  color: AppColors.black900,
                )),
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
                tabs: tabs)),
        Positioned(
          bottom: -40.h,
          right: -15.w,
          child: SvgPicture.asset("assets/svg/Rectangle 5904.svg"),
        ),
        Positioned(
            top: 160.h,
            left: 0.w,
            right: 0.w,
            bottom: 10.h,
            child: TabBarView(
                physics: const NeverScrollableScrollPhysics(),
                controller: _tabController,
                children: [
                  AppointmentSendedWidget(
                    data: data,
                  ),
                  AppointmentAcceptedWidget(
                    data: data,
                  )
                ]))
      ]),
    ));
  }
}
