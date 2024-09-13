import 'package:find_doctor/data/model/doctors_model.dart';
import 'package:find_doctor/data/model/send_request_appoinment_model.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/constants/api_network.dart';
import '../../../../core/constants/app_export.dart';
import '../../../../widgets/doctor_card_widget.dart';

class DoctorProfileScreen extends StatelessWidget {
  const DoctorProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    Doctor data = Get.arguments;

    // print(data.accountType);
    return Scaffold(
      body: SingleChildScrollView(
        child: SizedBox(
          height: size.height,
          width: double.infinity,
          child: Stack(
            children: [
              appBarContainer(
                size,
                title: "Doctor Profile",
                isLeading: true,
              ),
              Positioned(
                top: 100.h,
                left: 10.w,
                right: 10.w,
                child: DoctorCardWidget(
                  gender: data.gender ?? "male",
                  imageUrl: data.avatar == null
                      ? null
                      : ApiNetwork.imageUrl + data.avatar,
                  name: "Dr. ${data.name!.toString().capitalize ?? "N/A"}",
                  designation: data.specialization == null
                      ? "N/A"
                      : data.specialization!.name,
                  experince: data.experience != null
                      ? "${data.experience} years experience"
                      : "No experience",
                  isVerified: data.verified == 0 ? "false" : "true",
                ),
              ),
              Positioned(
                bottom: -40.h,
                right: -15.w,
                child: SvgPicture.asset("assets/svg/Rectangle 5904.svg"),
              ),
              Positioned(
                  top: 320.h,
                  left: 10.w,
                  right: 10.w,
                  bottom: 10.h,
                  child: detailsForm(data)),
            ],
          ),
        ),
      ),
    );
  }

  detailsForm(Doctor data) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16.r),
          boxShadow: [
            BoxShadow(
              color: AppColors.gray.withOpacity(0.2),
              spreadRadius: 1,
              blurRadius: 5,
            )
          ]),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 15.h),
        child: Column(children: [
          buildFieldWidget("Gender", data.gender ?? ""),
          buildFieldWidget("Specialization",
              data.specialization == null ? "N/A" : data.specialization!.name),
          buildFieldWidget("Phone number", "+91 ${data.phone ?? ""}"),
          buildFieldWidget("E-mail", data.email ?? ""),
          buildFieldWidget("Registration No.", data.registrationNo ?? ""),
        ]),
      ),
    );
  }

  buildFieldWidget(helper, value) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 10.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            helper,
            style: AppTextStyles.text14WhiteBold
                .copyWith(color: AppColors.gray, fontWeight: FontWeight.w500),
          ),
          SizedBox(
            height: 10.h,
          ),
          Padding(
            padding: EdgeInsets.only(left: 8.0.w),
            child: Text(
              value.toString().capitalize!,
              style: AppTextStyles.text16Black600,
            ),
          ),
          Divider(
            thickness: 1,
            color: AppColors.black900,
          )
        ],
      ),
    );
  }
}
