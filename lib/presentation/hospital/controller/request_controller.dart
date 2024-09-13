import 'package:find_doctor/core/constants/app_export.dart';
import 'package:find_doctor/data/model/send_request_model.dart';
import '../../../core/constants/api_network.dart';
import '../../../data/apiClient/api_client.dart';
import '../../../data/model/send_request_appoinment_model.dart';
import '../../../utils/custom_toast.dart';
import '../../../widgets/success_dialog.dart';
import '../screen/request_screen/create_surgery_request.dart/components/create_surgery_component.dart';

var isPrimaryDisable;

class RequestController extends GetxController {
  final rxRequestStatus = Status.success.obs;
  NetworkHttpServices api = NetworkHttpServices();
  List<SendRequestModel> requestsList = <SendRequestModel>[].obs;
  List<SendRequestAppoinmentModel> requestAppointmentList =
      <SendRequestAppoinmentModel>[].obs;
  TextEditingController searchQueryController = TextEditingController();
  var pageKey = 1.obs;
  var perPage = 10;
  RxInt month = DateTime.now().month.obs;
  RxInt day = 0.obs;
  RxInt year = DateTime.now().year.obs;
  var searchQuery = ''.obs;
  // RxString requestId = ''.obs;
  // Send request function
  sendRequest(List<Map<String, String>> fieldList) async {
    rxRequestStatus.value = Status.loading;
    try {
      var payload = {"appointmentRequestArray": fieldList};
      var response =
          await api.post(ApiNetwork.sendRequest, json.encode(payload), true);
      if (response['success'] == true) {
        rxRequestStatus.value = Status.success;
        showDialog(
          context: Get.context!,
          builder: (context) {
            return SuccessPopUpDialog(
              message:
                  "Request send successful You’ll be redirected to the home screen now",
              onTap: () {
                Get.offAllNamed(AppRoutes.DASHBOARD, arguments: [2,0]);
              },
              title: "Send Successfully",
            );
          },
        );
      } else {
        rxRequestStatus.value = Status.error;
        showErrorToast(toast, response["massage"]);
      }
    } catch (e) {
      rxRequestStatus.value = Status.error;
      showErrorToast(toast, e.toString());
    }
  }

  getRequestAppoinments(
      {pageKey, pageSize, requestId, status, dayD, monthM, yearY}) async {
    try {
      rxRequestStatus.value = Status.loading;
      var payload = {
        "page": 1,
        "per_page": 20,
        "order_by": [
          {"column": "id", "order": "desc"}
        ],
        "filter_by": {
          "year": yearY ?? year.value.toInt(),
          "month": monthM ?? month.value.toInt(),
          "day": dayD ?? day.value.toInt(),
          "request_id": requestId,
          "status": status
        }
      };
      print(payload);
      var response = await api.post(
          ApiNetwork.getRequestSendedToDoctor, jsonEncode(payload), true);
      if (response['success'] == true) {
        rxRequestStatus.value = Status.success;
        var appointmentList = response['payload']['data'];
        isPrimaryDisable = response['payload']['meta']['isPrimary'];
        
        appointmentList.forEach((data) {
          requestAppointmentList
              .add(SendRequestAppoinmentModel.fromJson(data!));
        });
      } else {
        showErrorToast(toast, response['message']);
        rxRequestStatus.value = Status.error;
      }
    } catch (e) {
      showErrorToast(toast, e.toString());
      rxRequestStatus.value = Status.error;
    }
  }

  getRequest({pageKey, pageSize, searchTerm, status}) async {
    print(year);
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
          "status": status ?? "",
        }
      };
      print("payload$payload");
      var data =
          await api.post(ApiNetwork.getRequest, jsonEncode(payload), true);
      if (data['success'] = true) {
        var requests = data['payload']['data'];

        requests.forEach((data) {
          requestsList.add(SendRequestModel.fromJson(data));
        });
        rxRequestStatus.value = Status.success;
      } else {
        showErrorToast(toast, data['message']);
        rxRequestStatus.value = Status.error;
      }
    } catch (e) {
      showErrorToast(toast, e.toString());
      rxRequestStatus.value = Status.error;
    }
  }

  clearDataOfSearch() {
    searchQueryController.text = "";
    searchQuery.value = "";
    update();
  }

  clearData() {
    requestsList.clear();
    requestAppointmentList.clear();
    day.value = 0;

    // month.value = 0;
    // year.value = 0;
  }
}
