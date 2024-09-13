import 'package:find_doctor/presentation/auth/binding/auth_binding.dart';
import 'package:find_doctor/presentation/notification/controller.dart';
import 'package:find_doctor/presentation/notification/notification_service.dart';
import 'package:find_doctor/utils/logger.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'core/constants/app_export.dart';
import 'core/constants/connectivity_controller.dart';
import 'firebase_options.dart';
import 'presentation/notification/notification_screen.dart';

final navigatorKey = GlobalKey<NavigatorState>();
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SessionManager.init();
  
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  // FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
  //     FlutterLocalNotificationsPlugin();
  // flutterLocalNotificationsPlugin
  //     .resolvePlatformSpecificImplementation<
  //         AndroidFlutterLocalNotificationsPlugin>()!
  //     .requestNotificationsPermission();
  await NotificationService().initNotification();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((value) {
    Logger.init(kReleaseMode ? LogMode.live : LogMode.debug);
    runApp(const MyApp());
  });
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final ConnectivityController connectivityController =
      Get.put(ConnectivityController());
 

  @override
  Widget build(BuildContext context) {
    // Size size = MediaQuery.of(context).size;
    return ScreenUtilInit(
      designSize: Size(450, 936),
      minTextAdapt: true,
      splitScreenMode: true,
      child: GetMaterialApp( 
        debugShowCheckedModeBanner: false,
        // theme: ThemeData(
        //   elevatedButtonTheme: ElevatedButtonThemeData(
        //     style: ElevatedButton.styleFrom(backgroundColor: Colors.red)
        //   )
        // ),
        locale: Get.deviceLocale,
        title: 'NHM',
        navigatorKey: navigatorKey,
        initialBinding: AuthBinding(),
        initialRoute: AppRoutes.SPLASHSCREEN,
        getPages: AppRoutes.pages,
        routes: {
          NotificationScreen.route: (context) => const NotificationScreen(),
        },
      ),
    );
  }
}
