class ApiNetwork {
// BASE URL
  static const String domain = "https://demo4.nrt.co.in";
  static const String baseUrl = "$domain/api/";
  static const String imageUrl = "$domain";
  static const String fileDownloadUrl = "$domain/api/";

  // static const String domain = "192.168.1.22:3333";
  // static const String baseUrl = "http://$domain/api/";
  // static const String imageUrl = "http://$domain/";
  // static const String fileDownloadUrl = "http://$domain/api/";

  // LOGIN
  static const String login = "${baseUrl}login";
  static const String signUp = "${baseUrl}signup";
  static const String loginVerify = "${baseUrl}login/verify";
  static const String forgotPassword = "${baseUrl}login/for got-password";
  static const String chanhePassword = "${baseUrl}change-password";
  static const String users = "${baseUrl}users";
  static const String deleteUsers = "${baseUrl}user/delete/";
  static const String updateUsers = "${baseUrl}user/update";
  static const String logout = "${baseUrl}logout";
  static const String updateProfile = "${baseUrl}update-profile";
  static const String settings = "${baseUrl}settings";
  static const String updateSettings = "${baseUrl}settings/update";

  // HOSPITAL
  static const String hospital = "${baseUrl}hospitals";
  static const String createHospital = "${baseUrl}hospital/create";
  static const String updateHospital = "${baseUrl}hospital/update/";
  static const String doctorsSpecialization =
      "${baseUrl}doctors-specialization";
  static const String doctorsList = "${baseUrl}doctor-list";
  static const String createDoctor = "${baseUrl}doctor-create";
  static const String categoryList = "${baseUrl}categories";
  static const String sendRequest = "${baseUrl}request";
  static const String getRequest = "${baseUrl}requests";
  static const String getRequestSendedToDoctor = "${baseUrl}oppointments";
  static const String getUpcommingAppointment = "${baseUrl}upcoming-oppointments";

  //Doctor
  static const String appointmentAction = "${baseUrl}oppointment/action/";
  static const String appointmentMode = "${baseUrl}oppointment/mode/";

  // TREATMENT
  static const String treatment = "${baseUrl}teatments";
  static const String createTreatment = "${baseUrl}teatment/create";
  static const String updateTreatment = "${baseUrl}teatment/update/";

  // Global
  static const String notification = "${baseUrl}notifications";
  static const String myNotification = "${baseUrl}my-notification";
  static const String readNotification = "${baseUrl}notification/read/";
  static const String readAllNotification = "${baseUrl}notifications";
}
