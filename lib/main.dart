import 'package:expense_tracker/app.dart';
import 'package:expense_tracker/data/LocalDataStorage.dart';
import 'package:expense_tracker/repositories/expense_repository.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final storage = LocalDataStorage(preferences: await SharedPreferences.getInstance());
  final expenseRepository = ExpenseRepository(storage: storage);
  runApp(MyApp(expenseRepository: expenseRepository));
}


