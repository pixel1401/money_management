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
      List<Post> posts = state.posts ?? mockPosts;
      return Skeletonizer(
        enabled: !(state.isError == false &&
            state.isLoading == false &&
            state.posts != null),
        child: Column(
          children: [
            Expanded(
              child: SizedBox(
                child: ListView.builder(
                  itemCount: posts.length, // items.length,
                  itemBuilder: (context, index) {
                    final item = posts[index];
                    return Slidable(
                      key: ValueKey(item.index),
                      endActionPane: ActionPane(
                        motion: const ScrollMotion(),
                        children: [
                          SlidableAction(
                            onPressed: (context) {
                              context.read<SheetCubit>().deleteSheetRow(
                                  sheetId: item.sheetId, index: index);
                            },
                            backgroundColor: Color(0xFFFE4A49),
                            foregroundColor: Colors.white,
                            icon: Icons.delete,
                            label: 'Delete',
                          ),
                        ],
                      ),
                      child: TransactionCard(
                        post: item,
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      );
    });
  }
}
