import 'package:find_doctor/core/constants/app_export.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AllReocrdsScreen extends StatefulWidget {
  const AllReocrdsScreen({super.key});

  @override
  State<AllReocrdsScreen> createState() => _AllReocrdsScreenState();
}

class _AllReocrdsScreenState extends State<AllReocrdsScreen> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: Stack(
          children: [
            appBarContainer(size, title: "All Records"),
            Positioned(
              top: 80.h,
              left: 0,
              right: 0,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 35.w, vertical: 40.h),
                child: GridView.builder(
                  shrinkWrap: true,
                  itemCount: recordList.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisExtent: 160.h,
                    childAspectRatio: 1.5,
                    crossAxisSpacing: 15.w,
                    mainAxisSpacing: 15.h,
                  ),
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: () {
                        Navigator.pushNamed(
                            context, recordList[index]["route"]);
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20.r),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.1),
                              spreadRadius: 1,
                              blurRadius: 4,
                              offset: const Offset(0, 1),
                            ),
                          ],
                          color: Colors.white,
                        ),
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 0.w),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                height: 76.h,
                                width: 76.w,
                                decoration: const BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Color(0xffC6EFE5),
                                ),
                                child: Center(
                                  child: CustomImageView(
                                    svgPath: recordList[index]["icon"],
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 10.h,
                              ),
                              Text(
                                recordList[index]["title"],
                                textAlign: TextAlign.center,
                                style: AppTextStyles.text12WhiteRegular
                                    .copyWith(
                                        fontWeight: FontWeight.w700,
                                        color: AppColors.blackLight),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  List recordList = [
    {
      "title": "Request verified",
      "icon": "assets/icons/request_verify.svg",
      "route": SessionManager.getUserTypeId() == "2"
          ? AppRoutes.REQUEST_VERIFIED_HOS
          : AppRoutes.REQUEST_VERIFIED_DOC
    },
    {
      "title": SessionManager.getUserTypeId() == "2"
          ? "Request Raised Graph"
          : "Successfully completed surgeries",
      "icon": "assets/icons/completed _surgeries.svg",
      "route": AppRoutes.SUCCESFULLYSURGERIESCOMPLETE
    },
    {
      "title": SessionManager.getUserTypeId() == "2"
          ? "Verify Request"
          : "Request verification status",
      "icon": "assets/icons/request_verification_status.svg",
      "route": SessionManager.getUserTypeId() == "2"
          ? AppRoutes.REQUEST_VERIFY
          : AppRoutes.REQUEST_VERIFICATION_STATUS
    },
    {
      "title": "Payment process",
      "icon": "assets/icons/payment_process.svg",
      "route": SessionManager.getUserTypeId() == "2"
          ? AppRoutes.HOSPITAL_PAYMENT
          : AppRoutes.PAYMENT_PROCESS_SCREEN
    },
    {
      "title": SessionManager.getUserTypeId() == "2"
          ? "All Appointments"
          : "All Requests",
      "icon": "assets/icons/all_request.svg",
      "route": SessionManager.getUserTypeId() == "2"
          ? AppRoutes.ALL_APPOINTMENT
          : AppRoutes.ALL_REQUEST
    },
  ];
}
