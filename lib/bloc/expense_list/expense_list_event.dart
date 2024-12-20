part of 'expense_list_bloc.dart';

sealed class ExpenseListEvent extends Equatable {
  const ExpenseListEvent();

  @override
  List<Object> get props => [];
}

final class ExpenseListSubscriptionRequested extends ExpenseListEvent {
  const ExpenseListSubscriptionRequested();
}

final class ExpenseDeleted extends ExpenseListEvent {
  final Expense expense;

  const ExpenseDeleted({required this.expense});

  @override
  List<Object> get props => [expense];
}

final class ExpenseListCategoryFilterChanged extends ExpenseListEvent {
  final Categories filter;

  const ExpenseListCategoryFilterChanged({required this.filter});

  @override
  List<Object> get props => [filter];
}
