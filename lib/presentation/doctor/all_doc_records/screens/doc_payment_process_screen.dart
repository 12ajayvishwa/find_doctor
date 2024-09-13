import 'package:find_doctor/core/constants/app_export.dart';
import 'package:find_doctor/utils/date_time_timeline.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:horizontal_data_table/horizontal_data_table.dart';
import 'package:toggle_switch/toggle_switch.dart';
import 'package:intl/intl.dart';
import '../../../../utils/custom_toast.dart';
import '../../models/request_verification_table_model.dart';

class PaymentProcessScreen extends StatefulWidget {
  const PaymentProcessScreen({super.key});

  @override
  State<PaymentProcessScreen> createState() => _PaymentProcessScreenState();
}

class _PaymentProcessScreenState extends State<PaymentProcessScreen> {
  DayStructerController dayStructerController =
      Get.put(DayStructerController());
  var switchIndex = 0;
  DateTime? selectedDate;
  int selectedMonth = DateTime.now().month;
  int selectedYear = DateTime.now().year;

  List<DateTime> getMonthDates() {
    int year = selectedDate?.year ?? DateTime.now().year;
    int month = selectedDate?.month ?? DateTime.now().month;
    int lastDay = DateTime(year, month + 1, 0).day;

    return List.generate(lastDay, (index) => DateTime(year, month, index + 1));
  }

  void _onDateSelected(DateTime date) {
    setState(() {
      selectedDate = date;
      dayStructerController.selectedDate.value = selectedDate;
      dayStructerController.isDateSelected.value = true;
    });
  }

  @override
  void initState() {
    toast.init(context);
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      selectedDate = null;
      dayStructerController.isDateSelected.value = false;
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    List<dynamic> jsonList = jsonData;
    final List<Task> tasks =
        jsonList.map((json) => Task.fromJson(json)).toList();
    return Scaffold(
        body: SizedBox(
      height: double.infinity,
      width: double.infinity,
      child: Stack(
        children: [
          appBarContainer(size, title: "Payments Process", isLeading: true),
          Positioned(
              bottom: -30,
              right: -20,
              child: Image.asset("assets/images/design_rec.png")),
          Positioned(
            top: 100.h,
            left: 10.w,
            right: 10.w,
            child: 
            Card(
              surfaceTintColor: AppColors.whiteA700,
              
              child: calendarWidget(),
            )
            ,
          ),
          Positioned(top: 250.h, right: 10.w, child: toggleSwitch()),
          Positioned(
              top: 300.h,
              right: 20.w,
              left: switchIndex == 1 ? 10.w : -10.w,
              bottom: 0.h,
              child: switchIndex == 1 ? dataTable(tasks) : listData(tasks)),
        ],
      ),
    ));
  }

  calendarWidget() {
    List<DateTime> monthDates = getMonthDates();
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Row(
                children: [
                  DropdownButton<String>(
                    value: DateFormat('MMM')
                        .format(selectedDate ?? DateTime.now()),
                    items: List.generate(12, (index) {
                      DateTime month = DateTime(DateTime.now().year, index + 1);
                      return DropdownMenuItem<String>(
                        value: DateFormat('MMM').format(month),
                        child: Text(DateFormat('MMM').format(month)),
                      );
                    }),
                    onChanged: (value) {
                      setState(() {
                        selectedMonth = DateFormat('MMM').parse(value!).month;
                        selectedDate = DateTime(selectedYear, selectedMonth);
                        dayStructerController.resetSelectedDate();
                      });
                      print(selectedMonth);
                    },
                  ),
                  const SizedBox(width: 8.0),
                  DropdownButton<int>(
                    value: selectedYear,
                    items: List.generate(3, (index) {
                      int year = DateTime.now().year - 1 + index;
                      return DropdownMenuItem<int>(
                        value: year,
                        child: Text(year.toString()),
                      );
                    }),
                    onChanged: (value) {
                      setState(() {
                        selectedYear = value!;
                        selectedDate = DateTime(selectedYear, selectedMonth);
                        dayStructerController.resetSelectedDate();
                      });
                    },
                  ),
                ],
              ),
            ],
          ),
          SizedBox(
            height: 60.h,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: monthDates.length,
              itemBuilder: (context, index) {
                DateTime date = monthDates[index];
                bool isSelected = dayStructerController.selectedDate.value == null
                    ? false
                    : date.day == selectedDate?.day &&
                        date.month == selectedDate?.month &&
                        date.year == selectedDate?.year;
                return GestureDetector(
                  onTap: () => _onDateSelected(date),
                  child: Container(
                    width: 55.w,
                    margin: const EdgeInsets.symmetric(horizontal: 4.0),
                    decoration: BoxDecoration(
                      color: isSelected ? AppColors.kprimary : Colors.transparent,
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(date.day.toString(),
                            style: AppTextStyles.text16BlackBold.copyWith(
                                color: isSelected
                                    ? AppColors.whiteA700
                                    : AppColors.black121212)),
                        Text(DateFormat('EEE').format(date).toUpperCase(),
                            style: AppTextStyles.text16BlackBold.copyWith(
                                color: isSelected
                                    ? AppColors.whiteA700
                                    : AppColors.gray)),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  listData(List<Task> tasks) {
    return ListView.builder(
      padding: const EdgeInsets.all(0.0),
      itemCount: tasks.length,
      shrinkWrap: true,
      itemBuilder: (context, index) {
        tasks[index].taskName;
        return Container(
            margin: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
                color: AppColors.ksecondaryColor,
                borderRadius: BorderRadius.only(
                    topRight: Radius.circular(20.r),
                    bottomRight: Radius.circular(20.r))),
            child: Padding(
              padding: EdgeInsets.only(
                  left: 20.w, bottom: 20.h, top: 40.h, right: 10.w),
              child: Container(
                height: 340.h,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20.r)),
                child: Stack(
                  children: [
                    Container(
                      height: 340.h,
                      width: 130.w,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20.r),
                        color: AppColors.gray.withOpacity(0.4),
                      ),
                    ),
                    listItemsData(
                      tasks[index].taskNo.toString(),
                      "Task No.",
                    ),
                    Positioned(
                      top: 40.h,
                      left: 0.w,
                      right: 0.w,
                      child: const Divider(
                        thickness: 1,
                        color: Colors.black,
                      ),
                    ),
                    Positioned(
                      top: 50.h,
                      child: listItemsData(
                        tasks[index].taskName.toString(),
                        "Task Name",
                      ),
                    ),
                    Positioned(
                      top: 90.h,
                      left: 0.w,
                      right: 0.w,
                      child: const Divider(
                        thickness: 1,
                        color: Colors.black,
                      ),
                    ),
                    Positioned(
                      top: 100.h,
                      child: listItemsData(
                        tasks[index].payableAmount.toString(),
                        "Payable Amount",
                      ),
                    ),
                    Positioned(
                      top: 220.h,
                      left: 0.w,
                      right: 0.w,
                      child: const Divider(
                        thickness: 1,
                        color: Colors.black,
                      ),
                    ),
                    Positioned(
                      top: 175.h,
                      child: listItemsData(
                        tasks[index].transaction.toString(),
                        "Transaction",
                      ),
                    ),
                    Positioned(
                      top: 160.h,
                      left: 0.w,
                      right: 0.w,
                      child: const Divider(
                        thickness: 1,
                        color: Colors.black,
                      ),
                    ),
                    Positioned(
                      top: 230.h,
                      child: listItemsData(
                        tasks[index].status == "1" ? "Completed" : "Pending",
                        "Status",
                      ),
                    ),
                    Positioned(
                      top: 280.h,
                      left: 0.w,
                      right: 0.w,
                      child: const Divider(
                        thickness: 1,
                        color: Colors.black,
                      ),
                    ),
                    Positioned(
                      top: 290.h,
                      child: listItemsData(
                        tasks[index].createdDate,
                        "Created",
                      ),
                    ),
                  ],
                ),
              ),
            ));
      },
    );
  }

  Padding listItemsData(value, String title) {
    return Padding(
      padding: EdgeInsets.only(left: 20.w, top: 15.h),
      child: SizedBox(
        width: 250,
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  width: 120.w,
                  child: Text(
                    title,
                    style: AppTextStyles.text14White400.copyWith(
                        fontWeight: FontWeight.bold,
                        color: AppColors.black121212),
                  ),
                ),
                SizedBox(
                  width: 100.w,
                  child: Text(value.toString(),
                      style: AppTextStyles.text14White400.copyWith(
                          fontWeight: FontWeight.bold,
                          color: AppColors.black121212)),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  dataTable(List<Task> tasks) {
    return HorizontalDataTable(
      leftHandSideColumnWidth: 80.w,
      rightHandSideColumnWidth: 1000.w,
      isFixedHeader: true,
      headerWidgets: _getTitleWidgets(),
      leftSideItemBuilder: (context, index) =>
          _generateFirstColumnRow(context, tasks[index]),
      rightSideItemBuilder: (context, index) => _generateRightHandSideColumnRow(
        context,
        tasks[index],
      ),
      itemCount: tasks.length,
      rowSeparatorWidget: const Divider(
        color: Colors.black38,
        height: 1.0,
        thickness: 0.0,
      ),
      leftHandSideColBackgroundColor: Colors.white,
      rightHandSideColBackgroundColor: Colors.white,
    );
  }

  toggleSwitch() {
    return ToggleSwitch(
      minWidth: 50.0,
      initialLabelIndex: switchIndex,
      cornerRadius: 20.0,
      activeFgColor: Colors.white,
      inactiveBgColor: Colors.grey.withOpacity(0.5),
      inactiveFgColor: Colors.black,
      totalSwitches: 2,
      // labels: ['Male', 'Female'],
      icons: const [Icons.grid_on, Icons.menu],
      activeBgColors: [
        [AppColors.kprimary],
        [AppColors.kprimary]
      ],
      onToggle: (index) {
        if (kDebugMode) {
          print('switched to: $index');
        }
        setState(() {
          switchIndex = index!;
        });
      },
    );
  }

  List menuItems = [
    "Task No.",
    "Task name",
    "Payable Amount",
    "Transation",
    "Status",
    "Created Date",
    "Action"
  ];

  List<Widget> _getTitleWidgets() {
    return [
      _getTitleItemWidget('Task No.', 100),
      _getTitleItemWidget('Task name', 200),
      _getTitleItemWidget('Payable Amount', 150),
      _getTitleItemWidget('Transaction', 150),
      _getTitleItemWidget(
        'Status',
        100,
      ),
      _getTitleItemWidget('Created Date', 190),
      _getTitleItemWidget('Action', 120),
    ];
  }

  Widget _getTitleItemWidget(
    String label,
    double width,
  ) {
    return Container(
      width: width,
      height: 60.h,
      padding: const EdgeInsets.fromLTRB(5, 0, 0, 0),
      alignment: Alignment.centerLeft,
      child: Text(label,
          style: AppTextStyles.bodyText.copyWith(fontWeight: FontWeight.bold)),
    );
  }

  Widget _generateFirstColumnRow(BuildContext context, Task task) {
    return Container(
      width: 100.w,
      height: 62.h,
      padding: const EdgeInsets.fromLTRB(5, 0, 0, 0),
      alignment: Alignment.centerLeft,
      child: Text(task.taskNo.toString(),
          style: AppTextStyles.bodyText.copyWith(fontWeight: FontWeight.bold)),
    );
  }

  Widget _generateRightHandSideColumnRow(
    BuildContext context,
    Task task,
  ) {
    return Row(
      children: <Widget>[
        Container(
          width: 220.w,
          height: 52.h,
          padding: const EdgeInsets.fromLTRB(5, 0, 0, 0),
          alignment: Alignment.centerLeft,
          child: Text(task.taskName,
              style:
                  AppTextStyles.bodyText.copyWith(fontWeight: FontWeight.bold)),
        ),
        Container(
          width: 160.w,
          height: 52.h,
          padding: const EdgeInsets.fromLTRB(5, 0, 0, 0),
          alignment: Alignment.centerLeft,
          child: Text(task.payableAmount.toString(),
              style:
                  AppTextStyles.bodyText.copyWith(fontWeight: FontWeight.bold)),
        ),
        Container(
          width: 160.w,
          height: 52.h,
          padding: const EdgeInsets.fromLTRB(5, 0, 0, 0),
          alignment: Alignment.centerLeft,
          child: Text(task.transaction,
              style:
                  AppTextStyles.bodyText.copyWith(fontWeight: FontWeight.bold)),
        ),
        Container(
          width: 120.w,
          height: 40.h,
          decoration: BoxDecoration(
            border: Border.all(
                color: task.status == "1"
                    ? Colors.green
                    : task.status == "2"
                        ? Colors.orange
                        : Colors.grey,
                width: 2),
            borderRadius: BorderRadius.circular(25.r),
          ),
          padding: const EdgeInsets.fromLTRB(5, 0, 0, 0),
          alignment: Alignment.center,
          child: Text(
            task.status == "1"
                ? "Completed"
                : task.status == "2"
                    ? "Pending"
                    : "Not Started",
            style: AppTextStyles.text12WhiteRegular.copyWith(
              color: task.status == "1"
                  ? Colors.green
                  : task.status == "2"
                      ? Colors.orange
                      : Colors.grey,
            ),
          ),
        ),
        Container(
          width: 150,
          height: 52,
          padding: const EdgeInsets.fromLTRB(5, 0, 0, 0),
          alignment: Alignment.centerLeft,
          child: Text(task.createdDate,
              style:
                  AppTextStyles.bodyText.copyWith(fontWeight: FontWeight.bold)),
        ),
        Container(
            width: 150.w,
            height: 52.h,
            padding: const EdgeInsets.fromLTRB(5, 0, 0, 0),
            alignment: Alignment.centerLeft,
            child: Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  task.status == "1"
                      ? IconButton(
                          padding: const EdgeInsets.all(0),
                          onPressed: () {},
                          icon: const Icon(Icons.print,
                              size: 20, color: Colors.blueGrey))
                      : const SizedBox(),
                  SizedBox(
                    width: 10.w,
                  ),
                  IconButton(
                      padding: const EdgeInsets.all(0),
                      onPressed: () {},
                      icon: const Icon(Icons.visibility,
                          size: 20, color: Colors.blueGrey))
                ])),
      ],
    );
  }

  List jsonData = [
    {
      "taskNo": 1,
      "taskName": "Task 1",
      "payableAmount": 100.0,
      "transaction": "Cash",
      "status": "2",
      "createdDate": "2024-05-20",
    },
    {
      "taskNo": 2,
      "taskName": "Task 2",
      "payableAmount": 200.0,
      "transaction": "Online",
      "status": "1",
      "createdDate": "2024-05-19",
    },
    {
      "taskNo": 15,
      "taskName": "Task 3",
      "payableAmount": 15000.0,
      "transaction": "Online",
      "status": "1",
      "createdDate": "2024-05-19",
    },
    {
      "taskNo": 512,
      "taskName": "Task 6",
      "payableAmount": 2300.0,
      "transaction": "Cash",
      "status": "2",
      "createdDate": "2024-04-20",
    },
    {
      "taskNo": 512,
      "taskName": "Task 6",
      "payableAmount": 2300.0,
      "transaction": "Cash",
      "status": "2",
      "createdDate": "2024-04-20",
    },
    {
      "taskNo": 512,
      "taskName": "Task 6",
      "payableAmount": 2300.0,
      "transaction": "Cash",
      "status": "2",
      "createdDate": "2024-04-20",
    },
    {
      "taskNo": 512,
      "taskName": "Task 6",
      "payableAmount": 2300.0,
      "transaction": "Cash",
      "status": "2",
      "createdDate": "2024-04-20",
    },
    {
      "taskNo": 512,
      "taskName": "Task 6",
      "payableAmount": 2300.0,
      "transaction": "Cash",
      "status": "2",
      "createdDate": "2024-04-20",
    },
    {
      "taskNo": 512,
      "taskName": "Task 6",
      "payableAmount": 2300.0,
      "transaction": "Cash",
      "status": "2",
      "createdDate": "2024-04-20",
    },
    {
      "taskNo": 512,
      "taskName": "Task 6",
      "payableAmount": 2300.0,
      "transaction": "Cash",
      "status": "2",
      "createdDate": "2024-04-20",
    },
    {
      "taskNo": 512,
      "taskName": "Task 6",
      "payableAmount": 2300.0,
      "transaction": "Cash",
      "status": "2",
      "createdDate": "2024-04-20",
    },
    {
      "taskNo": 512,
      "taskName": "Task 6",
      "payableAmount": 2300.0,
      "transaction": "Cash",
      "status": "2",
      "createdDate": "2024-04-20",
    },
    {
      "taskNo": 512,
      "taskName": "Task 6",
      "payableAmount": 2300.0,
      "transaction": "Cash",
      "status": "2",
      "createdDate": "2024-04-20",
    },
    {
      "taskNo": 512,
      "taskName": "Task 6",
      "payableAmount": 2300.0,
      "transaction": "Cash",
      "status": "2",
      "createdDate": "2024-04-20",
    },
  ];
}
