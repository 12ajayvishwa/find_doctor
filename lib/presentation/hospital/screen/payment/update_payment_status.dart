import 'package:find_doctor/presentation/doctor/all_doc_records/screens/doc_payment_process_screen.dart';
import 'package:find_doctor/widgets/success_dialog.dart';
import 'package:find_doctor/presentation/hospital/controller/payment_process_controller.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/constants/app_export.dart';
import '../../../../widgets/doctor_card_widget.dart';
import '../../../../widgets/log_out_popup_dialog.dart';

class UpdatePaymentStatus extends StatelessWidget {
  UpdatePaymentStatus({super.key});

  PaymentProcessController paymentProcessController =
      Get.put(PaymentProcessController());

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: SizedBox(
        height: size.height,
        width: double.infinity,
        child: Stack(
          children: [
            appBarContainer(
              size,
              title: "Update Status",
              isLeading: true,
            ),
            Positioned(
              bottom: -40.h,
              right: -15.w,
              child: SvgPicture.asset("assets/svg/Rectangle 5904.svg"),
            ),
            Positioned(
              top: 120.h,
              left: 10.w,
              right: 10.w,
              child: const DoctorCardWidget(
                imageUrl: null,
                name: "Dr. Shruti Kedia",
                designation: "Dentist",
                experince: "7 Years experience",
                patientStories: "78 Patient Stories",
                percent: "85%",
                isVerified: "true",
              ),
            ),
            statusDetailsWidget(context, size),
          ],
        ),
      ),
    );
  }

  statusDetailsWidget(context, size) {
    return Positioned(
      top: 320.h,
      left: 10.w,
      right: 10.w,
      bottom: 10.h,
      child: Container(
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
        child: SizedBox(
          height: size.height,
          width: double.infinity,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 15.h),
            child: Stack(
              children: [
                Positioned(
                    top: 20.h,
                    right: 10.w,
                    left: 10.w,
                    bottom: 0.h,
                    child: formCard(context)),
                Positioned(
                    right: 0,
                    top: 0,
                    child: InkWell(
                      onTap: () {
                        paymentProcessController.formEdit();
                      },
                      child: Container(
                          height: 40.h,
                          width: 40.w,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(6.r),
                            color: AppColors.blackLight,
                          ),
                          child: Icon(
                            Icons.edit_outlined,
                            color: AppColors.whiteA700,
                          )),
                    )),
              ],
            ),
          ),
        ),
      ),
    );
  }

  formCard(context) {
    print(paymentProcessController.isEditable);

    return GetBuilder(
        init: paymentProcessController,
        builder: (context) {
          return ListView(
           // padding: EdgeInsets.all(0),
            children: [
              paymentProcessController.isEditable == true
                  ? CustomTextFormField(
                      labelText: "Request date",
                      hintText: "Request date",
                      // controller: hospitalController.description,
                      textInputType: TextInputType.text,
                      fillColor: AppColors.whiteA700,
                      borderDecoration: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16.r),
                          borderSide:
                              BorderSide(color: AppColors.kprimary, width: 1)),

                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Please enter Transaction";
                        }
                      },
                    )
                  : buildFieldWidget("Request date", "07/08/24"),
              paymentProcessController.isEditable == true
                  ? CustomTextFormField(
                      labelText: "Task no.",
                      hintText: "Task no.",
                      // controller: hospitalController.description,
                      textInputType: TextInputType.text,
                      fillColor: AppColors.whiteA700,
                      borderDecoration: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16.r),
                          borderSide:
                              BorderSide(color: AppColors.kprimary, width: 1)),

                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Please enter Transaction";
                        }
                      },
                    )
                  : buildFieldWidget("Task no.", "335"),
              paymentProcessController.isEditable == true
                  ? CustomTextFormField(
                      labelText: "Task name",
                      hintText: "Task name",
                      // controller: hospitalController.description,
                      textInputType: TextInputType.text,
                      fillColor: AppColors.whiteA700,
                      borderDecoration: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16.r),
                          borderSide:
                              BorderSide(color: AppColors.kprimary, width: 1)),

                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Please enter Transaction";
                        }
                      },
                    )
                  : buildFieldWidget("Task name", "Neck surgery"),
              paymentProcessController.isEditable == true
                  ? CustomTextFormField(
                      labelText: "Payable Amount",
                      hintText: "Payable Amount",
                      // controller: hospitalController.description,
                      textInputType: TextInputType.text,
                      fillColor: AppColors.whiteA700,
                      borderDecoration: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16.r),
                          borderSide:
                              BorderSide(color: AppColors.kprimary, width: 1)),

                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Please enter Transaction";
                        }
                      },
                    )
                  : buildFieldWidget("Payable Amount", "35,000"),
              SizedBox(
                height: 10.h,
              ),
              CustomTextFormField(
                labelText: "Transaction",
                hintText: "Transaction",
                // controller: hospitalController.description,
                textInputType: TextInputType.text,
                fillColor: AppColors.whiteA700,
                borderDecoration: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16.r),
                    borderSide:
                        BorderSide(color: AppColors.kprimary, width: 1)),

                validator: (value) {
                  if (value!.isEmpty) {
                    return "Please enter Transaction";
                  }
                },
              ),
              SizedBox(
                height: 10.h,
              ),
              CustomTextFormField(
                labelText: "Status",
                hintText: "Status",
                // controller: hospitalController.description,
                fillColor: AppColors.whiteA700,
                textInputType: TextInputType.text,
                borderDecoration: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16.r),
                    borderSide:
                        BorderSide(color: AppColors.kprimary, width: 1)),

                validator: (value) {
                  if (value!.isEmpty) {
                    return "Please enter Transaction";
                  }
                },
              ),
              SizedBox(
                height: 10.h,
              ),
              CustomTextFormField(
                labelText: "Message",
                hintText: "Write your message..",

                // controller: hospitalController.description,
                textInputType: TextInputType.text,

                maxLines: 3,
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Please enter description";
                  }
                },
              ),
              SizedBox(
                height: 20.h,
              ),
              CustomElevatedButton(
                text: "Update status",
                onTap: () {
                  showDialog(
                    context: Get.context!,
                    builder: (context) {
                      return paymentProcessController.isEditable == true
                          ? SuccessPopUpDialog(
                              title: "Request send successfully",
                              message:
                                  "The request has now been sent to the administrator. You’ll be notified if the admin gets approved.",
                              onTap: () {
                                Get.back();
                              })
                          : LogOutPopUpDialog(
                              onPressed: () {},
                              title: "Edit Detail",
                              msg:
                                  "Your status will be updated after admins get approved.",
                              color: AppColors.red600D8,
                            );
                    },
                  );
                },
              )
            ],
          );
        });
  }

  buildFieldWidget(helper, value) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 10.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            helper,
            style:
                AppTextStyles.text14WhiteBold.copyWith(color: AppColors.gray),
          ),
          SizedBox(
            height: 15.h,
          ),
          Padding(
            padding: EdgeInsets.only(left: 8.0.w),
            child: Text(
              value,
              style: AppTextStyles.text18Black800,
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
