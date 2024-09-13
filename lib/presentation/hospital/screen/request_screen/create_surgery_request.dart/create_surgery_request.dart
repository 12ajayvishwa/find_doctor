import 'package:find_doctor/utils/validation_functions.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../../../../../core/constants/app_export.dart';
// ignore: depend_on_referenced_packages
import 'package:intl/intl.dart';
import '../../../../../utils/custom_toast.dart';
import 'components/create_surgery_component.dart';
import 'components/create_surgery_functions_controller.dart';

class CreateSurgeryRequestScreen extends StatefulWidget {
  const CreateSurgeryRequestScreen({super.key});

  @override
  State<CreateSurgeryRequestScreen> createState() =>
      _CreateSurgeryRequestScreenState();
}

class _CreateSurgeryRequestScreenState extends State<CreateSurgeryRequestScreen>
    with TickerProviderStateMixin {
  // HospitalController hospitalController = Get.put(HospitalController());
  RequestController requestController = Get.put(RequestController());
  AuthController authController = Get.put(AuthController());
  DateTimePickerController dateTimePickerController =
      Get.put(DateTimePickerController());
  CreateSurgeryFunctionController createSurgeryFunctionController =
      Get.put(CreateSurgeryFunctionController());
  late TabController tabController;
  List<dynamic> categoryList = [];
  List<dynamic> categoryIdList = [];
  String value = "";
  final formKey = GlobalKey<FormState>();
  var _user;
  void increment(int index) {
    int currentValue = int.tryParse(totalNumberOfDrs[index].text) ?? 0;
    currentValue++;
    totalNumberOfDrs[index].text = currentValue.toString();
    handleChange(index, 'no_of_doctors', currentValue.toString());
  }

  void decrement(int index) {
    int currentValue = int.tryParse(totalNumberOfDrs[index].text) ?? 0;
    if (currentValue > 0) {
      currentValue--;
      totalNumberOfDrs[index].text = currentValue.toString();
      handleChange(index, 'no_of_doctors', currentValue.toString());
    }
  }

  void handleChange(int index, String field, String value) {
    setState(() {
      fieldList[index][field] = value;
    });
  }

  void handleRemoveFields(int index) {
    if (fieldList.length > 1) {
      setState(() {
        fieldList.removeAt(index);
        amount.removeAt(index);
        totalNumberOfDrs.removeAt(index);
        tittle.removeAt(index);
        patientEmail.removeAt(index);
        patientPhone.removeAt(index);
        patientName.removeAt(index);
        patientAge.removeAt(index);
        surgeryDate.removeAt(index);
        startTime.removeAt(index);
        endTime.removeAt(index);
        description.removeAt(index);
      });
    }
  }

  void handleAddFields() {
    setState(() {
      fieldList.add({
        'title': '',
        "category_id": '',
        'description': '',
        'amount': '',
        'no_of_doctors': '1',
        'patient_name': '',
        'patient_age': '',
        'patient_email': "",
        'patient_phone': "",
        'surgery_date': '',
        "hospital_id": SessionManager.getUserTypeId(),
        'start_time': '',
        'end_time': ''
      });
      amount.add(TextEditingController());
      totalNumberOfDrs.add(TextEditingController());
      tittle.add(TextEditingController());
      patientEmail.add(TextEditingController());
      patientPhone.add(TextEditingController());
      patientName.add(TextEditingController());
      patientAge.add(TextEditingController());
      surgeryDate.add(TextEditingController());
      startTime.add(TextEditingController());
      endTime.add(TextEditingController());
      description.add(TextEditingController());
    });
  }

  @override
  void initState() {
    toast.init(context);
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      resetFields();
      authController.getSpecialization();
    });
    _user = json.decode(SessionManager.getUser().toString());
    initializeTabController();
    initializeControllers();
    super.initState();
  }

  void handleSave() {
    for (int i = 0; i < fieldList.length; i++) {
      if (i < categoryList.length) {
        fieldList[i]["category_id"] = categoryIdList[i].toString();
      }
    }
    print(fieldList);
    if (formKey.currentState!.validate()) {
      requestController.sendRequest(fieldList);
    }
  }

  void resetFields() {
    setState(() {
      fieldList.clear();
      amount.clear();
      
      tittle.clear();
      patientEmail.clear();
      patientPhone.clear();
      patientName.clear();
      patientAge.clear();
      surgeryDate.clear();
      startTime.clear();
      endTime.clear();
      description.clear();

      // Add an initial empty field
      handleAddFields();
    });
  }

  void initializeTabController() {
    tabController = TabController(length: categoryList.length, vsync: this);
  }

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (categoryList.isNotEmpty &&
        (tabController == null ||
            tabController.length != categoryList.length)) {
      initializeTabController();
    }
    Size size = MediaQuery.of(context).size;

    return Scaffold(body: Obx(() {
      return CustomScrollView(
          physics: categoryList.isEmpty
              ? const NeverScrollableScrollPhysics()
              : const AlwaysScrollableScrollPhysics(),
          slivers: [
            SliverAppBar(
              title: Text(
                "Create Surgery Request",
                style: AppTextStyles.text16Black600
                    .copyWith(fontWeight: FontWeight.w700, fontSize: 20.sp),
              ),
              centerTitle: true,
              backgroundColor: Colors.white,
              expandedHeight: 400.h,
              // collapsedHeight: 70.h,
              pinned: true,
              snap: false,
              flexibleSpace: FlexibleSpaceBar(
                // collapseMode: CollapseMode.parallax,
                background: Container(
                  decoration: BoxDecoration(
                      gradient: LinearGradient(
                          colors: [
                            AppColors.green600.withOpacity(0.8),
                            AppColors.whiteA700.withOpacity(0.8),
                          ],
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          stops: const [0.5, 3.0]),
                      borderRadius: BorderRadius.only(
                          bottomRight: Radius.circular(165.r))),
                  child: Stack(children: [
                    Positioned(
                      top: 0.h,
                      right: 0.w,
                      child: Image.asset("assets/images/bload cell.png"),
                    ),
                    Positioned(
                      top: 0.h,
                      left: 0.w,
                      child: SvgPicture.asset("assets/icons/elips_circle.svg"),
                    ),
                    Positioned(
                      bottom: -180.h,
                      left: 0.w,
                      child: Image.asset("assets/images/dna.png"),
                    ),
                    Positioned(
                      top: 150.h,
                      left: 30.w,
                      right: 30.w,
                      child: Container(
                        height: 160.h,
                        width: double.infinity,
                        decoration: BoxDecoration(
                            color: AppColors.whiteA700,
                            borderRadius: BorderRadius.circular(10.r),
                            gradient: AppGradient.kContainerGradient(),
                            boxShadow: [
                              BoxShadow(
                                  blurRadius: 30,
                                  offset: Offset(0, 10.w),
                                  spreadRadius: 5,
                                  color: Colors.white.withOpacity(0.8))
                            ]),
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              SizedBox(
                                width: 180.w,
                                child: Text(
                                    _user['name'].toString().capitalizeFirst!,
                                    textAlign: TextAlign.center,
                                    style: AppTextStyles.headline.copyWith(
                                        color: AppColors.kprimary,
                                        fontSize: 18.sp)),
                              ),
                              SizedBox(height: 10.h),
                              SizedBox(
                                width: 180.w,
                                child: Text(
                                  "We provide best quality medical\nservices without further cost",
                                  style: AppTextStyles.text9black400,
                                  textAlign: TextAlign.center,
                                ),
                              )
                            ]),
                      ),
                    ),
                    Positioned(
                      bottom: 0,
                      left: 20.w,
                      child: Container(
                          padding: EdgeInsets.all(8.sp),
                          decoration: BoxDecoration(
                              color: AppColors.whiteA700,
                              borderRadius: BorderRadius.circular(19.r),
                              border: Border.all(color: AppColors.gray)),
                          child: Image.asset("assets/images/hospital1.png")),
                    ),
                    Positioned(
                      top: 120.h,
                      right: 40.w,
                      child: Image.asset(
                        "assets/images/add_request_doc.png",
                        height: 200.h,
                        width: 180.w,
                      ),
                    ),
                  ]),
                ),
              ),
            ),
            SliverToBoxAdapter(
                child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
              child: Column(children: [
                CustomDropdown(
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16.r),
                      borderSide:
                          BorderSide(color: AppColors.kprimary, width: 1)),
                  isMultiselect: true,
                  labelText: "Category",
                  validator: (p0) {
                    if (p0 == null) {
                      return "Specialization is required.";
                    }
                    return null;
                  },
                  listName: authController.specializationList
                      .map(
                        (e) => e.name!,
                      )
                      .toList(),
                  hintText: "Select Category",
                  onChanged: (p0) {
                    List catId = [];
                    List<Map<String, String>> updatedFieldList =
                        List.from(fieldList);
                    categoryIdList.clear();
                    // Adjust the number of fields based on the number of selected categories
                    if (p0.length > updatedFieldList.length) {
                      for (var i = updatedFieldList.length;
                          i < p0.length;
                          i++) {
                        updatedFieldList.add({
                          "title": "",
                          "category_id": '',
                          "description": "",
                          "amount": "",
                          "no_of_doctors": "1",
                          "patient_name": "",
                          "patient_age": "",
                          "patient_email": "",
                          "patient_phone": "",
                          "status": "",
                          "hospital_id": SessionManager.getUserTypeId(),
                          "surgery_date": "",
                          "start_time": "",
                          "end_time": ""
                        });
                      }
                    } else if (p0.length < updatedFieldList.length) {
                      updatedFieldList = updatedFieldList.sublist(0, p0.length);
                    }

                    // ignore: unused_local_variable
                    for (var i = 1; i <= p0.length; i++) {
                      if (i > 1) {
                        handleAddFields();
                      }
                    }
                    for (var i in authController.specializationList) {
                      if (p0.contains(i.name)) {
                        catId.add(i.id);
                        categoryIdList = catId;
                        //  handleChange(index, 'category_id', i.id.toString());
                      }
                    }
                    setState(() {
                      categoryList = p0;
                      fieldList = updatedFieldList;
                    });
                  },
                ),
                SizedBox(
                  height: 10.h,
                ),
                categoryList.isNotEmpty
                    ? TabBar(
                        controller: tabController,
                        isScrollable: true,
                        indicatorSize: TabBarIndicatorSize.tab,
                        tabAlignment: TabAlignment.start,
                        indicator: BoxDecoration(
                          color: AppColors.green600.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(16.r),
                        ),
                        labelStyle: AppTextStyles.bodyText
                            .copyWith(color: AppColors.green600),
                        dividerColor: Colors.transparent,
                        tabs: categoryList.map((category) {
                          return Tab(
                            child: SizedBox(
                              width: 150.w,
                              child: Text(
                                category,
                                textAlign: TextAlign.center,
                              ),
                            ),
                          );
                        }).toList(),
                      )
                    : Container(),
                SizedBox(
                  height: categoryList.isEmpty
                      ? size.height / 2.5
                      : size.height / 1.6,
                  width: size.width / 0.4,
                  child: categoryList.isEmpty
                      ? Container()
                      : Form(
                          key: formKey,
                          child: TabBarView(
                              physics: const NeverScrollableScrollPhysics(),
                              controller: tabController,
                              children: [
                                ...fieldList.asMap().entries.map((e) {
                                  int index = e.key;
                                  return SingleChildScrollView(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        CustomTextFormField(
                                          labelText: "Amount",
                                          hintText: "Enter amount",
                                          controller: amount[index],
                                          onChanged: (p0) =>
                                              handleChange(index, 'amount', p0),
                                          borderDecoration: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(16.r),
                                              borderSide: BorderSide(
                                                  color: AppColors.kprimary,
                                                  width: 1)),
                                          inputFormatters: [
                                            FilteringTextInputFormatter
                                                .digitsOnly,
                                          ],
                                          textInputType: TextInputType.number,
                                          validator: (value) {
                                            if (value!.isEmpty) {
                                              return "Please enter amount";
                                            }
                                            return null;
                                          },
                                        ),
                                        SizedBox(
                                          height: 10.h,
                                        ),
                                        CustomTextFormField(
                                          labelText: "Title",
                                          hintText: "Enter title",
                                          controller: tittle[index],
                                          onChanged: (p0) {
                                            handleChange(index, 'title', p0);
                                          },
                                          textInputType: TextInputType.text,
                                          borderDecoration: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(16.r),
                                              borderSide: BorderSide(
                                                  color: AppColors.kprimary,
                                                  width: 1)),
                                          validator: (value) {
                                            if (value!.isEmpty) {
                                              return "Please enter title";
                                            }
                                            return null;
                                          },
                                        ),
                                        SizedBox(
                                          height: 10.h,
                                        ),
                                        CustomTextFormField(
                                          labelText: "Patient Name",
                                          hintText: "Enter patient name",
                                          controller: patientName[index],
                                          onChanged: (p0) {
                                            handleChange(
                                                index, 'patient_name', p0);
                                          },
                                          borderDecoration: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(16.r),
                                              borderSide: BorderSide(
                                                  color: AppColors.kprimary,
                                                  width: 1)),
                                          textInputType: TextInputType.text,
                                          validator: (value) {
                                            if (value!.isEmpty) {
                                              return "Please enter patient name";
                                            }
                                            return null;
                                          },
                                        ),
                                        SizedBox(
                                          height: 10.h,
                                        ),
                                        CustomTextFormField(
                                            labelText: "Patient Age",
                                            hintText: "Enter patient age",
                                            controller: patientAge[index],
                                            // textInputType: TextInputType.text,
                                            onChanged: (p0) {
                                              handleChange(
                                                  index, 'patient_age', p0);
                                            },
                                            inputFormatters: [
                                              FilteringTextInputFormatter
                                                  .digitsOnly,
                                            ],
                                            textInputType: TextInputType.number,
                                            borderDecoration:
                                                OutlineInputBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            16.r),
                                                    borderSide: BorderSide(
                                                        color:
                                                            AppColors.kprimary,
                                                        width: 1)),
                                            validator: validateAge),
                                        SizedBox(
                                          height: 10.h,
                                        ),
                                        CustomTextFormField(
                                          labelText: "Patient Email",
                                          hintText: "Enter patient email",
                                          controller: patientEmail[index],
                                          // textInputType: TextInputType.text,
                                          onChanged: (p0) {
                                            handleChange(
                                                index, 'patient_email', p0);
                                          },
                                          borderDecoration: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(16.r),
                                              borderSide: BorderSide(
                                                  color: AppColors.kprimary,
                                                  width: 1)),
                                          // validator: emailValidator
                                        ),
                                        SizedBox(
                                          height: 10.h,
                                        ),
                                        CustomTextFormField(
                                            labelText: "Patient phone",
                                            hintText: "Enter patient phone",
                                            controller: patientPhone[index],
                                            // textInputType: TextInputType.text,
                                            onChanged: (p0) {
                                              handleChange(
                                                  index, 'patient_phone', p0);
                                            },
                                            inputFormatters: [
                                              FilteringTextInputFormatter
                                                  .digitsOnly,
                                            ],
                                            maxLength: 10,
                                            textInputType: TextInputType.number,
                                            borderDecoration:
                                                OutlineInputBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            16.r),
                                                    borderSide: BorderSide(
                                                        color:
                                                            AppColors.kprimary,
                                                        width: 1)),
                                            validator: phoneNumberValidator),
                                        SizedBox(
                                          height: 10.h,
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            SizedBox(
                                              width: 130.w,
                                              child: CustomTextFormField(
                                                  labelText:
                                                      "Total No. of Drs ",
                                                  hintText: "0",
                                                  readOnly: true,
                                                  controller:
                                                      totalNumberOfDrs[index],
                                                  prefix: IconButton(
                                                      onPressed: () =>
                                                          decrement(index),
                                                      icon: Icon(
                                                        Icons.remove,
                                                        color:
                                                            AppColors.red600D8,
                                                      )),
                                                  suffix: IconButton(
                                                    onPressed: () =>
                                                        increment(index),
                                                    icon: Icon(
                                                      Icons.add,
                                                      color: AppColors.green600,
                                                    ),
                                                  ),
                                                  onChanged: (p0) {
                                                    print(p0);
                                                    handleChange(index,
                                                        'no_of_doctors', p0);
                                                  },
                                                  borderDecoration:
                                                      OutlineInputBorder(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(16
                                                                      .r),
                                                          borderSide: BorderSide(
                                                              color: AppColors
                                                                  .kprimary,
                                                              width: 1)),
                                                  inputFormatters: [
                                                    FilteringTextInputFormatter
                                                        .digitsOnly,
                                                  ],
                                                  textInputType:
                                                      TextInputType.number,
                                                  validator: validateNumber),
                                            ),
                                            SizedBox(
                                              width: 240.w,
                                              child: CustomTextFormField(
                                                labelText:
                                                    "Surgery Date & Time",
                                                hintText:
                                                    "Enter surgery date & time",
                                                controller: surgeryDate[index],
                                                onChanged: (p0) {
                                                  handleChange(index,
                                                      'surgery_date', p0);
                                                },
                                                borderDecoration:
                                                    OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          16.r),
                                                  borderSide: BorderSide(
                                                      color: AppColors.kprimary,
                                                      width: 1),
                                                ),
                                                onTap: () async {
                                                  DateTime? selectedDate =
                                                      await showDatePicker(
                                                    context: context,
                                                    initialDate: DateTime.now(),
                                                    firstDate: DateTime(2000),
                                                    lastDate: DateTime(2100),
                                                    builder: (context, child) {
                                                      return calenderTheme(
                                                          child, context);
                                                    },
                                                  );
                                                  if (selectedDate != null) {
                                                    String formattedDate =
                                                        DateFormat('dd/MM/yyyy')
                                                            .format(
                                                                selectedDate);
                                                    String sendFormattedDate =
                                                        DateFormat('yyyy-MM-dd')
                                                            .format(
                                                                selectedDate);
                                                    surgeryDate[index].text =
                                                        formattedDate;
                                                    handleChange(
                                                        index,
                                                        'surgery_date',
                                                        sendFormattedDate);
                                                  } 
                                                },
                                                readOnly: true,
                                                textInputType:
                                                    TextInputType.text,
                                                validator: (value) {
                                                  if (value!.isEmpty) {
                                                    return "Enter surgery date";
                                                  }
                                                  // Parse the date from the input
                                                  DateTime inputDate =
                                                      DateFormat('dd/MM/yyyy')
                                                          .parse(value);
                                                  // Get today's date without the time part
                                                  DateTime today =
                                                      DateTime.now();
                                                  DateTime todayWithoutTime =
                                                      DateTime(
                                                          today.year,
                                                          today.month,
                                                          today.day);
                                                  // Check if the input date is before today
                                                  if (inputDate.isBefore(
                                                      todayWithoutTime)) {
                                                    return "Date cannot be before today";
                                                  }
                                                  return null;
                                                },
                                              ),
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                          height: 10.h,
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            SizedBox(
                                              width: 180.w,
                                              child: CustomTextFormField(
                                                labelText: "Start Time",
                                                hintText: "Enter start time",
                                                controller: startTime[index],
                                                // onChanged: (p0) {
                                                //   handleChange(
                                                //       index, 'start_time', p0);
                                                // },
                                                textInputType:
                                                    TextInputType.text,
                                                borderDecoration:
                                                    OutlineInputBorder(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(16.r),
                                                        borderSide: BorderSide(
                                                            color: AppColors
                                                                .kprimary,
                                                            width: 1)),
                                                readOnly: true,
                                                onTap: () async {
                                                  TimeOfDay? selectedStartTime =
                                                      await showTimePicker(
                                                    context: context,
                                                    initialTime:
                                                        TimeOfDay.now(),
                                                    builder: (context, child) {
                                                      return calenderTheme(
                                                          child, context);
                                                    },
                                                  );
                                                  if (selectedStartTime !=
                                                      null) {
                                                    final now = DateTime.now();
                                                    final startDateTime =
                                                        DateTime(
                                                      now.year,
                                                      now.month,
                                                      now.day,
                                                      selectedStartTime.hour,
                                                      selectedStartTime.minute,
                                                    );
                                                    String formattedStartTime =
                                                        DateFormat('hh:mm a')
                                                            .format(
                                                                startDateTime);
                                                    String
                                                        sendFormattedStartTime =
                                                        DateFormat('HH:mm')
                                                            .format(
                                                                startDateTime);
                                                    startTime[index].text =
                                                        formattedStartTime;
                                                    handleChange(
                                                        index,
                                                        'start_time',
                                                        sendFormattedStartTime);
                                                  }
                                                },
                                                validator: (value) {
                                                  if (value!.isEmpty) {
                                                    return "Please enter start time";
                                                  }
                                                  return null;
                                                },
                                              ),
                                            ),
                                            SizedBox(
                                              width: 30.w,
                                            ),
                                            SizedBox(
                                              width: 180.w,
                                              child: CustomTextFormField(
                                                labelText: "End Time",
                                                hintText: "Enter end time",
                                                controller: endTime[index],
                                                // onChanged: (p0) {
                                                //   print(p0);
                                                //   handleChange(
                                                //       index, 'end_time', p0);
                                                // },
                                                textInputType:
                                                    TextInputType.text,
                                                borderDecoration:
                                                    OutlineInputBorder(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(16.r),
                                                        borderSide: BorderSide(
                                                            color: AppColors
                                                                .kprimary,
                                                            width: 1)),
                                                readOnly: true,
                                                onTap: () async {
                                                  TimeOfDay? selectedEndTime =
                                                      await showTimePicker(
                                                    context: context,
                                                    initialTime:
                                                        TimeOfDay.now(),
                                                    builder: (context, child) {
                                                      return calenderTheme(
                                                          child, context);
                                                    },
                                                  );
                                                  if (selectedEndTime != null) {
                                                    final now = DateTime.now();
                                                    final endtDateTime =
                                                        DateTime(
                                                      now.year,
                                                      now.month,
                                                      now.day,
                                                      selectedEndTime.hour,
                                                      selectedEndTime.minute,
                                                    );
                                                    String formattedEndTime =
                                                        DateFormat('hh:mm a')
                                                            .format(
                                                                endtDateTime);
                                                    String
                                                        sendFormattedEndTime =
                                                        DateFormat('HH:mm')
                                                            .format(
                                                                endtDateTime);
                                                    endTime[index].text =
                                                        formattedEndTime;
                                                    handleChange(
                                                        index,
                                                        'end_time',
                                                        sendFormattedEndTime);
                                                  }
                                                },
                                                validator: (value) {
                                                  if (value!.isEmpty) {
                                                    return "Please enter end time";
                                                  }

                                                  // Parse the end time
                                                  final endTimeValue =
                                                      TimeOfDay.fromDateTime(
                                                          DateFormat('hh:mm a')
                                                              .parse(value));

                                                  // Parse the start time
                                                  final startTimeValue =
                                                      TimeOfDay.fromDateTime(
                                                          DateFormat('hh:mm a')
                                                              .parse(startTime[
                                                                      index]
                                                                  .text));

                                                  // Compare the times
                                                  if (endTimeValue.hour <
                                                          startTimeValue.hour ||
                                                      (endTimeValue.hour ==
                                                              startTimeValue
                                                                  .hour &&
                                                          endTimeValue.minute <=
                                                              startTimeValue
                                                                  .minute)) {
                                                    Fluttertoast.showToast(
                                                      msg:
                                                          "End time must be after start time",
                                                      toastLength:
                                                          Toast.LENGTH_SHORT,
                                                      gravity: ToastGravity.TOP,
                                                      backgroundColor:
                                                          AppColors.red600D8,
                                                      textColor: Colors.white,
                                                      fontSize: 16.sp,
                                                    );
                                                    return "End time must be after start time";
                                                  }

                                                  return null;
                                                },
                                              ),
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                          height: 10.h,
                                        ),
                                        CustomTextFormField(
                                          scrollPadding: EdgeInsets.only(
                                              bottom: MediaQuery.of(context)
                                                  .viewInsets
                                                  .bottom),
                                          labelText: "Description",
                                          hintText: "Description",
                                          controller: description[index],
                                          onChanged: (p0) {
                                            handleChange(
                                                index, 'description', p0);
                                          },
                                          textInputType: TextInputType.text,
                                          borderDecoration: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(16.r),
                                              borderSide: BorderSide(
                                                  color: AppColors.kprimary,
                                                  width: 1)),
                                          maxLines: 3,
                                          validator: (value) {
                                            if (value!.isEmpty) {
                                              return "Please enter description";
                                            }
                                            return null;
                                          },
                                        ),
                                        SizedBox(
                                          height: 10.h,
                                        ),
                                      ],
                                    ),
                                  );
                                })
                              ]),
                        ),
                ),
                categoryList.isEmpty
                    ? Container()
                    : Obx(() {
                        return Padding(
                          padding: EdgeInsets.symmetric(vertical: 10.h),
                          child: requestController.rxRequestStatus.value ==
                                  Status.loading
                              ? const CustomLoading()
                              : CustomElevatedButton(
                                  text: "Send Request",
                                  onTap: handleSave,
                                ),
                        );
                      })
              ]),
            ))
          ]);
    }));
  }

  // Future<void> sendPushNotification(
  //     String fcmToken, String title, String body, EventModel data) async {
  //   final url = Uri.parse('https://fcm.googleapis.com/fcm/send');
  //   final headers = {
  //     'Content-Type': 'application/json; charset=UTF-8',
  //     'Authorization':
  //         'key=AAAA_XQxeGg:APA91bEpb7RvZnE3H2b9Zc9c50qaZBmS2H7iw0WXyNynShJeXkTw9oqoMN7QYCMT9lO2Om6Yw8p8i3RGXQ-83NcnuCIl7LCxJNYiP7N_hcUEbAlHsMR8-KP5KUjuT5Mu-tnmwCa138Fn',
  //   };

  //   final message = {
  //     'to':
  //         "etYOaljwTienkAaS6i4vel:APA91bHIQNLQgiQu3cYx6pzddb8GcnDUnqIREqd6TCGB2YvAhW0XGO3RPVvf6hKqRr8B3gYhPHyWvhsVV-cUUhn-rH6dl5X65RGI3FkOBqaamaZfcefaVHZrZ6eZul4xhfTVsa3K8vv0",
  //     'notification': {
  //       'title': "",
  //       'body': body,
  //     },
  //   };

  //   final response = await http.post(
  //     url,
  //     headers: headers,
  //     body: jsonEncode(message),
  //   );

  //   if (response.statusCode == 200) {
  //     print('Push notification sent successfully');
  //     FirebaseFirestore.instance.collection("notifications").add({
  //       "title": title,
  //       "body": body,
  //       "time": Timestamp.fromDate(DateTime.now()).millisecondsSinceEpoch,
  //       "booked_by": FirebaseAuth.instance.currentUser!.displayName,
  //       "uid": data.uid,
  //     });
  //   } else {
  //     print(
  //         'Failed to send push notification. Status code: ${response.statusCode}');
  //   }
  // }
}
