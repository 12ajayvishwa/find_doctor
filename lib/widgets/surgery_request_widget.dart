import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../core/constants/app_export.dart';

class headerOfHospital extends StatelessWidget {
  final String? title;
  final void Function()? onTap;
  final Widget? cardBanner;
  final Widget? hospitalCard;
  final String? cardImage;
  headerOfHospital({
    super.key,
    this.title,
    this.onTap,
    this.cardBanner,
    this.hospitalCard,
    this.cardImage,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 388.h,
      width: double.infinity,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Container(
            width: 594.w,
            height: 604.h,
            decoration: ShapeDecoration(
              gradient: const LinearGradient(
                begin: Alignment(0.00, -1.00),
                end: Alignment(0, 1),
                colors: [Color(0xFF0CC58B), Color(0x000CC58B)],
              ),
              shape: RoundedRectangleBorder(
                borderRadius:
                    BorderRadius.only(bottomRight: Radius.circular(165.r)),
              ),
            ),
          ),
          Positioned(
              top: 0.h,
              left: -50.w,
              child: SvgPicture.asset(
                "assets/icons/elips_circle.svg",
                height: 294.h,
              )),
          Positioned(
              top: 0.h,
              right: 0.w,
              child: Image.asset(
                "assets/images/bload cell.png",
              )),
          Positioned(
              right: 40.w,
              top: 120.h,
              bottom: 140.h,
              left: 40.w,
              child: cardBanner ?? Container()),
          Positioned(
              top: 90.h,
              right: 50.w,
              child: Image.asset(
                cardImage ?? "assets/svg/appointment_doc.svg",
                height: 160.h,
              )),
          Positioned(
              top: 30.h,
              left: 10.w,
              right: 15.w,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                      onPressed: onTap,
                      icon: Icon(
                        Icons.arrow_back,
                        size: 24.sp,
                        color: AppColors.black900,
                      )),
                  Text(
                    title ?? "",
                    style: AppTextStyles.text16Black600
                        .copyWith(fontWeight: FontWeight.w700),
                  ),
                  SizedBox(
                    height: 18.h,
                    width: 18.w,
                  )
                ],
              )),
          Positioned(
              bottom: 7.h, left: 15.w, child: hospitalCard ?? Container())
        ],
      ),
    );
  }
}
