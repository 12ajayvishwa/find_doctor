// import 'package:find_doctor/core/app_export.dart';
// import 'package:find_doctor/routes/app_routes.dart';
// import 'package:find_doctor/theme/color_constants.dart';
// import 'package:find_doctor/widgets/app_bar/custom_app_bar.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:get/get_core/src/get_main.dart';

// import '../../../../theme/text_style.dart';

// class SurgeryListScreen extends StatefulWidget {
//   const SurgeryListScreen({super.key});

//   @override
//   State<SurgeryListScreen> createState() => _SurgeryListScreenState();
// }

// class _SurgeryListScreenState extends State<SurgeryListScreen> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: CustomAppBar(
//         title: "Home",
//         isLeading: true,
//         leading: Image.asset(
//           "assets/images/logo.png",
//           color: AppColors.kprimary,
//         ),
//         centerTitle: true,
//         actions: IconButton(
//             onPressed: () {
//               Get.toNamed(AppRoutes.NOTIFICATION);
//             },
//             icon:
//                 Icon(Icons.notifications_outlined, color: AppColors.kprimary)),
//       ),
//       body: Padding(
//         padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             const Text(
//               "Surgery History",
//               style: AppTextStyles.headline,
//             ),
//             SizedBox(
//               height: 20.h,
//             ),
//             Expanded(
//               child: ListView.builder(
//                 itemCount: 10,
//                 itemBuilder: (context, index) {
//                   return Padding(
//                     padding: EdgeInsets.only(bottom: 10.0.h),
//                     child: InkWell(
//                       onTap: () {
//                         Get.toNamed(AppRoutes.SURGERY_VIEW_ADMIN);
//                       },
//                       child: Card(
//                         child: ListTile(
//                           title: Text('Surgery Name'),
//                           subtitle: Text('Surgery Description'),
//                           trailing: Text('Surgery Date'),
//                         ),
//                       ),
//                     ),
//                   );
//                 },
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
