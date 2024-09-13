import 'package:find_doctor/theme/color_constants.dart';
import 'package:find_doctor/theme/text_style.dart';
import 'package:find_doctor/widgets/custom_image_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomRequestWidget extends StatelessWidget {
  const CustomRequestWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 14.h),
      decoration: BoxDecoration(
          color: AppColors.whiteA700,
          borderRadius: BorderRadius.circular(8),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              spreadRadius: 1,
              blurRadius: 1,
              offset: const Offset(0, 1), // changes position of shadow
            ),
          ]),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomImageView(
                imagePath: "assets/images/image (1).png",
                height: 90.h,
                width: 90.w,
              ),
              SizedBox(
                height: 5.h,
              ),
              Text(
                " Available ",
                style: AppTextStyles.text14WhiteBold.copyWith(
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w500,
                    color: AppColors.kprimary),
              ),
              Text.rich(TextSpan(children: [
                TextSpan(
                    text: "12:00",
                    style: AppTextStyles.text14WhiteBold.copyWith(
                        fontSize: 11.sp,
                        fontWeight: FontWeight.w500,
                        color: const Color(0xff677294))),
                TextSpan(
                    text: " AM tomorrow",
                    style: AppTextStyles.text14WhiteBold.copyWith(
                        fontSize: 11.sp,
                        fontWeight: FontWeight.w300,
                        color: const Color(0xff677294))),
              ])),
            ],
          ),
          SizedBox(
            width: 10.w,
          ),
          Expanded(
              child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Dr. Shruti Kedia",
                style: AppTextStyles.text18Black800.copyWith(
                    color: const Color(0xff333333),
                    fontWeight: FontWeight.w500),
              ),
              Text(
                "Dentist",
                style: AppTextStyles.text18Black800.copyWith(
                    fontSize: 13.sp,
                    color: AppColors.kprimary,
                    fontWeight: FontWeight.w400),
              ),
              Text(
                "7 Years experience ",
                style: AppTextStyles.text18Black800.copyWith(
                    fontSize: 12.sp,
                    color: const Color(0xff677294),
                    fontWeight: FontWeight.w300),
              ),
              Row(
                children: [
                  _buildLabel(_buildPrimaryDot(), "87%"),
                  SizedBox(
                    width: 20.w,
                  ),
                  _buildLabel(_buildPrimaryDot(), "69 Patient Stories"),
                ],
              ),
              _buildLabel(
                CustomImageView(
                  svgPath: "assets/icons/verify.svg",
                ),
                "Verify",
              ),
              SizedBox(
                height: 10.h,
              ),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  _buildAcceptDeclineTap(() {}, "Accept", AppColors.kprimary),
                  SizedBox(
                    width: 10.h,
                  ),
                  _buildAcceptDeclineTap(() {}, "Decline", AppColors.red600D8),
                ],
              )
            ],
          ))
        ],
      ),
    );
  }

  InkWell _buildAcceptDeclineTap(
      Function()? onTap, String title, Color bgColor) {
    return InkWell(
      onTap: onTap!,
      child: Container(
        height: 30.h,
        width: 70.h,
        decoration: BoxDecoration(
          color: bgColor,
          borderRadius: BorderRadius.circular(4.r),
        ),
        child: Center(
            child: Text(
          title,
          style: AppTextStyles.text14WhiteBold.copyWith(
              fontSize: 10.sp,
              fontWeight: FontWeight.w500,
              color: AppColors.whiteA700),
        )),
      ),
    );
  }

  Row _buildLabel(
    Widget icon,
    String label,
  ) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        icon,
        SizedBox(
          width: 5.w,
        ),
        Text(
          label,
          style: AppTextStyles.text18Black800.copyWith(
              fontSize: 11.sp,
              color: const Color(0xff677294),
              fontWeight: FontWeight.w300),
        ),
      ],
    );
  }

  Container _buildPrimaryDot() {
    return Container(
      height: 10.h,
      width: 10.h,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: AppColors.kprimary,
      ),
    );
  }
}
