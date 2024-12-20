import 'package:expense_tracker/bloc/expense_list/expense_list_bloc.dart';
import 'package:expense_tracker/pages/home_page.dart';
import 'package:expense_tracker/repositories/expense_repository.dart';
import 'package:expense_tracker/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MyApp extends StatelessWidget {
  final ExpenseRepository expenseRepository;
  const MyApp({super.key, required this.expenseRepository});

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider.value(
      value: expenseRepository,
      child: BlocProvider(
        create: (context) => ExpenseListBloc(
          repository: expenseRepository,
        )..add(const ExpenseListSubscriptionRequested()),
        child: MaterialApp(
          home: const HomePage(),
          theme: AppTheme.theme,
          debugShowCheckedModeBanner: false,
        ),
      ),
    );
  }
}