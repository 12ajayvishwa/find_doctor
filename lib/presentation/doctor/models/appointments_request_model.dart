class AppointmentRequestModel {
  int? id;
  int? requestId;
  int? doctorId;
  String? status;
  String? deletedAt;
  String? createdAt;
  String? updatedAt;
  Request? request;
  Doctor? doctor;

  AppointmentRequestModel(
      {this.id,
      this.requestId,
      this.doctorId,
      this.status,
      this.deletedAt,
      this.createdAt,
      this.updatedAt,
      this.request,
      this.doctor});

  AppointmentRequestModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    requestId = json['request_id'];
    doctorId = json['doctor_id'];
    status = json['status'];
    deletedAt = json['deleted_at'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    request =
        json['request'] != null ? new Request.fromJson(json['request']) : null;
    doctor =
        json['doctor'] != null ? new Doctor.fromJson(json['doctor']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['request_id'] = this.requestId;
    data['doctor_id'] = this.doctorId;
    data['status'] = this.status;
    data['deleted_at'] = this.deletedAt;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    if (this.request != null) {
      data['request'] = this.request!.toJson();
    }
    if (this.doctor != null) {
      data['doctor'] = this.doctor!.toJson();
    }
    return data;
  }
}

class Request {
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
  String? surgeryDate;
  String? deletedAt;
  String? createdAt;
  String? updatedAt;
  Hospital? hospital;

  Request(
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

  Request.fromJson(Map<String, dynamic> json) {
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
  dynamic? experience;
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

class Doctor {
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
  dynamic? experience;
  dynamic? verified;
  String? gender;
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
  Specialization? specialization;

  Doctor(
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
      this.invalidLoginAttempts,
      this.specialization});

  Doctor.fromJson(Map<String, dynamic> json) {
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
    specialization = json['specialization'] != null
        ? new Specialization.fromJson(json['specialization'])
        : null;
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
    if (this.specialization != null) {
      data['specialization'] = this.specialization!.toJson();
    }
    return data;
  }
}

class Specialization {
  int? id;
  String? name;
  String? description;
  dynamic? icon;
  String? createdAt;
  String? updatedAt;
  dynamic? deletedAt;

  Specialization(
      {this.id,
      this.name,
      this.description,
      this.icon,
      this.createdAt,
      this.updatedAt,
      this.deletedAt});

  Specialization.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    description = json['description'];
    icon = json['icon'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    deletedAt = json['deleted_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['description'] = this.description;
    data['icon'] = this.icon;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['deleted_at'] = this.deletedAt;
    return data;
  }
}
