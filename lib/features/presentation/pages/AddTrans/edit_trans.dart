import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:go_router/go_router.dart';
import 'package:googleapis/sheets/v4.dart';
import 'package:money_management/config/theme/theme.dart';
import 'package:money_management/features/domain/entity/post.dart';
import 'package:money_management/features/presentation/bloc/sheet/sheet_cubit.dart';

import 'components/body_form.dart';
import 'components/header_price.dart';
import 'types/transaction_form.dart';

class EditTransaction extends StatefulWidget {
  final Post data;
  const EditTransaction({super.key, required this.data});

  @override
  State<EditTransaction> createState() => _EditTransactionState();
}

class _EditTransactionState extends State<EditTransaction> {
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
        .updatePost(rows: [RowData(values: valuesReq)] , indexPost: widget.data.index);
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Post post = widget.data;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: redColors,
        foregroundColor: Colors.white,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.canPop(context)
                ? Navigator.pop(context)
                : context.go('/');
          },
        ),
        title: const Text('Expense', style: TextStyle(color: Colors.white)),
        centerTitle: true,
      ),
      body: FormBuilder(
        key: _formKey,
        initialValue: TransactionForm.toJson(post),
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
