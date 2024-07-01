import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:money_management/features/domain/entity/post.dart';
import 'package:money_management/features/presentation/bloc/sheet/sheet_cubit.dart';
import 'package:skeletonizer/skeletonizer.dart';

import 'components/transaction_card.dart';

List<Post> mockPosts = [
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

      List<Post> posts = mockPosts;
      if(state.dataPosts == null) {
        return const Center(child: CircularProgressIndicator());
      }
      
      return Skeletonizer(
        enabled: !(state.isError == false &&
            state.isLoading == false &&
            state.dataPosts != null),
        child: Column(
          children: [
            Expanded(
              child: Column(
                children: [
                  if (state.dataPosts != null)
                    ...state.dataPosts!.entries.map((item) {
                      return Column(
                        children: [
                          Text(item.key),
                          _buildExo(item.value),
                        ],
                      );
                    }).toList()
                ],
              ),
            ),
          ],
        ),
      );
    });
  }

  SizedBox _buildExo(List<Post> posts) {
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
                    context
                        .read<SheetCubit>()
                        .deleteSheetRow(sheetId: item.value.sheetId, index: item.key);
                  },
                  backgroundColor: Color(0xFFFE4A49),
                  foregroundColor: Colors.white,
                  icon: Icons.delete,
                  label: 'Delete',
                ),
              ],
            ),
            child: TransactionCard(
              post: item.value,
            ),
          );
          })
        ],
      )
    );
  }
}
