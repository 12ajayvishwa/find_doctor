import 'package:find_doctor/core/constants/api_network.dart';
import 'package:find_doctor/core/constants/app_export.dart';
import 'package:find_doctor/presentation/doctor/models/appointments_request_model.dart';
import 'package:find_doctor/utils/custom_toast.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import '../../../data/apiClient/api_client.dart';
import '../../../widgets/success_dialog.dart';
import '../../notification/notification_service.dart';

class AppointmentController extends GetxController {
  RxBool isExpanded = false.obs;
  NetworkHttpServices api = NetworkHttpServices();
  final rxRequestStatus = Status.success.obs;
  RxString? date;
  RxInt month = DateTime.now().month.obs;
  RxInt day = 0.obs;
  RxInt year = DateTime.now().year.obs;
  List<AppointmentRequestModel> requestAppointments =
      <AppointmentRequestModel>[].obs;
  List<AppointmentRequestModel> upcommingAppointmentsList =
      <AppointmentRequestModel>[].obs;
//   @override
//   void onClose() {
//  requestAppointments.
//     super.onClose();
//   }

  getRequestAppointments({String? status}) async {
    try {
      rxRequestStatus.value = Status.loading;

      var payload = {
        "page": 1,
        "per_page": 10,
        "order_by": [
          {"column": "id", "order": "desc"}
        ],
        "filter_by": {
          "year": year.value.toInt(),
          "month": month.value.toInt(),
          "day": day.value.toInt(),
          "doctor_id": SessionManager.getUserId() ?? "",
          "status": status ?? "",
        }
      };
      // var payload = {
      //   "page": 1,
      //   "per_page": 20,
      //   "month": month ?? "",
      //   "order_by": [
      //     {"column": "id", "order": "desc"}
      //   ],
      //   "filter_by": {
      //     "request_id": "",

      //     "status": status ?? ""
      //   }
      // };
      print(payload);
      final response = await api.post(
          ApiNetwork.getRequestSendedToDoctor, jsonEncode(payload), true);
      if (response['success'] == true) {
        rxRequestStatus.value = Status.success;
        var requestData = response['payload']['data'];
        requestData.forEach((data) {
          requestAppointments.add(AppointmentRequestModel.fromJson(data));
        });
      } else {
        rxRequestStatus.value = Status.error;
        showErrorToast(toast, response['message']);
      }
    } catch (e) {
      rxRequestStatus.value = Status.error;
      showErrorToast(toast, e.toString());
    }
  }

  appointmentModeChange({action, id}) async {
    try {
      rxRequestStatus.value = Status.loading;
      var payload = {"action": action};
      print(action);
      var response =
          await api.post("${ApiNetwork.appointmentMode}$id", payload, false);

      if (response['success'] == true) {
        rxRequestStatus.value = Status.success;
        showSuccessToast(toast, response['message']);
        showDialog(
          context: Get.context!,
          builder: (context) {
            return SuccessPopUpDialog(
              title: "Send Successfully",
              message:
                  "Request send successful You’ll be redirected to the home screen now",
              onTap: () {
                print("hi");
                Get.offAllNamed(AppRoutes.DASHBOARD, arguments: [0, 0]);
              },
            );
          },
        );
      } else {
        rxRequestStatus.value = Status.error;
        showErrorToast(toast, response['message']);
      }
    } catch (e) {
      rxRequestStatus.value = Status.error;
      showErrorToast(toast, e.toString());
    }
  }

  getUpcommingAppointment({action, id, status}) async {
    try {
      rxRequestStatus.value = Status.loading;

      var payload = {
        "page": 1,
        "per_page": 10,
        "order_by": [
          {"column": "id", "order": "desc"}
        ],
        "filter_by": {
          "year": year.value.toInt(),
          "month": month.value.toInt(),
          "day": day.value.toInt(),
          "doctor_id": SessionManager.getUserId() ?? "",
          "status": status ?? "",
        }
      };
      // var payload = {
      //   "page": 1,
      //   "per_page": 20,
      //   "month": month ?? "",
      //   "order_by": [
      //     {"column": "id", "order": "desc"}
      //   ],
      //   "filter_by": {
      //     "request_id": "",

      //     "status": status ?? ""
      //   }
      // };
      print(payload);
      final response = await api.post(
          ApiNetwork.getUpcommingAppointment, jsonEncode(payload), true);
      if (response['success'] == true) {
        rxRequestStatus.value = Status.success;
        var requestData = response['payload']['data'];
        requestData.forEach((data) {
          upcommingAppointmentsList.add(AppointmentRequestModel.fromJson(data));
        });
      } else {
        rxRequestStatus.value = Status.error;
        showErrorToast(toast, response['message']);
      }
    } catch (e) {
      rxRequestStatus.value = Status.error;
      showErrorToast(toast, e.toString());
    }
  }

  appointmentAction({action, id, surgeryDescription}) async {
    try {
      rxRequestStatus.value = Status.loading;
      var payload = {
        "action": action,
        "surgery_description": surgeryDescription ?? ""
      };
      var response =
          await api.post("${ApiNetwork.appointmentAction}$id", payload, false);

      if (response['success'] == true) {
        rxRequestStatus.value = Status.success;
        if (action == "completed" || action == "accepted") {
          await NotificationService().localNotification.show(
                0,
                action == "completed" ? "Surgery Completed" : "Reguest",
                action == "completed"
                    ? "your surgey action sended to Hospital,for payment procsess"
                    : "your surgey request sended to Hospital, Please wait till hospital approval",
                const NotificationDetails(
                  android: AndroidNotificationDetails(
                    'Request_sended_channel',
                    'Request Sendes',
                    importance: Importance.high,
                    priority: Priority.high,
                  ),
                ),
              );
        }

        SessionManager.getUserTypeId() == "3"
            ? Get.offAllNamed(AppRoutes.DASHBOARD, arguments: [0, 0])
            : Get.offAndToNamed(
                AppRoutes.PAYMENT_PROCESS_SCREEN,
              );
      } else {
        rxRequestStatus.value = Status.error;
        showErrorToast(toast, response['message']);
      }
    } catch (e) {
      rxRequestStatus.value = Status.error;
      showErrorToast(toast, e.toString());
    }
  }

  appointmentApprove({action, id}) async {
    try {
      rxRequestStatus.value = Status.loading;
      var payload = {
        "action": action,
      };
      var response =
          await api.post("${ApiNetwork.appointmentAction}$id", payload, false);

      if (response['success'] == true) {
        rxRequestStatus.value = Status.success;
        // showSuccessToast(toast, response['message']);
        // if (SessionManager.getUserTypeId() == "3" || action == "accepted") {
        //   await NotificationService().localNotification.show(
        //         0,
        //         "Reguest",
        //         "your surgey request sended to Hospital, Please wait till hospital approval",
        //         const NotificationDetails(
        //           android: AndroidNotificationDetails(
        //             'Request_sended_channel',
        //             'Request Sendes',
        //             importance: Importance.high,
        //             priority: Priority.high,
        //           ),
        //         ),
        //       );
        // }
        showDialog(
          context: Get.context!,
          builder: (context) {
            Future.delayed(Duration(seconds: 1), () {
              Get.offAndToNamed(AppRoutes.HOSPITAL_PAYMENT);
            });
            return const SuccessPopUpDialog(
              title: "Approved",
              message: "Request is now send to the payment process section",
            );
          },
        );

        // SessionManager.getUserTypeId() == "3"
        //     ? Get.offAllNamed(AppRoutes.DASHBOARD, arguments: 0)
        //     : Get.offAndToNamed(
        //         AppRoutes.PAYMENT_PROCESS_SCREEN,
        //       );
      } else {
        rxRequestStatus.value = Status.error;
        showErrorToast(toast, response['message']);
      }
    } catch (e) {
      rxRequestStatus.value = Status.error;
      showErrorToast(toast, e.toString());
    }
  }

  clearData() {
    requestAppointments.clear();
    upcommingAppointmentsList.clear();
  }
}
