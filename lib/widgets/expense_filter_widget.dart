import 'package:expense_tracker/bloc/expense_list/expense_list_bloc.dart';
import 'package:expense_tracker/models/category.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ExpenseFilterWidget extends StatelessWidget {
  const ExpenseFilterWidget({super.key});

  @override
  Widget build(BuildContext context) {
    const categories = Categories.values;

    final activeFiler = context.select(
          (ExpenseListBloc bloc) => bloc.state.filter,
    );

    return LimitedBox(
      maxHeight: 40,
      child: ListView.separated(
        shrinkWrap: true,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          final category = categories[index];

          return ChoiceChip(
            label: Text(category.toName),
            selected: activeFiler == category,
            onSelected: (_) => context
                .read<ExpenseListBloc>()
                .add(ExpenseListCategoryFilterChanged(filter: category)),
          );
        },
        separatorBuilder: (context, index) => const SizedBox(width: 10),
        itemCount: Categories.values.length,
      ),
    );
  }
}