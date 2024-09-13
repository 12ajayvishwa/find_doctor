import 'package:find_doctor/widgets/app_bar/custom_app_bar.dart';
import 'package:flutter/material.dart';

class DoctorDetails extends StatelessWidget {
  const DoctorDetails({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: CustomAppBar(
          title: "Doctor's Detail",
          centerTitle: true,
          isFiltter: true,
        
        ),
    );
  }
}