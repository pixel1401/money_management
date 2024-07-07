import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:googleapis/sheets/v4.dart';
import 'package:money_management/config/theme/theme.dart';
import 'package:money_management/features/presentation/bloc/sheet/sheet_cubit.dart';

import 'components/body_form.dart';
import 'components/header_price.dart';
import 'types/transaction_form.dart';

class CreateTransaction extends StatefulWidget {
  const CreateTransaction({super.key});

  @override
  State<CreateTransaction> createState() => _CreateTransactionState();
}

class _CreateTransactionState extends State<CreateTransaction> {
  final _formKey = GlobalKey<FormBuilderState>();

  bool isCreateCategory = false;
  String dropdownValue = '';

  Future<void> handleSubmit(BuildContext context, TransactionForm data) async {
    final sheetState = context.read<SheetCubit>().state;

    if (sheetState.sheetsApi == null && sheetState.spreadsheet == null) {
      return;
    }

    List<CellData>? valuesReq = [];

    Map<String, dynamic> newData = {
      'category': !isCreateCategory ? data.category : data.createCategory,
      'title': data.name,
      'time': data.time,
      'amount': data.amount,
      'color': data.color,
    };

    for (var a in newData.values) {
      valuesReq.add(
          CellData(userEnteredValue: ExtendedValue(stringValue: a.toString())));
    }

    await context
        .read<SheetCubit>()
        .pushDataSpreadSheet(rows: [RowData(values: valuesReq)]);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: redColors,
        foregroundColor: Colors.white,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: const Text('Expense', style: TextStyle(color: Colors.white)),
        centerTitle: true,
      ),
      body: FormBuilder(
        key: _formKey,
        child: Container(
          color: redColors,
          child: Column(
            children: [
              const HeaderPrice(),
              BodyForm(
                formKey: _formKey,
                handleSubmit: handleSubmit,
                isCreateCategory: isCreateCategory,
                dropdownValue: dropdownValue,
                onIsCreateCategory: (value) {
                  setState(() {
                    isCreateCategory = value;
                  });
                },
                onDropdownValue: (value) {
                  setState(() {
                    dropdownValue = value;
                  });
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
