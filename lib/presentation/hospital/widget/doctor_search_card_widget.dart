import 'package:find_doctor/core/constants/app_export.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DoctorSearchCardWidget extends StatelessWidget {
  final String? imageUrl;
  final String name;
  final String speciality;
  final String gender;
  final void Function() onTap;
  const DoctorSearchCardWidget(
      {super.key,
      this.imageUrl,
      required this.name,
      required this.speciality,
      required this.onTap,
      required this.gender});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
      child: InkWell(
        onTap: onTap,
        child: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8.r),
              color: AppColors.whiteA700,
              boxShadow: [
                BoxShadow(
                  color: AppColors.gray.withOpacity(0.2),
                  spreadRadius: 1,
                  blurRadius: 7,
                )
              ]),
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: 100.h,
                  width: 100.w,
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.white, width: 4),
                      borderRadius: BorderRadius.circular(10.r)),
                  child: ClipRRect(
                      borderRadius: BorderRadius.circular(10.r),
                      child: imageUrl == null
                          ? Image.asset(
                              gender != "female"
                                  ? "assets/images/doctor_dummy.jpg"
                                  : "assets/images/2151107332.jpg",
                              height: 80.h,
                              width: 80.w,
                              fit: BoxFit.fill,
                            )
                          : Image.network(
                              imageUrl!,
                              height: 80.h,
                              width: 80.w,
                              fit: BoxFit.fill,
                            )),
                ),
                SizedBox(
                  width: 20.w,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: 240.w,
                      child: Text(
                        name.capitalize ?? "",
                        overflow: TextOverflow.ellipsis,
                        style: AppTextStyles.headline,
                      ),
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    Text(
                      speciality ?? "",
                      style: AppTextStyles.text14BlackMedium,
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
