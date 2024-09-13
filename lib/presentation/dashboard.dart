import 'package:find_doctor/core/constants/session_manager.dart';
import 'package:find_doctor/utils/custom_toast.dart';
import 'package:find_doctor/widgets/custom_image_view.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../theme/color_constants.dart';
import 'doctor/all_doc_records/all_records_screen.dart';
import 'doctor/screens/appointment_screen.dart';
import 'home/screen/home_screen.dart';
import 'hospital/screen/request_screen/add_request_screen.dart';
import 'hospital/screen/add_doctor_screen/doctors_hospital_list_screen.dart';
import 'hospital/screen/request_screen/all_request_screen.dart';

var tabIndexOfApn;

class Dashboard extends StatefulWidget {
  const Dashboard({
    super.key,
  });

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  var data = Get.arguments;

  int? _selectedIndex = SessionManager.getUserTypeId() == "3"
      ? 1
      : SessionManager.getUserTypeId() == "2"
          ? 0
          : 0;

  static const List<Widget> _dotor = <Widget>[
    AppointmentScreen(),
    HomeScreen(),
    AllReocrdsScreen()
  ];
  // static const List<Widget> _admin = <Widget>[
  //   AppointmentScreen(),
  //   HomeScreen(),
  //   DoctorDprScreen(),
  // ];
  static final List<Widget> _approval = <Widget>[
    const HomeScreen(),
    const AddRequestScreen(),
    const AllRequestScreen(),
    DoctorsHospitalScreen(),
    const AllReocrdsScreen()
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  void initState() {
    toast.init(context);
    if (data != null) {
      _selectedIndex = data[0];
    }
    tabIndexOfApn = SessionManager.getUserTypeId() == "3"
        ? data == null
            ? null
            : data[1]
        : SessionManager.getUserTypeId() == "2"
            ? data == null
                ? null
                : data[1]
            : null;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (kDebugMode) {
      print("dfddd ${data == null ? null : data[0]}");
    }
    return Scaffold(
      body: Center(
        child: SessionManager.getUserTypeId() == "3"
            ? _dotor.elementAt(_selectedIndex ?? 1)
            : _approval.elementAt(_selectedIndex ?? 0),
      ),
      bottomNavigationBar: customNavigationBar(),
    );
  }

  BottomNavigationBar customNavigationBar() {
    return BottomNavigationBar(
        showSelectedLabels: false,
        showUnselectedLabels: false,
        items: <BottomNavigationBarItem>[
          for (var i = 0; i < bottomNavItemList.length; i++)
            BottomNavigationBarItem(
              icon: Container(
                padding: EdgeInsets.all(10.sp),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: _selectedIndex == i
                      ? AppColors.kprimary
                      : Colors.transparent,
                ),
                child: CustomImageView(
                  svgPath: bottomNavItemList[i]["icon"],
                  color: _selectedIndex == i ? AppColors.whiteA700 : null,
                ),
              ),
              label: bottomNavItemList[i]["label"],
            ),
        ],
        type: BottomNavigationBarType.fixed,
        currentIndex: _selectedIndex ?? 1,
        selectedItemColor: AppColors.ksecondaryColor,
        unselectedItemColor: AppColors.ksecondaryColor.withOpacity(0.8),
        onTap: _onItemTapped,
        elevation: 8);
  }

  List<dynamic> bottomNavItemList = SessionManager.getUserTypeId() == "3"
      ? [
          {
            "icon": "assets/icons/calender.svg",
            "label": "Calender",
          },
          {
            "icon": "assets/icons/home.svg",
            "label": "Home",
          },
          {
            "icon": "assets/icons/open_folder.svg",
            "label": "Notes",
          },
        ]
      : [
          {
            "icon": "assets/icons/home.svg",
            "label": "Home",
          },
          {
            "icon": "assets/svg/add.svg",
            "label": "Add Request",
          },
          {
            "icon": "assets/icons/calender.svg",
            "label": "Calender",
          },
          {
            "icon": "assets/svg/doctor_icon.svg",
            "label": "Doctor",
          },
          {
            "icon": "assets/icons/open_folder.svg",
            "label": "Notes",
          },
        ];
}
