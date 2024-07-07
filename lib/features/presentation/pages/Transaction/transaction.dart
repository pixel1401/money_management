import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:money_management/config/theme/theme.dart';
import 'package:money_management/features/domain/entity/post.dart';
import 'package:money_management/features/presentation/bloc/sheet/sheet_cubit.dart';
import 'package:money_management/features/presentation/shared/ui/Text/text.dart';
import 'package:skeletonizer/skeletonizer.dart';

import 'components/transaction_card.dart';

Map<String, List<Post>> dataPostsMock = {
  'Today': mockPosts,
  "Yesterday": mockPosts,
  "20.10.2022": mockPosts
};

List<Post> mockPosts = [
  Post(
    index: 1,
    name: 'Food fowakodp',
    amount: '100',
    category: 'Food',
    date: '2022-10-10',
    sheetId: 5,
  ),
  Post(
    index: 1,
    name: 'Food',
    amount: '100',
    category: 'Food',
    date: '2022-10-10',
    sheetId: 5,
  ),
  Post(
    index: 1,
    name: 'Hello i am oawkd awokd ap',
    amount: '100',
    category: 'Food',
    date: '2022-10-10',
    sheetId: 5,
  ),
  Post(
    index: 1,
    name: 'Food',
    amount: '100',
    category: 'Food',
    date: '2022-10-10',
    sheetId: 5,
  ),
  Post(
    index: 1,
    name: 'Food',
    amount: '100',
    category: 'Food',
    date: '2022-10-10',
    sheetId: 5,
  ),
];

class Transaction extends StatefulWidget {
  const Transaction({super.key});

  @override
  State<Transaction> createState() => _TransactionState();
}

class _TransactionState extends State<Transaction> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SheetCubit, SheetState>(builder: (context, state) {
      return SingleChildScrollView(
        child: Skeletonizer(
          enabled:
              (state.isError || state.isLoading || state.dataPosts == null),
          child: Column(
            children: [
              ...(state.dataPosts ?? dataPostsMock).entries.map((item) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10)
                          .copyWith(bottom: 13),
                      child: TextMy(item.key, variant: TextMyVariant.title3),
                    ),
                    _buildItems(item.value),
                  ],
                );
              }).toList()
            ],
          ),
        ),
      );
    });
  }

  SizedBox _buildItems(List<Post> posts) {
    return SizedBox(
        child: Column(
      children: [
        ...posts.asMap().entries.map((item) {
          return Slidable(
            key: ValueKey(item.key),
            endActionPane: ActionPane(
              motion: const ScrollMotion(),
              children: [
                SlidableAction(
                  onPressed: (context) {
                    context.read<SheetCubit>().deleteSheetRow(
                        sheetId: item.value.sheetId, index: item.key);
                  },
                  backgroundColor: Color(0xFFFE4A49),
                  foregroundColor: Colors.white,
                  icon: Icons.delete,
                  label: 'Delete',
                ),
              ],
            ),
            startActionPane: ActionPane(
              motion: const ScrollMotion(),
              children: [
                SlidableAction(
                  onPressed: (context) {
                    
                  },
                  backgroundColor: yellow(ColorOpacity.sixty),
                  foregroundColor: Colors.white,
                  icon: Icons.mode_edit_outline_outlined,
                  label: 'Edit',
                )
              ],
            ),
            child: Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: TransactionCard(
                post: item.value,
              ),
            ),
          );
        })
      ],
    ));
  }
}
