import 'package:find_doctor/utils/validation_functions.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/constants/app_export.dart';
import '../../../../widgets/image_picker.dart';
import '../../../auth/signup_screen.dart';

enum Verify { yes, no }

class AddDoctorScreen extends StatefulWidget {
  AddDoctorScreen({super.key});

  @override
  State<AddDoctorScreen> createState() => _AddDoctorScreenState();
}

class _AddDoctorScreenState extends State<AddDoctorScreen> {
  DoctorController doctorController = Get.put(DoctorController());

  AuthController authController = Get.put(AuthController());

  ImagePickerController imagePickerController =
      Get.put(ImagePickerController());

  final _formKey = GlobalKey<FormState>();
  Gender gender = Gender.male;
  Verify verify = Verify.yes;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      authController.getSpecialization();
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: SingleChildScrollView(
        child: SizedBox(
          height: size.height,
          width: double.infinity,
          child: Column(children: [
            Expanded(
                child: Stack(
              children: [
                Positioned(
                  top: 0,
                  left: 0,
                  right: 0,
                  child: appBarContainer(
                    size,
                    title: "Add Doctor",
                    isLeading: true,
                  ),
                ),
                Positioned(
                    top: 120.h,
                    left: 150.w,
                    right: 150.w,
                    child: avatarContainer()),
                Positioned(
                  bottom: -40.h,
                  right: -15.w,
                  child: SvgPicture.asset("assets/svg/Rectangle 5904.svg"),
                ),
                Positioned(
                    top: 260.h,
                    right: 15.w,
                    left: 15.w,
                    bottom: 15.h,
                    child: addDoctorForm(size)),
              ],
            ))
          ]),
        ),
      ),
    );
  }

  addDoctorForm(size) {
    return Obx(() {
      if (authController.rxRequestStatus.value == Status.loading) {
        return CustomLoading();
      }
      return Container(
        height: size.height,
        width: double.infinity,
        padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
        decoration: BoxDecoration(
            color: AppColors.whiteA700,
            borderRadius: BorderRadius.circular(25.r),
            boxShadow: [
              BoxShadow(
                color: AppColors.gray.withOpacity(0.1),
                spreadRadius: 1,
                blurRadius: 7,
              )
            ]),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              CustomTextFormField(
                hintText: "Name",
                labelText: "Name",
                prefix: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: SvgPicture.asset("assets/icons/person.svg"),
                ),
                controller: doctorController.nameController,
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Please enter your name";
                  }
                },
              ),
              SizedBox(height: 15.h),
              Container(
                alignment: Alignment.centerLeft,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          "Gender",
                          style: AppTextStyles.textFieldLabel,
                        ),
                        SizedBox(width: 2.w),
                        CustomImageView(
                          svgPath: "assets/icons/gender.svg",
                        )
                      ],
                    ),
                    Row(
                      children: [
                        Radio(
                          activeColor: AppColors.kprimary,
                          value: Gender.male,
                          groupValue: gender,
                          onChanged: (value) {
                            setState(() {
                              gender = value!;
                            });
                          },
                        ),
                        Text(
                          "Male",
                          style: AppTextStyles.text12WhiteRegular.copyWith(
                              color: const Color(0xff121212),
                              fontWeight: FontWeight.w400),
                        ),
                        const Spacer(),
                        Radio(
                          activeColor: AppColors.kprimary,
                          value: Gender.female,
                          groupValue: gender,
                          onChanged: (value) {
                            setState(() {
                              gender = value!;
                            });
                          },
                        ),
                        Text(
                          "Female",
                          style: AppTextStyles.text12WhiteRegular.copyWith(
                              color: const Color(0xff121212),
                              fontWeight: FontWeight.w400),
                        ),
                        const Spacer()
                      ],
                    )
                  ],
                ),
              ),
              SizedBox(height: 10.h),
              CustomDropdown(
                prefix: CustomImageView(
                  svgPath: "assets/icons/hospital.svg",
                ),
                labelText: "Specialization",
                validator: (p0) {
                  if (p0 == null) {
                    return "Specialization is required.";
                  }
                  return null;
                },
                listName: authController.specializationList
                    .map((e) => e.name!)
                    .toList(),
                hintText: "Select Specialization",
                onChng: (data) {
                  for (var i in authController.specializationList) {
                    if (i.name == data) {
                      authController.specializationId = i.id.toString();
                    }
                  }
                },
              ),
              // CustomTextFormField(
              //   hintText: "Specialization",
              //   labelText: "Specialization",
              //   controller: doctorController.specializationController,
              //   prefix: Padding(
              //     padding: const EdgeInsets.all(12.0),
              //     child: SvgPicture.asset("assets/icons/person.svg"),
              //   ),
              //   validator: (value) {
              //     if (value!.isEmpty) {
              //       return "Please enter specialization";
              //     }
              //   },
              // ),
              SizedBox(height: 10.h),
              CustomTextFormField(
                  labelText: "Phone number",
                  hintText: "Phone number",
                  controller: doctorController.phoneController,
                  maxLength: 10,
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                  ],
                  prefix: Icon(Icons.phone, color: AppColors.gray),
                  textInputType: TextInputType.number,
                  validator: phoneNumberValidator),
              SizedBox(height: 10.h),
              CustomTextFormField(
                  hintText: "E-mail",
                  labelText: "E-mail",
                  controller: doctorController.emailController,
                  prefix: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: SvgPicture.asset("assets/icons/email.svg"),
                  ),
                  validator: emailValidator),
              SizedBox(height: 10.h),
              CustomTextFormField(
                hintText: "Registration No.",
                labelText: "Registration No.",
                controller: doctorController.registrationController,
                prefix: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: SvgPicture.asset("assets/icons/edit_user.svg"),
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Please enter registration no.";
                  }
                },
              ),
              SizedBox(height: 10.h),
              CustomTextFormField(
                hintText: "Experience",
                labelText: "Experience",
                controller: doctorController.experienceController,
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                ],
                prefix: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: SvgPicture.asset("assets/icons/edit_user.svg"),
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return "enter experince";
                  }
                },
              ),
              SizedBox(height: 15.h),
              Container(
                alignment: Alignment.centerLeft,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          "Verified",
                          style: AppTextStyles.textFieldLabel,
                        ),
                        SizedBox(width: 4.w),
                        CustomImageView(
                          svgPath: "assets/icons/verify.svg",
                        )
                      ],
                    ),
                    Row(
                      children: [
                        Radio(
                          activeColor: AppColors.kprimary,
                          value: Verify.yes,
                          groupValue: verify,
                          onChanged: (value) {
                            setState(() {
                              verify = value!;
                            });
                          },
                        ),
                        Text(
                          "Yes",
                          style: AppTextStyles.text12WhiteRegular.copyWith(
                              color: const Color(0xff121212),
                              fontWeight: FontWeight.w400),
                        ),
                        const Spacer(),
                        Radio(
                          activeColor: AppColors.kprimary,
                          value: Verify.no,
                          groupValue: verify,
                          onChanged: (value) {
                            setState(() {
                              verify = value!;
                            });
                          },
                        ),
                        Text(
                          "No",
                          style: AppTextStyles.text12WhiteRegular.copyWith(
                              color: const Color(0xff121212),
                              fontWeight: FontWeight.w400),
                        ),
                        const Spacer()
                      ],
                    )
                  ],
                ),
              ),
              SizedBox(height: 10.h),
              doctorController.rxRequestStatus.value == Status.loading
                  ? const CustomLoading()
                  : CustomElevatedButton(
                      text: "Submit",
                      onTap: () {
                        if (_formKey.currentState!.validate()) {
                          doctorController.addDoctor(verify.name, gender.name);
                        }
                      },
                    )
            ],
          ),
        ),
      );
    });
  }

  avatarContainer() {
    return GetBuilder<ImagePickerController>(
        init: ImagePickerController(),
        builder: (value) {
          return Stack(
            alignment: AlignmentDirectional.bottomEnd,
            children: [
              imagePickerController.result != null
                  ? CircleAvatar(
                      radius: 60.r,
                      backgroundColor: AppColors.kprimary.withOpacity(0.1),
                      backgroundImage: FileImage(
                        imagePickerController.result!,
                      ),
                    )
                  : CircleAvatar(
                      radius: 60.r,
                      backgroundColor: AppColors.kprimary.withOpacity(0.1),
                      backgroundImage:
                          const AssetImage("assets/images/dummy_image.png")),
              // Positioned(
              //   bottom: 8.h,
              //   child: InkWell(
              //     onTap: () {
              //       imagePickerController.pickImage();
              //       // print(imagePickerController.result!);
              //     },
              //     child: Container(
              //         height: 30.h,
              //         width: 30.h,
              //         decoration: BoxDecoration(
              //           borderRadius: BorderRadius.circular(30.r),
              //           color: AppColors.kprimary,
              //         ),
              //         alignment: Alignment.centerRight,
              //         child: const Center(
              //             child: Icon(
              //           Icons.add_a_photo_outlined,
              //           size: 18,
              //           color: Colors.white,
              //         ))),
              //   ),
              // )
            ],
          );
        });
  }
}
