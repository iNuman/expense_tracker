import 'package:expense_tracker/models/expense.dart';

enum Categories {
  all,
  grocery,
  food,
  work,
  entertainment,
  traveling,
  other;

  String toJson() => name;
  static Categories fromJson(String json) => values.byName(json);
}

extension CategoryX on Categories {
  String get toName => switch (this) {
    Categories.all => 'All',
    Categories.entertainment => 'Entertainment',
    Categories.food => 'Food',
    Categories.grocery => 'Grocery',
    Categories.work => 'Work',
    Categories.traveling => 'Traveling',
    Categories.other => 'Other',
  };

  bool apply(Expense? expense) => switch (this) {
    Categories.all => true,
    Categories.entertainment => expense?.category == Categories.entertainment,
    Categories.food => expense?.category == Categories.food,
    Categories.grocery => expense?.category == Categories.grocery,
    Categories.work => expense?.category == Categories.work,
    Categories.traveling => expense?.category == Categories.traveling,
    Categories.other => expense?.category == Categories.other,
  };

  Iterable<Expense?> applyAll(Iterable<Expense?> expenses) {
    return expenses.where(apply);
  }
}