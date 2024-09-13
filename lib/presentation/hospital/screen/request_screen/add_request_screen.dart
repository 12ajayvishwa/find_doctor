import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/constants/app_export.dart';

class AddRequestScreen extends StatelessWidget {
  const AddRequestScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: SizedBox(
        height: double.infinity,
        width: double.infinity,
        child: Column(children: [
          appBarContainer(size, title: "Add Request"),
          Expanded(
              child: Stack(
            alignment: Alignment.center,
            children: [
              Positioned(
                bottom: -40.h,
                right: -15.w,
                child: SvgPicture.asset("assets/svg/Rectangle 5904.svg"),
              ),
              CreateRequestWidget(
                onTap: () {
                  Get.toNamed(AppRoutes.ADD_REQUEST);
                },
              )
            ],
          ))
        ]),
      ),
    );
  }
}
