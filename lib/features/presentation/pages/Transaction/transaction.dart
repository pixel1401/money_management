import 'package:extension_google_sign_in_as_googleapis_auth/extension_google_sign_in_as_googleapis_auth.dart';
import 'package:flutter/material.dart';
import 'package:googleapis/authorizedbuyersmarketplace/v1.dart';
import 'package:money_management/core/api/google.dart';
import 'package:money_management/features/presentation/shared/ui/Button/button.dart';
import 'package:googleapis/sheets/v4.dart' as sheets;
import 'package:googleapis_auth/auth_io.dart';


class Transaction extends StatefulWidget {
  const Transaction({super.key});

  @override
  State<Transaction> createState() => _TransactionState();
}

class _TransactionState extends State<Transaction> {
  final items = List<String>.generate(20, (i) => "Item ${i + 1}");

  connectSheets() async {
    var data = await Google().signIn();
    // var AuthCLien = await data?.authentication;
    // print(AuthCLien);
    print(data);

    // String clientId = '';  
    // String apiKey = 'AIzaSyA66asDwqH_gAng5n9CsurH8A6VFC7gizI';
  
  try {
    var credentials =  (await Google().anyMethod().authenticatedClient())!;
    
    var client = sheets.SheetsApi(credentials);
    var spreadsheet = sheets.Spreadsheet();
    spreadsheet.properties =
        sheets.SpreadsheetProperties(title: 'My Spreadsheet5821');
    spreadsheet.sheets = [
      sheets.Sheet(properties: sheets.SheetProperties(title: 'Sheet12'))
    ];

    await client.spreadsheets.create(spreadsheet);
    print('Spreadsheet created successfully!');
  } catch (e) {
    print('${e}  ERROR');
  }
    
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Button(
            onPress: () {
              connectSheets();
            },
            text: 'Connect'),
        Container(
          height: 200,
          child: ListView.builder(
            itemCount: items.length,
            itemBuilder: (context, index) {
              final item = items[index];
              return Dismissible(
                // Specify the direction to swipe and delete
                direction: DismissDirection.endToStart,
                key: Key(item),
                onDismissed: (direction) {
                  // Removes that item the list on swipwe
                  setState(() {
                    items.removeAt(index);
                  });
                  // Shows the information on Snackbar
                },
                background: Container(color: Colors.red),
                child: ListTile(title: Text('$item')),
              );
            },
          ),
        ),
      ],
    );
  }
}

const scopes = [sheets.SheetsApi.spreadsheetsScope];
const prompt = 'select_account';
