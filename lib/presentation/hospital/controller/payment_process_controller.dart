import 'package:find_doctor/core/constants/app_export.dart';

class PaymentProcessController extends GetxController{
  bool isEditable = false;

 formEdit(){
  isEditable = !isEditable;
  update();
 }
}