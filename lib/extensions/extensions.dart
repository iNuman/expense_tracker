// import 'package:expense_tracker/models/Expense.dart';
// import 'package:expense_tracker/repositories/expense_repository.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// extension AppX on BuildContext {
//   Future<void> showAddExpenseSheet({Expense? expense}) {
//     return showModalBottomSheet(
//       context: this,
//       builder: (context) => BlocProvider(
//         create: (context) => ExpenseFormBloc(
//           initialExpense: expense,
//           repository: read<ExpenseRepository>(),
//         ),
//         child: const AddExpenseSheetWidget(),
//       ),
//       isScrollControlled: true,
//       useRootNavigator: true,
//       showDragHandle: true,
//     );
//   }
// }