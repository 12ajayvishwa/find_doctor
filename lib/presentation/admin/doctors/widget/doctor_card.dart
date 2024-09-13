// import 'package:flutter_screenutil/flutter_screenutil.dart';

// import '../../../../core/constants/app_export.dart';


// class DoctorsCardWidget extends StatelessWidget {
//   const DoctorsCardWidget({
//     super.key,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//         decoration: BoxDecoration(
//           color: AppColors.whiteA700,
//           borderRadius: BorderRadius.circular(10.r),
//           boxShadow: [
//             BoxShadow(
//                 color: AppColors.kprimary.withOpacity(0.1),
//                 blurRadius: 5,
//                 offset: const Offset(0, 3)),
//             BoxShadow(
//               color: AppColors.kprimary.withOpacity(0.1),
//               blurRadius: 5,
//               offset: const Offset(0, -3),
//             ),
//             BoxShadow(
//               color: AppColors.kprimary.withOpacity(0.1),
//               blurRadius: 5,
//               offset: const Offset(-3, 0),
//             ),
//             BoxShadow(
//               color: AppColors.kprimary.withOpacity(0.1),
//               blurRadius: 5,
//               offset: const Offset(3, 0),
//             ),
//           ],
//         ),
//         child: Column(
//           children: [
//             Padding(
//               padding: EdgeInsets.symmetric(horizontal: 15.w),
//               child: Row(
//                 children: [
//                   Image.asset(
//                     "assets/images/doctors.png",
//                     fit: BoxFit.fill,
//                   ),
//                   Expanded(
//                       child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.end,
//                     children: [
//                       Text(
//                         "Doctors",
//                         style: AppTextStyles.bodyText.copyWith(
//                             fontSize: 24.sp,
//                             fontWeight: FontWeight.w500,
//                             color: AppColors.kprimary),
//                       ),
//                       Text(
//                         textAlign: TextAlign.right,
//                         "obstetrics and gynecology  sepecialist gynecological cosmetic specialist",
//                         style: AppTextStyles.bodyText.copyWith(fontSize: 12.sp),
//                       ),
//                       SizedBox(
//                         height: 5.h,
//                       ),
//                       Container(
//                         padding: EdgeInsets.symmetric(
//                             horizontal: 15.w, vertical: 5.h),
//                         decoration: BoxDecoration(
//                             color: AppColors.kprimary,
//                             borderRadius: BorderRadius.circular(10.r),
//                             boxShadow: [
//                               BoxShadow(
//                                   color: AppColors.kprimary.withOpacity(0.1),
//                                   blurRadius: 5,
//                                   offset: const Offset(0, 3))
//                             ]),
//                         child: Text(
//                           "Active",
//                           style: AppTextStyles.bodyText
//                               .copyWith(color: Colors.white),
//                         ),
//                       )
//                     ],
//                   ))
//                 ],
//               ),
//             ),
//             Container(
//               padding: EdgeInsets.symmetric(horizontal: 15.w),
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   Text(
//                     "Dr. Daa Rahman",
//                     style: AppTextStyles.bodyText.copyWith(
//                         fontSize: 15.sp,
//                         fontWeight: FontWeight.w500,
//                         color: const Color(0XFF545454)),
//                   ),
//                   Text(
//                     "12 year experience",
//                     style: AppTextStyles.bodyText.copyWith(
//                         fontSize: 15.sp,
//                         fontWeight: FontWeight.w500,
//                         color: AppColors.kprimary),
//                   ),
//                 ],
//               ),
//             ),
//             SizedBox(
//               height: 10.h,
//             ),
//             Row(
//               children: [
//                 Expanded(
//                   child: _buildTab(
//                     onTap: () {},
//                     title: "Share",
//                     icon: Icons.share,
//                     borderRadiusGeometry: BorderRadius.only(
//                         bottomLeft: Radius.circular(10.r),
//                         topLeft: Radius.circular(10.r)),
//                   ),
//                 ),
//                 SizedBox(
//                   width: 2.w,
//                 ),
//                 _buildTab(
//                   onTap: () {},
//                   title: "add to favorite",
//                   icon: Icons.favorite,
//                   borderRadiusGeometry: BorderRadius.zero,
//                 ),
//                 SizedBox(
//                   width: 2.w,
//                 ),
//                 Expanded(
//                   child: _buildTab(
//                     onTap: () {},
//                     title: "View",
//                     icon: Icons.visibility,
//                     borderRadiusGeometry: BorderRadius.only(
//                         bottomRight: Radius.circular(10.r),
//                         topRight: Radius.circular(10.r)),
//                   ),
//                 ),
//               ],
//             )
//           ],
//         ));
//   }

//   InkWell _buildTab(
//       {String? title,
//       IconData? icon,
//       BorderRadiusGeometry? borderRadiusGeometry,
//       VoidCallback? onTap}) {
//     return InkWell(
//       onTap: onTap,
//       child: Container(
//         padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 10.h),
//         decoration: BoxDecoration(
//             color: AppColors.kprimary,
//             borderRadius: borderRadiusGeometry,
//             boxShadow: [
//               BoxShadow(
//                   color: AppColors.kprimary.withOpacity(0.1),
//                   blurRadius: 5,
//                   offset: const Offset(0, 3))
//             ]),
//         child: Row(
//           mainAxisSize: MainAxisSize.min,
//           children: [
//             Text(
//               title!,
//               style: AppTextStyles.bodyText
//                   .copyWith(color: Colors.white, fontSize: 12.sp),
//             ),
//             SizedBox(
//               width: 10.w,
//             ),
//             Icon(
//               icon!,
//               color: Colors.white,
//               size: 17.sp,
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
