import 'package:find_doctor/core/constants/app_export.dart';

import 'create_surgery_component.dart';

class CreateSurgeryFunctionController extends GetxController {
  void increment(int index) {
    int currentValue = int.tryParse(totalNumberOfDrs[index].text) ?? 0;
    currentValue++;
    totalNumberOfDrs[index].text = currentValue.toString();
    handleChange(index, 'no_of_doctors', currentValue.toString());
    update();
  }

  void decrement(int index) {
    int currentValue = int.tryParse(totalNumberOfDrs[index].text) ?? 0;
    if (currentValue > 0) {
      currentValue--;
      totalNumberOfDrs[index].text = currentValue.toString();
      handleChange(index, 'no_of_doctors', currentValue.toString());
    }
    update();
  }

  void handleChange(int index, String field, String value) {
    fieldList[index][field] = value;
    update();
  }
}
