
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

import '../../../core/constants/app_export.dart';
import '../../../data/model/send_request_model.dart';

class SurgeryDetailsCard extends StatelessWidget {
  final dynamic isAccept;
  final SendRequestModel? data;
  const SurgeryDetailsCard({super.key, this.isAccept, this.data});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    DateTime surgeryDate =
        DateFormat("yyyy-MM-ddTHH:mm:ss.SSSZ").parse(data!.surgeryDate!);
    final dateFormat = DateFormat('dd');
    final dateDay = DateFormat('EEE');
    final formattedDate = dateFormat.format(surgeryDate).toUpperCase();
    final formattedDay = dateDay.format(surgeryDate).toUpperCase();
    DateTime startTime1 = DateFormat("HH:mm").parse(data!.startTime!);
    DateTime endTime1 = DateFormat("HH:mm").parse(data!.endTime!);
    String startTime = DateFormat("h:mm a").format(startTime1);
    String endTime = DateFormat("h:mm a").format(endTime1);
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
      child: Container(
        height: size.height * 0.17,
        width: double.infinity,
        decoration: BoxDecoration(
            color: AppColors.whiteA700,
            borderRadius: BorderRadius.circular(15.r),
            boxShadow: [
              BoxShadow(
                  color: AppColors.gray.withOpacity(0.2),
                  spreadRadius: 1,
                  blurRadius: 7)
            ]),
        child: Stack(
          children: [
            Positioned(
              bottom: 15.h,
              left: 15.w,
              child: Container(
                decoration: BoxDecoration(
                    color: AppColors.kprimary.withOpacity(0.08),
                    borderRadius: BorderRadius.circular(2.r)),
                child: Padding(
                  padding: const EdgeInsets.all(6.0),
                  child: Text(
                    "$startTime - $endTime",
                    style: AppTextStyles.text12WhiteRegular.copyWith(
                        fontWeight: FontWeight.w500, color: AppColors.kprimary),
                  ),
                ),
              ),
            ),
            Positioned(
                top: 15.h,
                left: 15.w,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: EdgeInsets.symmetric(
                          horizontal: 20.w, vertical: 20.h),
                      decoration: BoxDecoration(
                        color: AppColors.kprimary,
                        borderRadius: BorderRadius.circular(15.r),
                      ),
                      child: Column(
                        children: [
                          Text(formattedDate,
                              textAlign: TextAlign.center,
                              style: AppTextStyles.text14White400),
                          Text(formattedDay,
                              textAlign: TextAlign.center,
                              style: AppTextStyles.text14White400),
                        ],
                      ),
                    ),
                    SizedBox(
                      width: 10.w,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(
                          width: 250.w,
                          child: Text(
                            data!.title.toString().capitalizeFirst!,
                            overflow: TextOverflow.ellipsis,
                            style: AppTextStyles.headline,
                          ),
                        ),
                        SizedBox(
                          height: 5.h,
                        ),
                        SizedBox(
                          width: 250.w,
                          child: Text(
                           " f${data!.hospital!.name!}" ?? "",
                            overflow: TextOverflow.ellipsis,
                            style: AppTextStyles.text12WhiteRegular
                                .copyWith(color: AppColors.kprimary),
                          ),
                        ),
                        SizedBox(
                          height: 5.h,
                        ),
                        // SizedBox(
                        //   width: 250.w,
                        //   child: Text(
                        //     isAccept == true
                        //         ? "${data.noOfDoctors} Doctors Available"
                        //         : "${data.noOfDoctors} Request sended",
                        //     overflow: TextOverflow.ellipsis,
                        //     style: AppTextStyles.text12WhiteRegular
                        //         .copyWith(color: AppColors.gray),
                        //   ),
                        // ),
                        // isAccept == false
                        //     ? Container()
                        //     : SizedBox(
                        //         width: 250.w,
                        //         child: Text(
                        //           "${data.noOfDoctors}  Doctor Required",
                        //           overflow: TextOverflow.ellipsis,
                        //           style: AppTextStyles.text12WhiteRegular
                        //               .copyWith(color: AppColors.gray),
                        //         ),
                        //       )
                      ],
                    )
                  ],
                ))
          ],
        ),
      ),
    );
  }
}
