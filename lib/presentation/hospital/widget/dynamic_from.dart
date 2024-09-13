// import 'package:find_doctor/presentation/hospital/controller/hospital_controller.dart';
// import 'package:find_doctor/widgets/datetime_controller.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';

// import '../../../core/constants/app_export.dart';
// import '../../doctor/widgets/success_dialog.dart';

// class DynamicForm extends StatefulWidget {
  


//   const DynamicForm(
//       {super.key, });

//   @override
//   State<DynamicForm> createState() => _DynamicFormState();
// }

// class _DynamicFormState extends State<DynamicForm> {
//   HospitalController hospitalController = Get.put(HospitalController());
//   DateTimePickerController dateTimePickerController =
//       Get.put(DateTimePickerController());
//   final _formKey = GlobalKey<FormState>();
//   String _data = '';

//   void _submitForm() {
//     if (_formKey.currentState?.validate() ?? false) {
//       _formKey.currentState?.save();
//       print('Tab ${widget.tabIndex + 1} Form Data: $_data');
//       // Handle form submission logic (e.g., send data to server)
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Form(
//       key: _formKey,
//       child: Column(
//         children: [
//           CustomTextFormField(
//             labelText: "Amount",
//             hintText: "Enter amount",
//             controller: hospitalController.amount,
//             borderDecoration: OutlineInputBorder(
//                 borderRadius: BorderRadius.circular(16.r),
//                 borderSide: BorderSide(color: AppColors.kprimary, width: 1)),
//             inputFormatters: [
//               FilteringTextInputFormatter.digitsOnly,
//             ],
//             textInputType: TextInputType.number,
//             validator: (value) {
//               if (value!.isEmpty) {
//                 return "Please enter amount";
//               }
//               return null;
//             },
//           ),
//           SizedBox(
//             height: 10.h,
//           ),
//           CustomTextFormField(
//             labelText: "Total No. of Drs Required ",
//             hintText: "Enter total number",
//             controller: hospitalController.totalNumberOfDrs,
//             borderDecoration: OutlineInputBorder(
//                 borderRadius: BorderRadius.circular(16.r),
//                 borderSide: BorderSide(color: AppColors.kprimary, width: 1)),
//             inputFormatters: [
//               FilteringTextInputFormatter.digitsOnly,
//             ],
//             textInputType: TextInputType.number,
//             validator: (value) {
//               if (value!.isEmpty) {
//                 return "Required";
//               }
//               return null;
//             },
//           ),
//           SizedBox(
//             height: 10.h,
//           ),
//           CustomTextFormField(
//             labelText: "Title",
//             hintText: "Enter title",
//             controller: hospitalController.tittle,
//             textInputType: TextInputType.text,
//             borderDecoration: OutlineInputBorder(
//                 borderRadius: BorderRadius.circular(16.r),
//                 borderSide: BorderSide(color: AppColors.kprimary, width: 1)),
//             validator: (value) {
//               if (value!.isEmpty) {
//                 return "Please enter title";
//               }
//               return null;
//             },
//           ),
//           SizedBox(
//             height: 10.h,
//           ),
//           CustomTextFormField(
//             labelText: "Patient Name",
//             hintText: "Enter patient name",
//             controller: hospitalController.patientName,
//             borderDecoration: OutlineInputBorder(
//                 borderRadius: BorderRadius.circular(16.r),
//                 borderSide: BorderSide(color: AppColors.kprimary, width: 1)),
//             textInputType: TextInputType.text,
//             validator: (value) {
//               if (value!.isEmpty) {
//                 return "Please enter patient name";
//               }
//               return null;
//             },
//           ),
//           SizedBox(
//             height: 10.h,
//           ),
//           CustomTextFormField(
//             labelText: "Patient Age",
//             hintText: "Enter patient age",
//             controller: hospitalController.patientAge,
//             // textInputType: TextInputType.text,
//             inputFormatters: [
//               FilteringTextInputFormatter.digitsOnly,
//             ],
//             textInputType: TextInputType.number,
//             borderDecoration: OutlineInputBorder(
//                 borderRadius: BorderRadius.circular(16.r),
//                 borderSide: BorderSide(color: AppColors.kprimary, width: 1)),
//             validator: (value) {
//               if (value!.isEmpty) {
//                 return "Please enter patient age";
//               }
//               return null;
//             },
//           ),
//           SizedBox(
//             height: 10.h,
//           ),
//           CustomTextFormField(
//             labelText: "Syrgery Date & Time",
//             hintText: "Enter syrgery date & time",
//             controller: hospitalController.surgeryDate,
//             borderDecoration: OutlineInputBorder(
//                 borderRadius: BorderRadius.circular(16.r),
//                 borderSide: BorderSide(color: AppColors.kprimary, width: 1)),
//             onTap: () {
//               dateTimePickerController
//                   .selectDob(hospitalController.surgeryDate);
//             },
//             readOnly: true,
//             textInputType: TextInputType.text,
//             validator: (value) {
//               if (value!.isEmpty) {
//                 return "Please enter syrgery date & time";
//               }
//               return null;
//             },
//           ),
//           SizedBox(
//             height: 10.h,
//           ),
//           Row(
//             children: [
//               SizedBox(
//                 width: 170.w,
//                 child: CustomTextFormField(
//                   labelText: "Start Time",
//                   hintText: "Enter start time",
//                   controller: hospitalController.startTime,
//                   textInputType: TextInputType.text,
//                   borderDecoration: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(16.r),
//                       borderSide:
//                           BorderSide(color: AppColors.kprimary, width: 1)),
//                   readOnly: true,
//                   onTap: () {
//                     dateTimePickerController
//                         .selectTime(hospitalController.startTime);
//                   },
//                   validator: (value) {
//                     if (value!.isEmpty) {
//                       return "Please enter start time";
//                     }
//                     return null;
//                   },
//                 ),
//               ),
//               SizedBox(
//                 width: 30.w,
//               ),
//               SizedBox(
//                 width: 170.w,
//                 child: CustomTextFormField(
//                   labelText: "End Time",
//                   hintText: "Enter end time",
//                   controller: hospitalController.endTime,
//                   textInputType: TextInputType.text,
//                   borderDecoration: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(16.r),
//                       borderSide:
//                           BorderSide(color: AppColors.kprimary, width: 1)),
//                   readOnly: true,
//                   onTap: () {
//                     dateTimePickerController
//                         .selectTime(hospitalController.endTime);
//                   },
//                   validator: (value) {
//                     if (value!.isEmpty) {
//                       return "Please enter end time";
//                     }
//                     return null;
//                   },
//                 ),
//               ),
//             ],
//           ),
//           SizedBox(
//             height: 10.h,
//           ),
//           CustomTextFormField(
//             labelText: "Description",
//             hintText: "Description",
//             controller: hospitalController.description,
//             textInputType: TextInputType.text,
//             borderDecoration: OutlineInputBorder(
//                 borderRadius: BorderRadius.circular(16.r),
//                 borderSide: BorderSide(color: AppColors.kprimary, width: 1)),
//             maxLines: 3,
//             validator: (value) {
//               if (value!.isEmpty) {
//                 return "Please enter description";
//               }
//               return null;
//             },
//           ),
//           SizedBox(
//             height: 10.h,
//           ),
//           CustomElevatedButton(
//             text: "Send Request",
//             onTap: () {
//               if (_formKey.currentState!.validate()) {
//                 showDialog(
//                   context: context,
//                   builder: (context) {
//                     return SuccessPopUpDialog(
//                       title: "Send Successfully",
//                       message:
//                           "Request send successful You’ll be redirected to the home screen now",
//                       onTap: () {
//                         Get.offAllNamed(AppRoutes.DASHBOARD);
//                       },
//                     );
//                   },
//                 );
//               }
//             },
//           )
//         ],
//       ),
//     );
//   }
// }
