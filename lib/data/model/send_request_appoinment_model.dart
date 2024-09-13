// To parse this JSON data, do
//
//     final sendRequestAppoinmentModel = sendRequestAppoinmentModelFromJson(jsonString);

import 'dart:convert';

SendRequestAppoinmentModel sendRequestAppoinmentModelFromJson(String str) => SendRequestAppoinmentModel.fromJson(json.decode(str));

String sendRequestAppoinmentModelToJson(SendRequestAppoinmentModel data) => json.encode(data.toJson());

class SendRequestAppoinmentModel {
    final int? id;
    final int? requestId;
    final int? doctorId;
    final String? status;
    final String? statusMode;
    final String? description;
    final int? isPrimary;
    final dynamic deletedAt;
    final DateTime? createdAt;
    final DateTime? updatedAt;
    final Request? request;
    final Doctor? doctor;

    SendRequestAppoinmentModel({
        this.id,
        this.requestId,
        this.doctorId,
        this.status,
        this.statusMode,
        this.description,
        this.isPrimary,
        this.deletedAt,
        this.createdAt,
        this.updatedAt,
        this.request,
        this.doctor,
    });

    factory SendRequestAppoinmentModel.fromJson(Map<String, dynamic> json) => SendRequestAppoinmentModel(
        id: json["id"],
        requestId: json["request_id"],
        doctorId: json["doctor_id"],
        status: json["status"],
        statusMode: json["status_mode"],
        description: json["description"],
        isPrimary: json["is_primary"],
        deletedAt: json["deleted_at"],
        createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
        request: json["request"] == null ? null : Request.fromJson(json["request"]),
        doctor: json["doctor"] == null ? null : Doctor.fromJson(json["doctor"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "request_id": requestId,
        "doctor_id": doctorId,
        "status": status,
        "status_mode": statusMode,
        "description": description,
        "is_primary": isPrimary,
        "deleted_at": deletedAt,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "request": request?.toJson(),
        "doctor": doctor?.toJson(),
    };
}

class Doctor {
    final int? id;
    final String? name;
    final String? email;
    final String? phone;
    final String? registrationNo;
    final String? slug;
    final dynamic description;
    final String? userTypeId;
    final int? hospitalId;
    final int? specializationId;
    final String? address;
    final dynamic experience;
    final dynamic verified;
    final String? gender;
    final dynamic avatar;
    final int? active;
    final String? role;
    final String? fcmToken;
    final String? locale;
    final String? accountType;
    final dynamic rememberMeToken;
    final DateTime? createdAt;
    final DateTime? updatedAt;
    final dynamic deletedAt;
    final int? invalidLoginAttempts;
    final Specialization? specialization;

    Doctor({
        this.id,
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
        this.fcmToken,
        this.locale,
        this.accountType,
        this.rememberMeToken,
        this.createdAt,
        this.updatedAt,
        this.deletedAt,
        this.invalidLoginAttempts,
        this.specialization,
    });

    factory Doctor.fromJson(Map<String, dynamic> json) => Doctor(
        id: json["id"],
        name: json["name"],
        email: json["email"],
        phone: json["phone"],
        registrationNo: json["registration_no"],
        slug: json["slug"],
        description: json["description"],
        userTypeId: json["user_type_id"],
        hospitalId: json["hospital_id"],
        specializationId: json["specialization_id"],
        address: json["address"],
        experience: json["experience"],
        verified: json["verified"],
        gender: json["gender"],
        avatar: json["avatar"],
        active: json["active"],
        role: json["role"],
        fcmToken: json["fcm_token"],
        locale: json["locale"],
        accountType: json["account_type"],
        rememberMeToken: json["remember_me_token"],
        createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
        deletedAt: json["deleted_at"],
        invalidLoginAttempts: json["invalid_login_attempts"],
        specialization: json["specialization"] == null ? null : Specialization.fromJson(json["specialization"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "email": email,
        "phone": phone,
        "registration_no": registrationNo,
        "slug": slug,
        "description": description,
        "user_type_id": userTypeId,
        "hospital_id": hospitalId,
        "specialization_id": specializationId,
        "address": address,
        "experience": experience,
        "verified": verified,
        "gender": gender,
        "avatar": avatar,
        "active": active,
        "role": role,
        "fcm_token": fcmToken,
        "locale": locale,
        "account_type": accountType,
        "remember_me_token": rememberMeToken,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "deleted_at": deletedAt,
        "invalid_login_attempts": invalidLoginAttempts,
        "specialization": specialization?.toJson(),
    };
}

class Specialization {
    final int? id;
    final String? name;
    final String? description;
    final String? icon;
    final DateTime? createdAt;
    final DateTime? updatedAt;
    final dynamic deletedAt;

    Specialization({
        this.id,
        this.name,
        this.description,
        this.icon,
        this.createdAt,
        this.updatedAt,
        this.deletedAt,
    });

    factory Specialization.fromJson(Map<String, dynamic> json) => Specialization(
        id: json["id"],
        name: json["name"],
        description: json["description"],
        icon: json["icon"],
        createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
        deletedAt: json["deleted_at"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "description": description,
        "icon": icon,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "deleted_at": deletedAt,
    };
}

class Request {
    final int? id;
    final int? amount;
    final int? noOfDoctors;
    final String? title;
    final String? patientName;
    final String? patientAge;
    final String? patientEmail;
    final String? patientPhone;
    final String? description;
    final String? status;
    final int? hospitalId;
    final int? categoryId;
    final dynamic doctorId;
    final String? isAllowAlternateDoctor;
    final String? startTime;
    final String? endTime;
    final DateTime? surgeryDate;
    final dynamic deletedAt;
    final DateTime? createdAt;
    final DateTime? updatedAt;
    final Doctor? hospital;

    Request({
        this.id,
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
        this.hospital,
    });

    factory Request.fromJson(Map<String, dynamic> json) => Request(
        id: json["id"],
        amount: json["amount"],
        noOfDoctors: json["no_of_doctors"],
        title: json["title"],
        patientName: json["patient_name"],
        patientAge: json["patient_age"],
        patientEmail: json["patient_email"],
        patientPhone: json["patient_phone"],
        description: json["description"],
        status: json["status"],
        hospitalId: json["hospital_id"],
        categoryId: json["category_id"],
        doctorId: json["doctor_id"],
        isAllowAlternateDoctor: json["is_allow_alternate_doctor"],
        startTime: json["start_time"],
        endTime: json["end_time"],
        surgeryDate: json["surgery_date"] == null ? null : DateTime.parse(json["surgery_date"]),
        deletedAt: json["deleted_at"],
        createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
        hospital: json["hospital"] == null ? null : Doctor.fromJson(json["hospital"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "amount": amount,
        "no_of_doctors": noOfDoctors,
        "title": title,
        "patient_name": patientName,
        "patient_age": patientAge,
        "patient_email": patientEmail,
        "patient_phone": patientPhone,
        "description": description,
        "status": status,
        "hospital_id": hospitalId,
        "category_id": categoryId,
        "doctor_id": doctorId,
        "is_allow_alternate_doctor": isAllowAlternateDoctor,
        "start_time": startTime,
        "end_time": endTime,
        "surgery_date": surgeryDate?.toIso8601String(),
        "deleted_at": deletedAt,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "hospital": hospital?.toJson(),
    };
}
