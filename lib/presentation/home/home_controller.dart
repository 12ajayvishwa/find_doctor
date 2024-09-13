import 'package:find_doctor/core/constants/app_export.dart';

import '../../core/constants/api_network.dart';
import '../../data/apiClient/api_client.dart';
import '../../data/apiClient/http_response.dart';
import '../../utils/custom_toast.dart';

class HomeController extends GetxController {
  RxBool isExpanded = false.obs;
  NetworkHttpServices api = NetworkHttpServices();
  final rxRequestStatus = Status.success.obs;

  var categoryList = [];

  void onPanUpdate(DragUpdateDetails details) {
    if (details.delta.dy < 0) {
      isExpanded.value = true;
    } else if (details.delta.dy > 0) {
      isExpanded.value = false;
    }
  }

  getCategory() async {
    rxRequestStatus.value = Status.loading;

    try {
      var response = await api.post(ApiNetwork.categoryList, null, false);
      if (response["success"] == true) {
        categoryList = response['payload']['data'];
        rxRequestStatus.value = Status.success;
        return categoryList;
      } else {
        showErrorToast(toast, response["message"]);
        rxRequestStatus.value = Status.error;
      }
    } catch (e) {
      showErrorToast(toast, e.toString());
      rxRequestStatus.value = Status.error;
    }
  }
}
