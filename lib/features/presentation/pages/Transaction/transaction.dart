import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:go_router/go_router.dart';
import 'package:money_management/features/presentation/bloc/sheet/sheet_cubit.dart';
import 'package:money_management/features/presentation/shared/ui/Button/button.dart';

import 'components/transaction_card.dart';

class Transaction extends StatefulWidget {
  const Transaction({super.key});

  @override
  State<Transaction> createState() => _TransactionState();
}

class _TransactionState extends State<Transaction> {
  // connectSheets() async {
  //   var data = await Google().signIn();
  //   // var AuthCLien = await data?.authentication;
  //   // print(AuthCLien);
  //   print(data);

  //   // String clientId = '';
  //   // String apiKey = 'AIzaSyA66asDwqH_gAng5n9CsurH8A6VFC7gizI';

  // try {`
  //   var credentials =  (await Google().anyMethod().authenticatedClient())!;
  //   var client = sheets.SheetsApi(credentials);

  //   var spreadsheet = sheets.Spreadsheet();
  //   spreadsheet.properties =
  //       sheets.SpreadsheetProperties(title: 'My Spreadsheet5821');
  //   spreadsheet.sheets = [
  //     sheets.Sheet(properties: sheets.SheetProperties(title: 'Sheet12'))
  //   ];

  //   await client.spreadsheets.create(spreadsheet);
  //   print('Spreadsheet created successfully!');
  // } catch (e) {
  //   print('${e}  ERROR');
  // }

  // }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SheetCubit, SheetState>(builder: (context, state) {
      if (state.isError == false && state.isLoading == false && state.posts != null) {
        return Column(
          children: [
            Expanded(
              child: Container(
                child: ListView.builder(
                  itemCount: state.posts?.length ?? 0, // items.length,
                  itemBuilder: (context, index) {
                    final item = state.posts?[index];
                    if (item != null) {
                      return Slidable(
                        key: ValueKey(item.index),
                        endActionPane: ActionPane(
                          // A motion is a widget used to control how the pane animates.
                          motion: const ScrollMotion(),

                          // A pane can dismiss the Slidable.
                          // dismissible: DismissiblePane(onDismissed: () {
                          //   print('DISSMISABE');
                          // }),

                          // All actions are defined in the children parameter.
                          children:  [
                            // A SlidableAction can have an icon and/or a label.
                            SlidableAction(
                              onPressed: (context) {
                                context
                                    .read<SheetCubit>()
                                    .deleteSheetRow( sheetId: item.sheetId ,index: index);
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
                    }
                  },
                ),
              ),
            ),
          ],
        );
      } else {
        return const Center(child: CircularProgressIndicator());
      }
    });
  }
}
