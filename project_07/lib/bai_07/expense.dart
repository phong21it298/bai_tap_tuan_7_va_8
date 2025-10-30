class Expense {
  int? id;
  String title;
  double amount;
  DateTime date;
  bool isIncome;

  Expense({
    this.id,
    required this.title,
    required this.amount,
    required this.date,
    required this.isIncome,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'amount': amount,
      'date': date.toIso8601String(),
      'isIncome': isIncome ? 1 : 0,
    };
  }

  factory Expense.fromMap(Map<String, dynamic> map) {
    return Expense(
      id: map['id'],
      title: map['title'],
      amount: map['amount'],
      date: DateTime.parse(map['date']),
      isIncome: map['isIncome'] == 1,
    );
  }
}
