import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:expense_tracker/models/category.dart';
import 'package:expense_tracker/models/expense.dart';
import 'package:expense_tracker/repositories/expense_repository.dart';
import 'package:flutter/foundation.dart';

part 'expense_list_event.dart';
part 'expense_list_state.dart';

class ExpenseListBloc extends Bloc<ExpenseListEvent, ExpenseListState> {
  final ExpenseRepository _repository;

  ExpenseListBloc({required ExpenseRepository repository}): _repository = repository,
        super(const ExpenseListState()) {
    on<ExpenseListSubscriptionRequested>(_onSubscriptionRequested);
    on<ExpenseDeleted>(_onExpenseDeleted);
    on<ExpenseListCategoryFilterChanged>(_onExpenseCategoryFilterChanged);
  }

  Future<void> _onSubscriptionRequested(
    ExpenseListSubscriptionRequested event,
    Emitter<ExpenseListState> emit,
  ) async {
    emit(state.copyWith(status: () => ExpenseListStatus.loading));

    final stream = _repository.getAllExpenses();
    await emit.forEach(
      stream,
      onData: (expenses) => state.copyWith(
        status: () => ExpenseListStatus.success,
        expenses: () => expenses,
        totalExpenses: () => expenses.map((currentExpense) => currentExpense?.amount).fold(0.0, (a, b) => a + b!),
      ),
      onError: (_, __) => state.copyWith(
        status: () => ExpenseListStatus.failure,
      ),
    );
  }

  Future<void> _onExpenseDeleted(
    ExpenseDeleted event,
    Emitter<ExpenseListState> emit,
  ) async {
    await _repository.deleteExpense(event.expense.id);
  }

  Future<void> _onExpenseCategoryFilterChanged(
    ExpenseListCategoryFilterChanged event,
    Emitter<ExpenseListState> emit,
  ) async {
    emit(state.copyWith(filter: () => event.filter));
  }
}
