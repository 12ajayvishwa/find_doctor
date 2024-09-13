import 'package:find_doctor/core/constants/app_export.dart';
import 'package:find_doctor/data/model/doctors_model.dart';
import 'package:find_doctor/data/model/send_request_appoinment_model.dart';
import '../model/request_details_model.dart';
import 'package:timeago/timeago.dart' as timeago;

class GlobalSearchController extends GetxController {
  TextEditingController searchController = TextEditingController();
  DoctorController doctorController = Get.put(DoctorController());
  AuthController authController = Get.put(AuthController());
  final rxRequestStatus = Status.success.obs;

  List selectedCategoryList = [].obs;
  List allSelect = [].obs;

  var searchQuery = ''.obs;
  var isAllSelect = true.obs;

  List<Doctor> get filteredDoctors {
    rxRequestStatus.value = Status.loading;

    List<Doctor> filteredList = doctorController.doctorList;

    if (searchQuery.isNotEmpty) {
      filteredList = filteredList.where((doctor) {
        final nameMatch =
            doctor.name?.toLowerCase().contains(searchQuery.toLowerCase()) ??
                false;
        final specializationMatch = doctor.specialization?.name
                ?.toLowerCase()
                .contains(searchQuery.toLowerCase()) ??
            false;
        return nameMatch || specializationMatch;
      }).toList();
    }

    if (selectedCategoryList.isNotEmpty) {
      filteredList = filteredList.where((doctor) {
        return selectedCategoryList.contains(doctor.specialization?.name);
      }).toList();
    }

    rxRequestStatus.value = Status.success;
    return filteredList;
  }

  void updateSearchQuery(String query) {
    searchQuery.value = query;
    update();
  }

  onSelect(value) {
    if (selectedCategoryList.contains(value)) {
      selectedCategoryList.remove(value);
      clearData();
    } else {
      selectedCategoryList.add(value);
      isAllSelect.value = false;
      print(selectedCategoryList);
    }
    update();
  }

  void selectAll() {
    searchQuery.value = "";
    if (isAllSelect.value) {
      selectedCategoryList.clear();
    } else {
      selectedCategoryList.clear();
      isAllSelect.value = true;
      print(selectedCategoryList);
    }

    update();
  }

  String getTimeAgo(DateTime date) {
    return timeago.format(date);
  }

  clearData() {
    searchController.text = "";
    searchQuery.value = "";
    update();
  }

  final List<Surgery> surgeries = [
    Surgery(
      date: DateTime.now(),
      startTime: '10:00 AM',
      endTime: '12:00 PM',
      category: 'Appendectomy',
      detailMessage: 'Appendectomy',
    ),
    Surgery(
      date: DateTime.now(),
      startTime: '02:00 PM',
      endTime: '04:00 PM',
      category: 'Gallbladder removal',
      detailMessage: 'Gallbladder removal',
    ),
    Surgery(
      date: DateTime.now(),
      startTime: '09:00 AM',
      endTime: '11:00 AM',
      category: 'Hernia repair',
      detailMessage: 'Hernia repair',
    ),
    Surgery(
      date: DateTime.now(),
      startTime: '10:00 AM',
      endTime: '12:00 PM',
      category: 'Appendectomy',
      detailMessage: 'Appendectomy',
    ),
    Surgery(
      date: DateTime.now(),
      startTime: '02:00 PM',
      endTime: '04:00 PM',
      category: 'Gallbladder removal',
      detailMessage: 'Gallbladder removal',
    ),
    Surgery(
      date: DateTime.now(),
      startTime: '09:00 AM',
      endTime: '11:00 AM',
      category: 'Hernia repair',
      detailMessage: 'Hernia repair',
    ),
    // Add more surgeries here
  ].obs;
}
