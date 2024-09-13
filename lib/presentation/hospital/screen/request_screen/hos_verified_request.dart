import 'package:find_doctor/data/model/send_request_model.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/constants/api_network.dart';
import '../../../../core/constants/app_export.dart';
import '../../../../data/model/send_request_appoinment_model.dart';
import '../../../../utils/custom_toast.dart';
import 'package:intl/intl.dart';

import '../../../../widgets/doctor_card_widget.dart';

class RequestVerificationDetailOfHosScreen extends StatefulWidget {
  const RequestVerificationDetailOfHosScreen({super.key});

  @override
  State<RequestVerificationDetailOfHosScreen> createState() =>
      _RequestVerificationDetailOfHosScreenState();
}

class _RequestVerificationDetailOfHosScreenState
    extends State<RequestVerificationDetailOfHosScreen> {
  @override
  void initState() {
    super.initState();
    toast.init(context);
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    SendRequestModel data = Get.arguments;
    return Scaffold(
      body: SizedBox(
        width: size.width,
        height: size.height,
        child: Column(children: [
          appBarContainer(size, title: "Request Details", isLeading: true),
          // Positioned(
          //   top: 120.h,
          //   left: 0.w,
          //   right: 0.w,
          //   child: Padding(
          //     padding: EdgeInsets.symmetric(horizontal: 10.w),
          //     child: DoctorCardWidget(
          //       onTap: () {
          //         Get.toNamed(AppRoutes.DOCTOR_PROFILE,arguments:data.doctor);
          //       },
          //       gender: data.doctor!.gender ?? "male",
          //       imageUrl: data.doctor!.avatar == null
          //           ? null
          //           : ApiNetwork.imageUrl + data.doctor!.avatar,
          //       name:
          //           "Dr. ${data.doctor!.name!.toString().capitalize ?? "N/A"}",
          //       designation: data.doctor!.specialization == null
          //           ? "N/A"
          //           : data.doctor!.specialization!.name,
          //       experince: data.doctor!.experience != null
          //           ? "${data.doctor!.experience} years experience"
          //           : "No experience",
          //       isVerified: data.doctor!.verified == 0 ? "false" : "true",
          //     ),
          //   ),
          // ),
          surgeryDetailCard(data)
        ]),
      ),
    );
  }

  surgeryDetailCard(SendRequestModel data) {
    DateTime surgeryDate =
        DateFormat("yyyy-MM-ddTHH:mm:ss.SSSZ").parse(data.surgeryDate!);
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
            fieldsData("Task no.", data.id.toString()),
            fieldsData("Task name", data.title),
            fieldsData("Payable amount", data.amount.toString()),
            fieldsData("Transaction", "Cash"),
            fieldsData("Status", data.status),
            fieldsData("Message", data.description, 3),
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
          enabled: false,
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
