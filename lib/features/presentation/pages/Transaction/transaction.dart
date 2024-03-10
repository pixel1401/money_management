import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:money_management/features/presentation/shared/ui/Button/button.dart';

import 'components/transaction_card.dart';


class Transaction extends StatefulWidget {
  const Transaction({super.key});

  @override
  State<Transaction> createState() => _TransactionState();
}

class _TransactionState extends State<Transaction> {
  final items = List<String>.generate(20, (i) => "Item ${i + 1}");

  // connectSheets() async {
  //   var data = await Google().signIn();
  //   // var AuthCLien = await data?.authentication;
  //   // print(AuthCLien);
  //   print(data);

  //   // String clientId = '';  
  //   // String apiKey = 'AIzaSyA66asDwqH_gAng5n9CsurH8A6VFC7gizI';
  
  // try {
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
    return Column(
      children: [
        Button(
            onPress: () {
              context.go('/trans/add');
            },
            text: 'Add'),
        Expanded(
          child: Container(
            child: ListView.builder(
              itemCount: items.length,
              itemBuilder: (context, index) {
                final item = items[index];
                return Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: TransactionCard(),
                );
              },
            ),
          ),
        ),
      ],
    );
  }
}


