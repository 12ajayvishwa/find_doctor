import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/constants/app_export.dart';

class AcceptRequestWidget extends StatelessWidget {
  final String? imageUrl;
  final String? name;
  final String? designation;
  final String? experince;
  final String? percent;
  final String? patientStories;
  final String? revoked;
  final String? isVerified;
  final bool? isHideButton;
  final bool? isPrimary;
  final String? isAlternet;
  final String? available;
  final String? isApproved;
  final String? gender;
  final String? surgeryTime;
  final String? surgeryDate;

  final void Function()? onTapPrimary;
  final void Function()? onTapAlternate;
  final void Function()? onTapDecline;
  final void Function()? onTap;
  const AcceptRequestWidget(
      {super.key,
      this.imageUrl,
      this.name,
      this.designation,
      this.experince,
      this.percent,
      this.patientStories,
      this.revoked,
      this.isVerified,
      this.onTapPrimary,
      this.onTapAlternate,
      this.onTapDecline,
      this.available,
      this.isHideButton,
      this.isPrimary,
      this.gender,
      this.surgeryTime,
      this.surgeryDate,
      this.onTap,
      this.isAlternet,
      this.isApproved});

  @override
  Widget build(BuildContext context) {
    print("primary $isPrimary");

    return Container(
      margin: EdgeInsets.only(left: 10.w, right: 10.w, top: 10.h),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10.r),
          boxShadow: [
            BoxShadow(
                color: AppColors.gray.withOpacity(0.1),
                spreadRadius: 1,
                blurRadius: 6)
          ]),
      child: Stack(children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.only(
                  top: 10.h, left: 10.w, right: 10.w, bottom: 30.h),
              child: InkWell(
                onTap: onTap,
                child: Container(
                  height: 100.h,
                  width: 100.w,
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.white, width: 4),
                      borderRadius: BorderRadius.circular(10.r)),
                  child: ClipRRect(
                      borderRadius: BorderRadius.circular(10.r),
                      child: imageUrl == null
                          ? Image.asset(
                              gender != 'female'
                                  ? "assets/images/doctor_dummy.jpg"
                                  : "assets/images/2151107332.jpg",
                              height: 80.h,
                              width: 80.w,
                              fit: BoxFit.cover,
                            )
                          : Image.network(
                              imageUrl!,
                              height: 80.h,
                              width: 80.w,
                              fit: BoxFit.cover,
                            )),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name ?? "",
                    overflow: TextOverflow.ellipsis,
                    style: AppTextStyles.text18Black800,
                  ),
                  Text(
                    designation ?? "",
                    overflow: TextOverflow.ellipsis,
                    style: AppTextStyles.text14BlackMedium
                        .copyWith(color: AppColors.green600),
                  ),
                  SizedBox(
                    height: 5.h,
                  ),
                  Text(
                    experince ?? "",
                    overflow: TextOverflow.ellipsis,
                    style: AppTextStyles.text14BlackMedium
                        .copyWith(color: AppColors.gray),
                  ),
                  SizedBox(
                    height: 2.h,
                  ),
                  percent != null || patientStories != null || revoked != null
                      ? Row(
                          children: [
                            rowBuild(percent ?? ""),
                            SizedBox(width: 10.w),
                            rowBuild(revoked ?? "", color: AppColors.red600D8),
                            SizedBox(width: 10.w),
                            rowBuild(patientStories ?? ""),
                          ],
                        )
                      : Row(
                          children: [
                            SvgPicture.asset(
                              isVerified == "true"
                                  ? "assets/svg/verified.svg"
                                  : "assets/icons/not_verified.svg",
                            ),
                            SizedBox(
                              width: 10.w,
                            ),
                            Text(
                              isVerified == "true"
                                  ? "Verified"
                                  : "Not Verified",
                              style: AppTextStyles.text12WhiteRegular
                                  .copyWith(color: AppColors.gray),
                            )
                          ],
                        ),
                  SizedBox(
                    height: 60.h,
                  ),
                ],
              ),
            )
          ],
        ),
        Positioned(
            top: 5.h,
            right: 5.w,
            child: Text(
                isPrimary == true
                    ? "Primary"
                    : isAlternet == "alternate"
                        ? "Alternet"
                        : available ?? "",
                style: AppTextStyles.smallText
                    .copyWith(color: AppColors.kprimary))),
        isPrimary == true || isAlternet == "alternate"
            ? Positioned(
                bottom: 10.h,
                left: 10.w,
                right: 10.w,
                child: Row(
                  // crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(available ?? "",
                            style: AppTextStyles.smallText
                                .copyWith(color: AppColors.kprimary)),
                        Row(
                          children: [
                            Text(
                              surgeryTime ?? "",
                              style: AppTextStyles.smallText.copyWith(
                                  color: AppColors.gray,
                                  fontWeight: FontWeight.bold),
                            ),
                            SizedBox(
                              width: 8.w,
                            ),
                            Text(
                              "on $surgeryDate" ?? "",
                              style: AppTextStyles.smallText.copyWith(
                                color: AppColors.gray,
                              ),
                            )
                          ],
                        )
                      ],
                    ),
                    SizedBox(
                      width: 10.w,
                    ),
                    Container(
                      height: 40.h,
                      width: 200.w,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20.r),
                          border: Border.all(color: AppColors.kprimary)),
                      child: Center(
                          child: Text(
                        "Appointment Booked",
                        style: AppTextStyles.bodyText,
                      )),
                    )
                    //CustomElevatedButton(text: "Appointment Booked",width: 220.w,height: 50.h,isDisabled: ,)
                  ],
                ))
            : Positioned(
                bottom: 0,
                right: 10.w,
                left: isHideButton == true ? 150.w : 10.w,
                child: isApproved == "approved"
                    ? Container(
                        padding: EdgeInsets.symmetric(
                            horizontal: 10.w, vertical: 10.h),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20.r),
                            border: Border.all(color: AppColors.kprimary)),
                        child: Center(
                            child: Text(
                          "Request Approved",
                          style: AppTextStyles.text16BlackBold
                              .copyWith(color: AppColors.green600),
                        )),
                      )
                    : isApproved == "decline"
                        ? Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 10.w, vertical: 10.h),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20.r),
                                border: Border.all(color: AppColors.red600D8)),
                            child: Center(
                                child: Text(
                              "Request Decline",
                              style: AppTextStyles.text16BlackBold
                                  .copyWith(color: AppColors.red600D8),
                            )),
                          )
                        : Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                             
                                SizedBox(
                                    height: 45.h,
                                    width: 120.w,
                                    child: CustomElevatedButton(
                                        isDisabled: isPrimaryDisable,
                                        text: isHideButton == true
                                            ? "Approve"
                                            : "Primary",
                                        buttonStyle: ElevatedButton.styleFrom(
                                          backgroundColor: AppColors.kprimary,
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(6.r)),
                                        ),
                                        onTap: onTapPrimary)),
                              isHideButton == true
                                  ? Container()
                                  : SizedBox(
                                      height: 45.h,
                                      width: 130.w,
                                      child: CustomElevatedButton(
                                        text: "Alternate",
                                        buttonStyle: ElevatedButton.styleFrom(
                                          backgroundColor:
                                              const Color(0xFF00B2D9),
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(6.r)),
                                        ),
                                        onTap: onTapAlternate,
                                      )),
                              SizedBox(
                                  height: 45.h,
                                  width: 120.w,
                                  child: CustomElevatedButton(
                                    text: "Decline",
                                    buttonStyle: ElevatedButton.styleFrom(
                                      backgroundColor: const Color(0xFFBE0E0E),
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(6.r)),
                                    ),
                                    onTap: onTapDecline,
                                  ))
                            ],
                          ),
              )
      ]),
    );
  }

  Row rowBuild(value, {color}) {
    return Row(
      children: [
        Container(
          height: 10.h,
          width: 10.w,
          decoration: BoxDecoration(
              shape: BoxShape.circle, color: color ?? AppColors.green600),
        ),
        SizedBox(
          width: 5.w,
        ),
        Text(
          value,
          style: AppTextStyles.text10White400.copyWith(color: AppColors.gray),
        )
      ],
    );
  }
}
