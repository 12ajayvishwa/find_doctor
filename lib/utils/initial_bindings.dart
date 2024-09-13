import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:find_doctor/utils/pref_utils.dart';

import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/get_instance.dart';


import '../core/network/network_info.dart';


class InitialBindings extends Bindings {
  @override
  void dependencies() {
    Get.put(PrefUtils());
    
    Connectivity connectivity = Connectivity();
    Get.put(NetworkInfo(connectivity));
  }
}
