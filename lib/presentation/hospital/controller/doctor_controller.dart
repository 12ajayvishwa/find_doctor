import 'package:find_doctor/core/constants/app_export.dart';
import 'package:find_doctor/core/constants/api_network.dart';
import 'package:find_doctor/data/model/send_request_appoinment_model.dart';
import 'package:find_doctor/utils/custom_toast.dart';
import '../../../data/apiClient/api_client.dart';
import '../../../data/model/doctors_model.dart';
import '../../../utils/custom_snackbar.dart';
import '../../profile/controller.dart';

class DoctorController extends GetxController {
  
  final rxRequestStatus = Status.success.obs;
  NetworkHttpServices api = NetworkHttpServices();
  SettingController settingController = Get.put(SettingController());
  AuthController authController = Get.put(AuthController());

  //Controllers
  TextEditingController nameController = TextEditingController();
  TextEditingController specializationController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController registrationController = TextEditingController();
  TextEditingController experienceController = TextEditingController();

  List<Doctor> doctorList = [];

  addDoctor(verify,gender) async {
    print(verify);
    rxRequestStatus.value = Status.loading;
    var body = {

      "name": nameController.text,
      "email": emailController.text,
      "phone": phoneController.text,
      "registration_no": registrationController.text,
      //"password": "12345678",
      "user_type_id": "3",
      "hospital_id": SessionManager.getUserId(),
      "specialization_id": authController.specializationId,
      "address": "Shah Pura Bhopal",
      "experience": experienceController.text,
      "verified": verify == "yes" ? "true" : "false",
      "gender": gender,
      //"avatar": null,
      //"active": 1,kam
      "role": "doctor",
    };
    print(body);
    try {
      var response = await api.post(ApiNetwork.createDoctor, body, false);
      if (response["success"] == true) {
        rxRequestStatus.value = Status.success;
        showSuccessToast(toast, response['message']);
        Get.offAllNamed(AppRoutes.DASHBOARD, arguments: [3,0]);
      } else if (response["success"] == false) {
        rxRequestStatus.value = Status.error;
        showErrorToast(toast, response['message']);
      }
    } catch (e) {
      rxRequestStatus.value = Status.error;
      showErrorToast(toast, e.toString());
    }
  }

  getDoctors() async {
    rxRequestStatus.value = Status.loading;

    try {
      var response = await api.post(
        ApiNetwork.doctorsList,
        null,
        false,
      );
      if (response['success'] = true) {
        rxRequestStatus.value = Status.success;
        doctorList = [];
        var doctorsData = response["payload"]["data"];
        doctorsData.forEach((data) {
          doctorList.add(Doctor.fromJson(data));
        });
      } else {
        rxRequestStatus.value = Status.error;
        customFlutterToast(
            backgroundColor: Colors.red, msg: response["message"].toString());
      }
    } catch (e) {
      // showDialog(
      //   context: Get.context!,
      //   builder: (context) {
      //     return LogOutPopUpDialog(
      //       msg: "You are not authorized to access this url",
      //       title: "Error",
      //       onPressed: () {
      //         settingController.logout();
      //       },
      //     );
      //   },
      // );
      customFlutterToast(backgroundColor: Colors.red, msg: e.toString());
      rxRequestStatus.value = Status.error;
    }
  }

  @override
  void onClose() {
    doctorList.clear();
    super.onClose();
  }
}
