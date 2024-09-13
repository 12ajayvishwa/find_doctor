import 'package:find_doctor/utils/custom_toast.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/constants/app_export.dart';
import '../../models/appointments_request_model.dart';
import 'package:intl/intl.dart';

class RequestVerificationDetailOfDocScreen extends StatefulWidget {
  const RequestVerificationDetailOfDocScreen({super.key});

  @override
  State<RequestVerificationDetailOfDocScreen> createState() =>
      _RequestVerificationDetailOfDocScreenState();
}

class _RequestVerificationDetailOfDocScreenState
    extends State<RequestVerificationDetailOfDocScreen> {
  @override
  void initState() {
    toast.init(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    AppointmentRequestModel data = Get.arguments;
    return Scaffold(
      body: Column(children: [
        appBarContainer(size, title: "Request Detail", isLeading: true),
        // Padding(
        //   padding: EdgeInsets.symmetric(horizontal: 10.w),
        //   child: Container(
        //     padding: EdgeInsets.symmetric(vertical: 10.h),
        //     decoration: BoxDecoration(
        //         color: Colors.white,
        //         borderRadius: BorderRadius.circular(15.r),
        //         boxShadow: [
        //           BoxShadow(
        //               color: Colors.grey.withOpacity(0.2),
        //               spreadRadius: 1,
        //               blurRadius: 7,
        //               offset: const Offset(6, 6))
        //         ]),
        //     child: Padding(
        //       padding: EdgeInsets.only(left: 20.w),
        //       child: Row(
        //         children: [
        //           Container(
        //             width: 100.w,
        //             height: 100.h,
        //             decoration: BoxDecoration(
        //                 borderRadius: BorderRadius.circular(8.r),
        //                 color: AppColors.gray.withOpacity(0.5)),
        //             child: Image.asset("assets/images/doctor_main.png"),
        //           ),
        //           Padding(
        //             padding: EdgeInsets.only(left: 10.w),
        //             child: Column(
        //               crossAxisAlignment: CrossAxisAlignment.start,
        //               children: [
        //                 Text(
        //                   "Dr. ${data.doctor!.name}",
        //                   style: AppTextStyles.headline,
        //                 ),
        //                 Text(
        //                   "${data.doctor!.specialization!.name}",
        //                   style: AppTextStyles.text12WhiteRegular.copyWith(
        //                       color: AppColors.kprimary, fontSize: 13.sp),
        //                 ),
        //                 Text(
        //                   data.doctor!.experience == null
        //                       ? "No experience"
        //                       : "${data.doctor!.experience} Years experience",
        //                   style: AppTextStyles.text12WhiteRegular
        //                       .copyWith(color: AppColors.gray),
        //                 ),
        //                 SizedBox(
        //                   height: 5.h,
        //                 ),
        //                 // Row(
        //                 //   children: [
        //                 //     operationDone(AppColors.kprimary, "87 %"),
        //                 //     SizedBox(
        //                 //       width: 4.w,
        //                 //     ),
        //                 //     operationDone(AppColors.red600D8, "01 Revoked"),
        //                 //     SizedBox(
        //                 //       width: 4.w,
        //                 //     ),
        //                 //     operationDone(
        //                 //         AppColors.kprimary, "69 Patient Stories"),
        //                 //   ],
        //                 // ),
        //                 SizedBox(
        //                   height: 5.h,
        //                 ),
        //                 Row(
        //                   children: [
        //                     SvgPicture.asset(
        //                       data.doctor!.verified != 0
        //                           ? "assets/svg/verified.svg"
        //                           : "assets/icons/not_verified.svg",
        //                     ),
        //                     SizedBox(
        //                       width: 10.w,
        //                     ),
        //                     Text(
        //                       data.doctor!.verified != 0
        //                           ? "Verified"
        //                           : "Not Verified",
        //                       style: AppTextStyles.text12WhiteRegular
        //                           .copyWith(color: AppColors.gray),
        //                     )
        //                   ],
        //                 ),
        //               ],
        //             ),
        //           )
        //         ],
        //       ),
        //     ),
        //   ),
        // ),
        SizedBox(
          height: 20.h,
        ),
        surgeryDetailCard(data)
      ]),
    );
  }

  surgeryDetailCard(AppointmentRequestModel data) {
    DateTime surgeryDate = DateFormat("yyyy-MM-ddTHH:mm:ss.SSSZ")
        .parse(data.request!.surgeryDate!);
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10.w),
      child: Card(
        surfaceTintColor: Colors.white,
        elevation: 8,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
          child: Column(children: [
            fieldsData(
                "Request date", DateFormat('dd/MM/yyyy').format(surgeryDate)),
            fieldsData("Task no.", data.request!.id.toString()),
            fieldsData("Task name", data.request!.title),
            fieldsData("Payable amount", data.request!.amount.toString()),
            fieldsData("Transaction", "Cash"),
            fieldsData("Status", data.status),
            fieldsData("Message", data.request!.description, 3),
          ]),
        ),
      ),
    );
  }

  fieldsData(title, value, [maxlines]) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: AppTextStyles.text12WhiteRegular
              .copyWith(color: AppColors.darkGrey, fontWeight: FontWeight.bold),
        ),
        TextFormField(
          readOnly: true,
          initialValue: value,
          style: AppTextStyles.headline,
          maxLines: maxlines,
          decoration: const InputDecoration(
            enabled: true,
          ),
        )
      ],
    );
  }

  operationDone(color, text) {
    return Row(
      children: [
        Container(
          height: 12.h,
          width: 12.w,
          decoration: BoxDecoration(color: color, shape: BoxShape.circle),
        ),
        SizedBox(
          width: 2.w,
        ),
        Text(
          text,
          style:
              AppTextStyles.text12WhiteRegular.copyWith(color: AppColors.gray),
        )
      ],
    );
  }
}
