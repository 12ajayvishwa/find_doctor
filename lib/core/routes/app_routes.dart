// ignore_for_file: constant_identifier_names

import 'package:find_doctor/core/routes/route_export.dart';
import 'package:find_doctor/presentation/doctor/all_doc_records/screens/completed_surgery_screen.dart';

import '../../presentation/doctor/all_doc_records/screens/doc_verified_requests.dart';
import '../../presentation/hospital/all_record_hospital.dart/verified_request_hos.dart';
import '../../presentation/hospital/categories_screen.dart';
import '../../presentation/hospital/screen/request_screen/hos_verified_request.dart';

class AppRoutes {
  // App Starting Routes
  static const SPLASHSCREEN = '/';
  static const ONBOARDSCREEN = '/onboard';

  //Auth Routes
  static const LOGIN = '/login';
  static const LOGIN_VERIFICATION = '/login_verification';
  static const SIGN_UP = '/sign_up';
  static const PROFILE = '/profile';
  static const EDITPROFILE = '/edit_profile';
  static const FORGOT_PASSWORD = '/forgot_password';

  //Admin Routes
  static const DOCTOR_VIEW = '/doctor_view';
  static const SURGERY_VIEW_ADMIN = '/surgery_view_admin';

  //Common Routes
  static const NOTIFICATION = '/notification';
  static const CONTACT_SUPPORT = '/contact_support';
  static const TERM_CONDITION = '/term_condition';
  static const FAQ = '/faq';
  static const DASHBOARD = "/dashboard";

  // Surgery Appointment Doctoor Routes
  static const SURGERY_LIST = '/surgery_list';
  static const SURGERY_VIEW_DOCTOR = '/surgery_view_doctor';
  static const APPOINTMENT = '/appointment_screen';
  static const VIEW_APPOINTMENT = '/view_appointment_screen';
  static const UPCOMMING_APPOINTMENT_SCREEN = '/upcomming_appointment_screen';
  static const SUCCESFULLYSURGERIESCOMPLETE =
      '/successfully_surgeries_complete';
  static const ALL_REQUEST = "/all_request";
  static const ALL_RECORDS = "/all_records";
  static const REQUEST_VERIFIED_DOC = "/request_verified_doc";
  static const REQUEST_VERIFIED_HOS = "/request_verified_hos";

  //Hospital side Routes
  static const ALL_APPOINTMENT = "/all_appointment";

  static const REQUEST_VERIFICATION_STATUS = "/Request_Verification_status";
  static const REQUEST_VERIFICATION_DETAILS_DOC =
      "/Request_Verification_details_doc";
  static const REQUEST_VERIFICATION_DETAILS_HOS =
      "/Request_Verification_details_hos";
  static const PAYMENT_PROCESS_SCREEN = "/payment_process_screen";

  // Hospital Routes
  static const ADD_REQUEST = "/add_request";
  static const ADD_DOCTORS = "/add_doctors";
  static const DOCTOR_PROFILE = "/doctor_profile";
  static const SEARCH_REQUEST = "/search_request";
  static const REQUEST_DETAIL = "/request_detail";
  static const REQUEST_VERIFY = "/request_verify";
  static const REQUEST_APPROVE = "/request_Approve";
  static const HOSPITAL_PAYMENT = "/hospital_payment";
  static const UPADTE_PAYMENT_STATUS = "/update_payment_status";
  static const COMPLETED_SURGERY_SCREEN = "/completed_surgery_screen";
  static const CATOGROIES_SCREEN = "/categories_screen";

  static List<GetPage> pages = [
    GetPage(
      binding: AuthBinding(),
      name: LOGIN,
      page: () => const LoginScreen(),
    ),

    GetPage(name: SPLASHSCREEN, page: () => const SplashScreen()),
    GetPage(name: ONBOARDSCREEN, page: () => const OnBoardingScreen()),
    GetPage(
        binding: AuthBinding(), name: LOGIN, page: () => const LoginScreen()),
    GetPage(
        binding: LoginVerificationBinding(),
        name: LOGIN_VERIFICATION,
        page: () => const LoginVerificationScreen()),

    GetPage(
      name: SIGN_UP,
      page: () => const SignupScreen(),
    ),
    GetPage(
      name: EDITPROFILE,
      page: () => const EditProfile(),
    ),
    // GetPage(
    //   name: DOCTORS_LIST,
    //   page: () => const DoctorsListScreen(),
    // ),
    GetPage(
      name: SUCCESFULLYSURGERIESCOMPLETE,
      page: () => const SuccessfullyCompleteSurgeries(),
    ),
    GetPage(
      name: DOCTOR_VIEW,
      page: () => const DoctorViewScreen(),
    ),
    // GetPage(
    //   name: SURGERY_LIST,
    //   page: () => const SurgeryListScreen(),
    // ),
    GetPage(
      name: SURGERY_VIEW_ADMIN,
      page: () => const SurgeryViewScreenAdmin(),
    ),
    GetPage(
      name: SURGERY_VIEW_DOCTOR,
      page: () => const SurgeryViewScreenAdmin(),
    ),

    GetPage(name: NOTIFICATION, page: () => const NotificationScreen()),
    GetPage(name: PROFILE, page: () => const ProfileScreen()),
    GetPage(name: CONTACT_SUPPORT, page: () => ContactSupportScreen()),
    GetPage(name: TERM_CONDITION, page: () => const TermConditionScreen()),
    GetPage(name: FAQ, page: () => const FAQScreen()),
    GetPage(name: APPOINTMENT, page: () => const AppointmentScreen()),
    GetPage(
        name: COMPLETED_SURGERY_SCREEN,
        page: () => const CompletedSurgeryScreen()),
    GetPage(
        name: UPCOMMING_APPOINTMENT_SCREEN,
        page: () => const UpcommingAppointmentScreen()),
    GetPage(name: FORGOT_PASSWORD, page: () => const ForgotPasswordScreen()),
    GetPage(name: ALL_RECORDS, page: () => const AllReocrdsScreen()),
    GetPage(name: REQUEST_VERIFIED_DOC, page: () => VerifiedRequestOfDoc()),
    GetPage(name: REQUEST_VERIFIED_HOS, page: () => VerifiedRequestOfHos()),

    GetPage(name: ALL_APPOINTMENT, page: () => AllAppointment()),
    GetPage(name: ALL_REQUEST, page: () => AllRequestOfDoctor()),
    GetPage(
        name: REQUEST_VERIFICATION_STATUS,
        page: () => const RequestVerificationStatusScreen()),
    GetPage(
        name: REQUEST_VERIFICATION_DETAILS_DOC,
        page: () => const RequestVerificationDetailOfDocScreen()),
    GetPage(
        name: REQUEST_VERIFICATION_DETAILS_HOS,
        page: () => const RequestVerificationDetailOfHosScreen()),

    GetPage(
        name: PAYMENT_PROCESS_SCREEN, page: () => const PaymentProcessScreen()),
    GetPage(name: DASHBOARD, page: () => const Dashboard()),

    // Hospital Routes
    GetPage(name: ADD_REQUEST, page: () => CreateSurgeryRequestScreen()),
    GetPage(name: ADD_DOCTORS, page: () => AddDoctorScreen()),
    GetPage(name: DOCTOR_PROFILE, page: () => const DoctorProfileScreen()),
    GetPage(name: REQUEST_DETAIL, page: () => RequestDetailScreen()),
    GetPage(name: REQUEST_VERIFY, page: () => RequestVerify()),
    GetPage(name: REQUEST_APPROVE, page: () => RequestApproveScreen()),
    GetPage(name: HOSPITAL_PAYMENT, page: () => HospitalPaymentProcessScreen()),
    GetPage(name: HOSPITAL_PAYMENT, page: () => HospitalPaymentProcessScreen()),
    GetPage(name: UPADTE_PAYMENT_STATUS, page: () => UpdatePaymentStatus()),
    GetPage(name: CATOGROIES_SCREEN, page: () => CategoriesScreen()),
  ];
}
