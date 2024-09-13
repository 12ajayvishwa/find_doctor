import 'package:find_doctor/theme/color_constants.dart';
import 'package:find_doctor/widgets/custom_elevated_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

class CreateRequestWidget extends StatelessWidget {
  Function()? onTap;

   CreateRequestWidget({super.key,this.onTap});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            height: 240.h,
            width: 240.w,
            decoration: BoxDecoration(
                shape: BoxShape.circle, color: AppColors.kprimary),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: SvgPicture.asset(
                "assets/images/add_request.svg",
              ),
            ),
          ),
          SizedBox(height: 40.h,),
          Padding(
            padding:  EdgeInsets.symmetric(horizontal: 70.w),
            child: CustomElevatedButton(text: "Add Request",onTap: onTap),
          )
        ],
      ),
    );
  }
}
