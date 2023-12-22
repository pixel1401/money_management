import 'package:flutter/material.dart';

class Transaction extends StatefulWidget {
  const Transaction({super.key});

  @override
  State<Transaction> createState() => _TransactionState();
}

class _TransactionState extends State<Transaction> {

  final items = List<String>.generate(20, (i) => "Item ${i + 1}");


  @override
  Widget build(BuildContext context) {
    return ListView.builder(
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
    );
  }
}
