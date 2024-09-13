 import '../../../../../../core/constants/app_export.dart';

void initializeControllers() {
    category = List.generate(
      fieldList.length,
      (index) => TextEditingController(text: fieldList[index]['category_id']),
    );
    amount = List.generate(
      fieldList.length,
      (index) => TextEditingController(text: fieldList[index]['amount']),
    );
    totalNumberOfDrs = List.generate(
      fieldList.length,
      (index) => TextEditingController(
          text: fieldList[index]['no_of_doctors']!.isEmpty
              ? '1'
              : fieldList[index]['no_of_doctors']),
    );
    tittle = List.generate(
      fieldList.length,
      (index) => TextEditingController(text: fieldList[index]['title']),
    );
    patientEmail = List.generate(
      fieldList.length,
      (index) => TextEditingController(text: fieldList[index]['patient_email']),
    );
    patientPhone = List.generate(
      fieldList.length,
      (index) => TextEditingController(text: fieldList[index]['patient_phone']),
    );
    patientName = List.generate(
      fieldList.length,
      (index) => TextEditingController(text: fieldList[index]['patient_name']),
    );
    patientAge = List.generate(
      fieldList.length,
      (index) => TextEditingController(text: fieldList[index]['patient_age']),
    );
    surgeryDate = List.generate(
      fieldList.length,
      (index) => TextEditingController(text: fieldList[index]['surgery_date']),
    );
    startTime = List.generate(
      fieldList.length,
      (index) => TextEditingController(text: fieldList[index]['start_time']),
    );
    endTime = List.generate(
      fieldList.length,
      (index) => TextEditingController(text: fieldList[index]['end_time']),
    );
    description = List.generate(
      fieldList.length,
      (index) => TextEditingController(text: fieldList[index]['description']),
    );
  }

  

 



  late List<TextEditingController> category;
  late List<TextEditingController> amount;
  late List<TextEditingController> totalNumberOfDrs;
  late List<TextEditingController> tittle;
  late List<TextEditingController> patientName;
  late List<TextEditingController> patientEmail;
  late List<TextEditingController> patientPhone;
  late List<TextEditingController> patientAge;
  late List<TextEditingController> surgeryDate;
  late List<TextEditingController> startTime;
  late List<TextEditingController> endTime;
  late List<TextEditingController> description;
  List<Map<String, String>> fieldList = [
    {
      "title": "",
      "category_id": '',
      "description": "",
      "amount": "",
      "no_of_doctors": "1",
      "patient_name": "",
      "patient_age": "",
      "patient_email": "",
      "patient_phone": "",
      "hospital_id": SessionManager.getUserTypeId(),
      "status": "",
      "surgery_date": "",
      "start_time": "",
      "end_time": "",
    },
  ];
