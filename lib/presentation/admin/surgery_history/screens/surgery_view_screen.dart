import 'package:find_doctor/core/constants/app_export.dart';
import 'package:find_doctor/core/constants/session_manager.dart';


import 'package:find_doctor/widgets/app_bar/custom_app_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SurgeryViewScreenAdmin extends StatefulWidget {
  const SurgeryViewScreenAdmin({super.key});

  @override
  State<SurgeryViewScreenAdmin> createState() => _SurgeryViewScreenAdminState();
}

class _SurgeryViewScreenAdminState extends State<SurgeryViewScreenAdmin> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: CustomAppBar(
          title: "Surgery Detail",
          isLeading: true,
          onPressed: () {
            Get.toNamed(AppRoutes.DASHBOARD, arguments: "0");
          },
        ),
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
          child: Container(
            decoration: BoxDecoration(
                color: AppColors.whiteA700,
                borderRadius: BorderRadius.circular(15.sp),
                boxShadow: [
                  BoxShadow(
                    offset: const Offset(0, 0),
                    blurRadius: 6,
                    spreadRadius: -1,
                    color: AppColors.kprimary.withOpacity(.2),
                  )
                ]),
            child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
                child: Column(children: [
                  SizedBox(
                    height: 5.h,
                  ),
                  Text("Neck Surgery", style: AppTextStyles.headline2),
                  SizedBox(
                    height: 10.h,
                  ),
                  Divider(
                    thickness: 1,
                    color: AppColors.kprimary.withOpacity(0.2),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        "Description : ",
                        style: AppTextStyles.bodyText
                            .copyWith(fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: 5.h,
                      ),
                       Text(
                          "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged.",
                          textAlign: TextAlign.start,
                          softWrap: true,
                          style: AppTextStyles.bodyText),
                    ],
                  ),
                  SizedBox(
                    height: 5.h,
                  ),
                  const Divider(
                    thickness: 1,
                  ),
                  SizedBox(
                    height: 5.h,
                  ),
                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: AppColors.kThirdPrimary),
                      borderRadius: BorderRadius.circular(8.sp),
                    ),
                    padding:
                        EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
                    child: Column(children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Patient Name: ",
                            style: AppTextStyles.bodyText
                                .copyWith(fontWeight: FontWeight.bold),
                          ),
                           Text("Anuj Bhagle",
                              style: AppTextStyles.bodyText),
                        ],
                      ),
                      SizedBox(
                        height: 15.h,
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Patient Age: ",
                            style: AppTextStyles.bodyText
                                .copyWith(fontWeight: FontWeight.bold),
                          ),
                           Text("28 year old",
                              style: AppTextStyles.bodyText),
                        ],
                      ),
                    ]),
                  ),
                  SizedBox(
                    height: 15.h,
                  ),
                  Container(
                    decoration: BoxDecoration(
                        border: Border.all(color: AppColors.kThirdPrimary),
                        borderRadius: BorderRadius.circular(8.sp)),
                    padding:
                        EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
                    child: Column(
                      children: [
                        nameField("Surgen Name: ", "Dr. Mukul Roy (Surgen)"),
                        SizedBox(
                          height: 15.h,
                        ),
                        nameField("Surgery Start Date : ", "12/12/2023"),
                        SizedBox(
                          height: 15.h,
                        ),
                        nameField("Surgery Start Time : ", "6:30 PM"),
                        SizedBox(
                          height: 15.h,
                        ),
                        nameField("Surgery End Date : ", "13/12/2023"),
                        SizedBox(
                          height: 15.h,
                        ),
                        nameField(
                          "Surgery End Time : ",
                          "9:30 PM",
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 15.h,
                  ),
                  Container(
                    decoration: BoxDecoration(
                        border: Border.all(color: AppColors.kThirdPrimary),
                        borderRadius: BorderRadius.circular(8.sp)),
                    padding:
                        EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
                    child: Column(
                      children: [
                        nameField(
                          "Hospital : ",
                          "Sagar MultiCity Hospital",
                        ),
                        SizedBox(
                          height: 15.h,
                        ),
                        Divider(
                          color: AppColors.kThirdPrimary,
                          thickness: 1,
                        ),
                        Container(
                          width: double.infinity,
                          alignment: Alignment.topCenter,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(
                                "Hospital Location : ",
                                style: AppTextStyles.bodyText
                                    .copyWith(fontWeight: FontWeight.bold),
                              ),
                               Text("Hosangabad road,near sanidev mandir",
                                  textAlign: TextAlign.start,
                                  softWrap: true,
                                  style: AppTextStyles.bodyText),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 40.h,
                  ),
                  SessionManager.getUserTypeId() != "3"
                      ? Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SizedBox(
                                height: 40.h,
                                width: 140.w,
                                child: CustomElevatedButton(
                                  text: "Accept",
                                  buttonStyle: ElevatedButton.styleFrom(
                                      elevation: 2,
                                      shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(20.sp),
                                      ),
                                      backgroundColor: AppColors.green600),
                                )),
                            SizedBox(
                                height: 40.h,
                                width: 140.w,
                                child: CustomElevatedButton(
                                  text: "Decline",
                                  buttonStyle: ElevatedButton.styleFrom(
                                      elevation: 2,
                                      shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(20.sp),
                                      ),
                                      backgroundColor: AppColors.red600D8),
                                ))
                          ],
                        )
                      : Container()
                ]),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Row nameField(title, value) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: AppTextStyles.bodyText.copyWith(fontWeight: FontWeight.bold),
        ),
        Text(value, style: AppTextStyles.bodyText),
      ],
    );
  }
}
