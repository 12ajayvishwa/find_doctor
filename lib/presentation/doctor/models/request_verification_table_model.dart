class Task {
  final int taskNo;
  final String taskName;
  final double payableAmount;
  final String transaction;
  final String status;
  final String createdDate;

  Task({
    required this.taskNo,
    required this.taskName,
    required this.payableAmount,
    required this.transaction,
    required this.status,
    required this.createdDate,
  });

  factory Task.fromJson(Map<String, dynamic> json) {
    return Task(
      taskNo: json['taskNo'],
      taskName: json['taskName'],
      payableAmount: json['payableAmount'],
      transaction: json['transaction'],
      status: json['status'],
      createdDate: json['createdDate'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'taskNo': taskNo,
      'taskName': taskName,
      'payableAmount': payableAmount,
      'transaction': transaction,
      'status': status,
      'createdDate': createdDate,
    };
  }
}
