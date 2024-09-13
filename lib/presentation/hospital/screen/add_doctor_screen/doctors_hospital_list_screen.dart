import 'package:find_doctor/core/constants/api_network.dart';
import 'package:find_doctor/utils/custom_toast.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/constants/app_export.dart';
import '../../widget/doctor_search_card_widget.dart';
import '../../controller/global_search_controller.dart';

class DoctorsHospitalScreen extends StatefulWidget {
 const DoctorsHospitalScreen({super.key});

  @override
  State<DoctorsHospitalScreen> createState() => _DoctorsHospitalScreenState();
}

class _DoctorsHospitalScreenState extends State<DoctorsHospitalScreen> {
  final GlobalSearchController doctorSearchController =
      Get.put(GlobalSearchController());
  final DoctorController doctorController = Get.put(DoctorController());
  final AuthController authController = Get.put(AuthController());
  @override
  void initState() {
    toast.init(context);
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      doctorController.getDoctors();
      authController.getSpecialization();
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    // print(authController.s);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Obx(() {
        return SizedBox(
          height: size.height,
          width: double.infinity,
          child: Column(children: [
            Expanded(
                child: Stack(alignment: Alignment.center, children: [
              Positioned(
                top: 0,
                left: 0,
                right: 0,
                child: appBarContainer(size, title: "Doctors"),
              ),
              Positioned(
                bottom: -40.h,
                right: -15.w,
                child: SvgPicture.asset("assets/svg/Rectangle 5904.svg"),
              ),
              Positioned(
                  top: 120.h,
                  left: 20.w,
                  right: 20.w,
                  child: Container(
                    decoration: BoxDecoration(boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.1),
                        spreadRadius: 3,
                        blurRadius: 7,
                      )
                    ]),
                    child: CustomTextFormField(
                      fillColor: Colors.white,
                      borderRadius: BorderRadius.circular(12.r),
                      suffix: IconButton(
                          icon: Icon(
                            Icons.close,
                            color:
                                doctorSearchController.searchQuery.value.isEmpty
                                    ? AppColors.whiteA700
                                    : AppColors.gray,
                          ),
                          onPressed: doctorSearchController.clearData),
                      prefix: Padding(
                        padding: EdgeInsets.all(12.0.r),
                        child: SvgPicture.asset(
                          "assets/svg/search.svg",
                        ),
                      ),
                      hintText: "Search",
                      controller: doctorSearchController.searchController,
                      onChanged: doctorSearchController.updateSearchQuery,
                    ),
                  )),
              Positioned(
                  top: 200.h,
                  right: 0.w,
                  left: 15.w,
                  child: Row(
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 5.w),
                        child: InkWell(
                          onTap: doctorSearchController.selectAll,
                          child: Container(
                              height: 50.h,
                              decoration: BoxDecoration(
                                  color:
                                      doctorSearchController.isAllSelect.value
                                          ? AppColors.kprimary
                                          : AppColors.kprimary.withOpacity(0.2),
                                  borderRadius: BorderRadius.circular(12.r)),
                              child: Padding(
                                padding: EdgeInsets.symmetric(horizontal: 20.w),
                                child: Center(
                                  child: Text("All",
                                      style: AppTextStyles.hintText.copyWith(
                                          color: doctorSearchController
                                                  .isAllSelect.value
                                              ? AppColors.whiteA700
                                              : AppColors.kprimary,
                                          fontWeight: FontWeight.w500)),
                                ),
                              )),
                        ),
                      ),
                      authController.rxRequestStatus.value == Status.loading
                          ? const CustomLoading()
                          : authController.specializationList.isEmpty
                              ? Container()
                              : GetBuilder(
                                  init: doctorSearchController,
                                  builder: (context) {
                                    return Expanded(
                                      child: SizedBox(
                                        height: 50.h,
                                        child: ListView.builder(
                                          scrollDirection: Axis.horizontal,
                                          shrinkWrap: true,
                                          itemCount: authController
                                              .specializationList.length,
                                          itemBuilder: (context, index) {
                                            final category = authController
                                                .specializationList[index];
                                            final isSelected =
                                                doctorSearchController
                                                    .selectedCategoryList
                                                    .contains(category.name);
                                            return Padding(
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: 5.w),
                                              child: InkWell(
                                                onTap: () {
                                                  doctorSearchController
                                                      .onSelect(authController
                                                          .specializationList[
                                                              index]
                                                          .name);

                                                  // doctorSearchController.searchQuery =
                                                  //     doctorSearchController
                                                  //         .categoryList[index];

                                                  // doctorSearchController.clearData();
                                                  print(doctorSearchController
                                                      .selectedCategoryList);
                                                },
                                                child: Container(
                                                    decoration: BoxDecoration(
                                                        color: isSelected
                                                            ? AppColors.kprimary
                                                            : AppColors.kprimary
                                                                .withOpacity(
                                                                    0.2),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(
                                                                    12.r)),
                                                    child: Padding(
                                                      padding:
                                                          EdgeInsets.symmetric(
                                                              horizontal: 20.w),
                                                      child: Center(
                                                        child: Text(
                                                            category.name!,
                                                            style: AppTextStyles.hintText.copyWith(
                                                                color: isSelected
                                                                    ? AppColors
                                                                        .whiteA700
                                                                    : AppColors
                                                                        .kprimary,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500)),
                                                      ),
                                                    )),
                                              ),
                                            );
                                          },
                                        ),
                                      ),
                                    );
                                  }),
                    ],
                  )),
              Positioned(
                  top: 340.h, 
                  right: 10.w,
                  left: 10.w,
                  bottom: 0.h,
                  child: Obx(() {
                    var filteredDoctors =
                        doctorSearchController.filteredDoctors;
                    if (doctorController.rxRequestStatus.value ==
                        Status.loading) {
                      return const CustomLoading();
                    } else if (filteredDoctors.isEmpty) {
                      return const Center(
                        child: Text(
                          'No doctors found !',
                          style: AppTextStyles.headline,
                        ),
                      );
                    }
                    return ListView.builder(
                      itemCount: filteredDoctors.length,
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        var data = filteredDoctors[index];

                        return DoctorSearchCardWidget(
                          gender: data.gender ?? "male",
                          imageUrl: data.avatar == null
                              ? null
                              : ApiNetwork.imageUrl + data.avatar,
                          name: "Dr. ${data.name.toString() ?? ""}",
                          speciality: data.specialization == null
                              ? "null"
                              : data.specialization!.name!,
                          onTap: () {
                            Get.toNamed(AppRoutes.DOCTOR_PROFILE,
                                arguments: data);
                          },
                        );
                      },
                    );
                  })),
              Positioned(
                  top: 280.h,
                  right: 10.w,
                  child: InkWell(
                    onTap: () {
                      Get.toNamed(AppRoutes.ADD_DOCTORS);
                    },
                    child: Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: AppColors.kprimary.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(12.r),
                      ),
                      child: Text(
                        "Add Doctor +",
                        style: AppTextStyles.text18Black600
                            .copyWith(color: AppColors.kprimary),
                      ),
                    ),
                  )),
            ])),
          ]),
        );
      }),
    );
  }
}
