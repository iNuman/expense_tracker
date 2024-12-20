import 'dart:convert';

import 'package:expense_tracker/models/Expense.dart';
import 'package:rxdart/rxdart.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocalDataStorage {
  LocalDataStorage({
    required SharedPreferences preferences,
  }) : _preferences = preferences {
    _initialize();
  }

  final SharedPreferences _preferences;
  static const expensesCollectionKey = 'expenses_collection_key';

  final _controller = BehaviorSubject<List<Expense?>>.seeded(const []);

  void _initialize() {
    final expensesJson = _preferences.getString(expensesCollectionKey);
    if (expensesJson != null) {
      final expensesList = List<dynamic>.from(jsonEncode(expensesJson) as List);
      final expenses = expensesList.map((expense) => Expense.fromJson(expense)).toList();
      _controller.add(expenses);
    } else {
      _controller.add(const []);
    }
  }

  Future<void> saveExpense(Expense expense) async {
    final expenses = [..._controller.value];
    final expenseIndex = expenses.indexWhere((currentExpense) => currentExpense?.id == expense.id);
    if (expenseIndex >= 0) {
      expenses[expenseIndex] = expense;
    } else {
      expenses.add(expense);
    }

    _controller.add(expenses);
    await _preferences.setString(expensesCollectionKey, jsonEncode(expenses));
    return;
  }

  Stream<List<Expense?>> getExpenses() => _controller.asBroadcastStream();

  Future<void> deleteExpense(String id) async {
    final expenses = [..._controller.value];
    final expenseIndex = expenses.indexWhere((currentExpense) => currentExpense?.id == id);
    if (expenseIndex == -1) {
      throw Exception("No record found.");
    } else {
      expenses.removeAt(expenseIndex);
      _controller.add(expenses);
      await _preferences.setString(expensesCollectionKey, jsonEncode(expenses));
    }
    return;
  }
}
