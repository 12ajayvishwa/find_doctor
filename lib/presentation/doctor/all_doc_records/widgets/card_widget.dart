import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../theme/text_style.dart';

class CardWidget extends StatelessWidget {
  final String date;
  final String title;
  final String startTime;
  final String endTime;
  final String status;
  final String? day;
  final void Function()? onTap;

  const CardWidget(
      {super.key,
      required this.date,
      required this.title,
      required this.startTime,
      required this.endTime,
      required this.status,
       this.onTap,
      this.day});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
        padding: EdgeInsets.symmetric(horizontal: 22.w, vertical: 14.h),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: const Color(0xFF1E6E7E),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 92.h,
              width: 96.w,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15.r),
                color: const Color(0xffFFFFFF),
              ),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      date,
                      style: AppTextStyles.text18Black800,
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 10.h),
                    Text(
                      day ?? "",
                      style: AppTextStyles.text18Black800,
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              width: 20.w,
            ),
            Expanded(
                child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  "$startTime - $endTime ",
                  style: AppTextStyles.text10White400,
                ),
                Text(
                  title,
                  style: AppTextStyles.text15White500,
                ),
                SizedBox(
                  height: 15.h,
                ),
                Container(
                  padding:
                      EdgeInsets.symmetric(horizontal: 20.w, vertical: 8.h),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(22.r),
                    color: status == "pending"
                        ? Colors.orange
                        : status == "accepted"
                            ? Colors.lightBlue
                            : status == "Rejected"
                                ? Colors.red
                                :status == "approved" ?Colors.green:Colors.blue,
                  ),
                  child: Text(
                    status == "accepted"
                        ? "Accepted"
                        : status == "pending"
                            ? "Pending"
                            : status == "Rejected"
                                ? "Rejected"
                                : status == "approved"?"Verfied":"Completed",
                    style: AppTextStyles.text12WhiteRegular
                        .copyWith(fontWeight: FontWeight.w500),
                  ),
                )
              ],
            )),
            // InkWell(
            //   onTap: onTap,
            //   child: Icon(
            //     Icons.more_horiz,
            //     color: Colors.white,
            //     size: 25.h,
            //   ),
            // )
          ],
        ),
      ),
    );
  }
}
