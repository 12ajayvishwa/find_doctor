// ignore_for_file: unnecessary_this

class SendRequestModel {
  int? id;
  int? amount;
  int? noOfDoctors;
  String? title;
  String? patientName;
  String? patientAge;
  String? patientEmail;
  String? patientPhone;
  String? description;
  String? status;
  int? hospitalId;
  int? categoryId;
  int? doctorId;
  String? isAllowAlternateDoctor;
  String? startTime;
  String? endTime;
  dynamic surgeryDate;
  String? deletedAt;
  String? createdAt;
  String? updatedAt;
  Hospital? hospital;

  SendRequestModel(
      {this.id,
      this.amount,
      this.noOfDoctors,
      this.title,
      this.patientName,
      this.patientAge,
      this.patientEmail,
      this.patientPhone,
      this.description,
      this.status,
      this.hospitalId,
      this.categoryId,
      this.doctorId,
      this.isAllowAlternateDoctor,
      this.startTime,
      this.endTime,
      this.surgeryDate,
      this.deletedAt,
      this.createdAt,
      this.updatedAt,
      this.hospital});

  SendRequestModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    amount = json['amount'];
    noOfDoctors = json['no_of_doctors'];
    title = json['title'];
    patientName = json['patient_name'];
    patientAge = json['patient_age'];
    patientEmail = json['patient_email'];
    patientPhone = json['patient_phone'];
    description = json['description'];
    status = json['status'];
    hospitalId = json['hospital_id'];
    categoryId = json['category_id'];
    doctorId = json['doctor_id'];
    isAllowAlternateDoctor = json['is_allow_alternate_doctor'];
    startTime = json['start_time'];
    endTime = json['end_time'];
    surgeryDate = json['surgery_date'];
    deletedAt = json['deleted_at'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    hospital = json['hospital'] != null
        ? new Hospital.fromJson(json['hospital'])
        : null;
  }
  static List<SendRequestModel> listFromJson(List<dynamic> json) {
    return json.map((e) => SendRequestModel.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['amount'] = this.amount;
    data['no_of_doctors'] = this.noOfDoctors;
    data['title'] = this.title;
    data['patient_name'] = this.patientName;
    data['patient_age'] = this.patientAge;
    data['patient_email'] = this.patientEmail;
    data['patient_phone'] = this.patientPhone;
    data['description'] = this.description;
    data['status'] = this.status;
    data['hospital_id'] = this.hospitalId;
    data['category_id'] = this.categoryId;
    data['doctor_id'] = this.doctorId;
    data['is_allow_alternate_doctor'] = this.isAllowAlternateDoctor;
    data['start_time'] = this.startTime;
    data['end_time'] = this.endTime;
    data['surgery_date'] = this.surgeryDate;
    data['deleted_at'] = this.deletedAt;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    if (this.hospital != null) {
      data['hospital'] = this.hospital!.toJson();
    }
    return data;
  }
}

class Hospital {
  int? id;
  String? name;
  String? email;
  String? phone;
  String? registrationNo;
  String? slug;
  String? description;
  String? userTypeId;
  int? hospitalId;
  int? specializationId;
  String? address;
  int? experience;
  dynamic? verified;
  dynamic? gender;
  dynamic? avatar;
  int? active;
  String? role;
  String? locale;
  String? accountType;
  dynamic? rememberMeToken;
  String? createdAt;
  String? updatedAt;
  String? deletedAt;
  int? invalidLoginAttempts;

  Hospital(
      {this.id,
      this.name,
      this.email,
      this.phone,
      this.registrationNo,
      this.slug,
      this.description,
      this.userTypeId,
      this.hospitalId,
      this.specializationId,
      this.address,
      this.experience,
      this.verified,
      this.gender,
      this.avatar,
      this.active,
      this.role,
      this.locale,
      this.accountType,
      this.rememberMeToken,
      this.createdAt,
      this.updatedAt,
      this.deletedAt,
      this.invalidLoginAttempts});

  Hospital.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    phone = json['phone'];
    registrationNo = json['registration_no'];
    slug = json['slug'];
    description = json['description'];
    userTypeId = json['user_type_id'];
    hospitalId = json['hospital_id'];
    specializationId = json['specialization_id'];
    address = json['address'];
    experience = json['experience'];
    verified = json['verified'];
    gender = json['gender'];
    avatar = json['avatar'];
    active = json['active'];
    role = json['role'];
    locale = json['locale'];
    accountType = json['account_type'];
    rememberMeToken = json['remember_me_token'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    deletedAt = json['deleted_at'];
    invalidLoginAttempts = json['invalid_login_attempts'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['email'] = this.email;
    data['phone'] = this.phone;
    data['registration_no'] = this.registrationNo;
    data['slug'] = this.slug;
    data['description'] = this.description;
    data['user_type_id'] = this.userTypeId;
    data['hospital_id'] = this.hospitalId;
    data['specialization_id'] = this.specializationId;
    data['address'] = this.address;
    data['experience'] = this.experience;
    data['verified'] = this.verified;
    data['gender'] = this.gender;
    data['avatar'] = this.avatar;
    data['active'] = this.active;
    data['role'] = this.role;
    data['locale'] = this.locale;
    data['account_type'] = this.accountType;
    data['remember_me_token'] = this.rememberMeToken;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['deleted_at'] = this.deletedAt;
    data['invalid_login_attempts'] = this.invalidLoginAttempts;
    return data;
  }
}
