import 'package:find_doctor/presentation/hospital/widget/custom_request_widget.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class SliverGridDemo extends StatelessWidget {
  SliverGridDemo({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(), 
        body: const Padding(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              SizedBox(
                height: 100,
              ),
              CustomRequestWidget()
            ],
          ),
        ));
  }

  List dataList = [
    {
      "name": "Dr. John Doe",
      "speciality": "Cardiologist",
      "image": "assets/images/doctor1.png",
      "rating": "4.5",
      "experience": "5",
      "location": "New York",
      "fee": "500",
      "distance": "2.5",
      "review": "100",
      "about":
          "Dr. John Doe is a Cardiologist in New York, USA. He has 5 years of experience in Cardiology.",
      "education": [
        {
          "degree": "MBBS",
          "college": "University of California",
          "year": "2010"
        },
        {"degree": "MD", "college": "University of California", "year": "2013"}
      ],
      "awards": [
        {"award": "Best Cardiologist of the Year", "year": "2018"},
        {"award": "Best Cardiologist of the Year", "year": "2019"}
      ],
      "services": [
        {"service": "Cardiology"},
      ]
    },
  ];
}
