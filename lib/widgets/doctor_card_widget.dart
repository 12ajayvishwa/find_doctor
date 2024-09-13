import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../core/constants/app_export.dart';

class DoctorCardWidget extends StatelessWidget {
  final String? isVerified;
  final bool? isSeen;
  final String? experince;
  final String? gender;
  final String? imageUrl;
  final String? name;
  final String? designation;
  final String? percent;
  final String? patientStories;
  final void Function()? onTap;
  const DoctorCardWidget(
      {super.key,
      this.isVerified,
      this.isSeen,
      this.name,
      this.designation,
      this.percent,
      this.patientStories,
      this.imageUrl,
      this.experince,
      this.gender, this.onTap});

  @override
  Widget build(BuildContext context) {
    print(isVerified);
    return Container(
      margin: const EdgeInsets.only(top: 10),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10.r),
          boxShadow: [
            BoxShadow(
                color: AppColors.gray.withOpacity(0.1),
                spreadRadius: 1,
                blurRadius: 6)
          ]),
      child: Stack(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              InkWell(
                onTap: onTap,
                child: Padding(
                  padding: EdgeInsets.only(
                      top: 10.h, left: 10.w, right: 10.w, bottom: 30.h),
                  child: Container(
                    height: 120.h,
                    width: 140.w,
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
                    SizedBox(
                      width: 220.w,
                      child: Text(
                        name ?? "",
                        // overflow: TextOverflow.ellipsis,
                        maxLines: 2,
                        style: AppTextStyles.text18Black600
                            .copyWith(color: const Color(0XFF333333)),
                      ),
                    ),
                    SizedBox(
                      width: 220.w,
                      child: Text(
                        designation ?? "",
                        overflow: TextOverflow.ellipsis,
                        style: AppTextStyles.text14BlackMedium
                            .copyWith(color: AppColors.green600),
                      ),
                    ),
                    SizedBox(
                      height: 5.h,
                    ),
                    SizedBox(
                      width: 200.w,
                      child: Text(
                        experince ?? "",
                        overflow: TextOverflow.ellipsis,
                        style: AppTextStyles.text14BlackMedium
                            .copyWith(color: AppColors.gray),
                      ),
                    ),
                    SizedBox(
                      height: 4.h,
                    ),
                    percent != null || patientStories != null
                        ? Row(
                            children: [
                              rowBuild(percent ?? ""),
                              SizedBox(width: 10.w),
                              rowBuild(patientStories ?? ""),
                            ],
                          )
                        : Container(
                            height: 10.h,
                          ),
                    SizedBox(
                      height: 6.h,
                    ),
                    Row(
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
                          isVerified == "true" ? "Verified" : "Not Verified",
                          style: AppTextStyles.text12WhiteRegular
                              .copyWith(color: AppColors.gray),
                        )
                      ],
                    )
                  ],
                ),
              )
            ],
          ),
          isSeen != null
              ? Positioned(
                  bottom: 15.h,
                  right: 20.w,
                  child: SvgPicture.asset(
                    "assets/icons/seen_icon.svg",
                    color: isSeen == true ? Colors.blue : AppColors.gray,
                  ))
              : Container()
        ],
      ),
    );
  }

  Row rowBuild(value) {
    return Row(
      children: [
        Container(
          height: 10.h,
          width: 10.w,
          decoration:
              BoxDecoration(shape: BoxShape.circle, color: AppColors.green600),
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
