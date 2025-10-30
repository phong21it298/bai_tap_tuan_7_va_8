import 'package:flutter/material.dart';
import 'expense.dart';
import 'db_helper.dart';
import 'package:fl_chart/fl_chart.dart';
import 'dart:math';

class MyProject07 extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _MyProject07State();
}

class _MyProject07State extends State<MyProject07> {

  final DBHelper _dbHelper = DBHelper();
  List<Expense> _expenses = [];

  final _titleController = TextEditingController();
  final _amountController = TextEditingController();
  bool _isIncome = true;

  @override
  void initState() {
    super.initState();
    _refreshExpenses();
  }

  void _refreshExpenses() async {
    final data = await _dbHelper.getExpenses();
    setState(() {
      _expenses = data;
    });
  }

  void _addExpense() async {
    final title = _titleController.text;
    final amount = double.tryParse(_amountController.text) ?? 0;

    if (title.isEmpty || amount <= 0) return;

    final expense = Expense(
        title: title, amount: amount, date: DateTime.now(), isIncome: _isIncome);

    await _dbHelper.insertExpense(expense);
    _titleController.clear();
    _amountController.clear();
    setState(() {});
    _refreshExpenses();
    Navigator.of(context).pop();
  }

  void _deleteExpense(int id) async {
    await _dbHelper.deleteExpense(id);
    _refreshExpenses();
  }

  double get totalIncome =>
      _expenses.where((e) => e.isIncome).fold(0, (prev, e) => prev + e.amount);

  double get totalExpense =>
      _expenses.where((e) => !e.isIncome).fold(0, (prev, e) => prev + e.amount);

  List<BarChartGroupData> getChartData() {
    final income = totalIncome;
    final expense = totalExpense;
    return [
      BarChartGroupData(
        x: 0,
        barRods: [
          BarChartRodData(
              toY: income, color: Colors.green, width: 30, borderRadius: BorderRadius.circular(4)),
        ],
      ),
      BarChartGroupData(
        x: 1,
        barRods: [
          BarChartRodData(
              toY: expense, color: Colors.red, width: 30, borderRadius: BorderRadius.circular(4)),
        ],
      ),
    ];
  }

  void _showAddDialog() {
    showDialog(
        context: context,
        builder: (_) => AlertDialog(
          title: const Text('Add Expense'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: _titleController,
                decoration: const InputDecoration(labelText: 'Title'),
              ),
              TextField(
                controller: _amountController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(labelText: 'Amount'),
              ),
              Row(
                children: [
                  const Text('Income'),
                  Switch(
                    value: _isIncome,
                    onChanged: (val) {
                      setState(() {
                        _isIncome = val;
                      });
                    },
                  ),
                ],
              )
            ],
          ),
          actions: [
            TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: const Text('Cancel')),
            ElevatedButton(onPressed: _addExpense, child: const Text('Add')),
          ],
        ));
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: const Text('Expense Tracker'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Text('Total Income: \$${totalIncome.toStringAsFixed(2)}',
                style: const TextStyle(fontSize: 18, color: Colors.green)),
            Text('Total Expense: \$${totalExpense.toStringAsFixed(2)}',
                style: const TextStyle(fontSize: 18, color: Colors.red)),
            const SizedBox(height: 16),
            SizedBox(
              height: 200,
              child: BarChart(
                BarChartData(
                  alignment: BarChartAlignment.spaceAround,
                  maxY: max(totalIncome, totalExpense) + 50,
                  barGroups: getChartData(),
                  titlesData: FlTitlesData(
                    leftTitles: AxisTitles(),
                    bottomTitles: AxisTitles(
                        sideTitles: SideTitles(
                          showTitles: true,
                          getTitlesWidget: (value, meta) {
                            switch (value.toInt()) {
                              case 0:
                                return const Text('Income');
                              case 1:
                                return const Text('Expense');
                            }
                            return const Text('');
                          },
                        )),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: _expenses.isEmpty
                  ? const Center(child: Text('No expenses'))
                  : ListView.builder(
                itemCount: _expenses.length,
                itemBuilder: (context, index) {
                  final exp = _expenses[index];
                  return ListTile(
                    title: Text(exp.title),
                    subtitle: Text(
                        '${exp.isIncome ? "Income" : "Expense"} • ${exp.date.toLocal()}'),
                    trailing: Text(
                      '\$${exp.amount.toStringAsFixed(2)}',
                      style: TextStyle(
                          color: exp.isIncome ? Colors.green : Colors.red),
                    ),
                    onLongPress: () => _deleteExpense(exp.id!),
                  );
                },
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _showAddDialog,
        child: const Icon(Icons.add),
      ),
    );
  }
}
