class DoctorsModel {
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
  int? verified;
  String? gender;
  dynamic? avatar;
  int? active;
  dynamic? role;
  String? locale;
  String? accountType;
  dynamic? rememberMeToken;
  String? createdAt;
  String? updatedAt;
  String? deletedAt;
  int? invalidLoginAttempts;
  Specialization? specialization;

  DoctorsModel(
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

  DoctorsModel.fromJson(Map<String, dynamic> json) {
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
        ?  Specialization.fromJson(json['specialization'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  Map<String, dynamic>();
    data['id'] = id;
    data['name'] = name;
    data['email'] = email;
    data['phone'] = phone;
    data['registration_no'] = registrationNo;
    data['slug'] = slug;
    data['description'] = description;
    data['user_type_id'] = userTypeId;
    data['hospital_id'] = hospitalId;
    data['specialization_id'] = specializationId;
    data['address'] = address;
    data['experience'] = experience;
    data['verified'] = verified;
    data['gender'] = gender;
    data['avatar'] = avatar;
    data['active'] = active;
    data['role'] = role;
    data['locale'] = locale;
    data['account_type'] = accountType;
    data['remember_me_token'] = rememberMeToken;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['deleted_at'] = deletedAt;
    data['invalid_login_attempts'] = invalidLoginAttempts;
    if (specialization != null) {
      data['specialization'] = specialization!.toJson();
    }
    return data;
  }
}

class Specialization {
  int? id;
  String? name;
  String? description;
  dynamic icon;
  String? createdAt;
  String? updatedAt;
  dynamic deletedAt;

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
    final Map<String, dynamic> data =  Map<String, dynamic>();
    data['id'] = id;
    data['name'] = name;
    data['description'] = description;
    data['icon'] = icon;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['deleted_at'] = deletedAt;
    return data;
  }
}
