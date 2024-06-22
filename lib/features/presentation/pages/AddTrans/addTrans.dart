import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:googleapis/sheets/v4.dart';
import 'package:money_management/config/theme/theme.dart';
import 'package:money_management/core/helpers/helpers.dart';
import 'package:money_management/features/presentation/bloc/sheet/sheet_cubit.dart';
import 'package:money_management/features/presentation/shared/ui/Button/button.dart';
import 'package:money_management/features/presentation/shared/ui/Input/Input.dart';
import 'package:money_management/features/presentation/shared/ui/Text/text.dart';

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
      'amount': data.amount
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
        title: Text('Expense', style: TextStyle(color: Colors.white)),
        centerTitle: true,
      ),
      body: FormBuilder(
        key: _formKey,
        child: Container(
          color: redColors,
          child: Column(
            children: [
              Container(
                color: redColors,
                height: MediaQuery.of(context).size.height * 0.3,
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextMy(
                      'How much?',
                      type: TextMyType.secondary,
                      style: TextStyle(color: Colors.white38),
                    ),
                    Row(
                      children: [
                        TextMy(
                          '\$',
                          variant: TextMyVariant.h1,
                          style: TextStyle(color: Colors.white, fontSize: 55),
                        ),
                        Space(0, 15),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.7,
                          child: FormBuilderTextField(
                            name: 'amount',
                            style: TextStyle(color: Colors.white, fontSize: 45),
                            cursorColor: Colors.white,
                            decoration:
                                InputDecoration(border: InputBorder.none),
                            keyboardType: TextInputType.number,
                            inputFormatters: <TextInputFormatter>[
                              FilteringTextInputFormatter.digitsOnly
                            ],
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter some text';
                              }
                              return null;
                            },
                          ),
                        )
                      ],
                    )
                  ],
                ),
              ),
              Expanded(
                child: Container(
                  width: double.infinity,
                  padding: EdgeInsets.only(top: 30, left: 15, right: 15),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(40),
                          topRight: Radius.circular(40))),
                  child: SingleChildScrollView(
                    reverse: true,
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          children: [
                            FormBuilderSwitch(
                              name: 'isCreateCategory',
                              title: Text('Создать категорию',
                                  style: TextStyle(fontSize: 20)),
                              initialValue: isCreateCategory,
                              decoration: InputDecoration(
                                border: InputBorder.none,
                              ),
                              onChanged: (e) {
                                setState(() {
                                  isCreateCategory = e ?? false;
                                });
                              },
                            ),
                            if (!isCreateCategory)
                              Column(
                                children: [
                                  Space(15),
                                  Input(
                                    dropdown: FormBuilderDropdown<String>(
                                      name: 'category',
                                      decoration: const InputDecoration(
                                          hintText: 'Category'),
                                      items: (context
                                                  .watch<SheetCubit>()
                                                  .state
                                                  .categories ??
                                              [])
                                          .map<DropdownMenuItem<String>>(
                                              (String value) {
                                        return DropdownMenuItem<String>(
                                            value: value, child: Text(value));
                                      }).toList(),
                                      enabled: !isCreateCategory,
                                      onChanged: (String? value) {
                                        setState(() {
                                          dropdownValue = value!;
                                        });
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            if (isCreateCategory)
                              Column(
                                children: [
                                  Space(15),
                                  Input(
                                    textInput: FormBuilderTextField(
                                      name: 'createCategory',
                                      enabled: isCreateCategory,
                                      decoration: InputDecoration(
                                        hintText: 'createCategory',
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            Space(15),
                            Input(
                              textInput: FormBuilderTextField(
                                name: 'name',
                                decoration: InputDecoration(hintText: 'Name'),
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter some text';
                                  }
                                  return null;
                                },
                              ),
                            ),
                            Space(15),
                            Input(
                              date: FormBuilderDateTimePicker(
                                name: 'time',
                                decoration: InputDecoration(hintText: 'Date'),
                                validator: (value) {
                                  if (value == null) {
                                    return 'Please enter some text';
                                  }
                                  return null;
                                },
                              ),
                            ),
                          ],
                        ),
                        Column(
                          children: [
                            Space(15),
                            SizedBox(
                              width: double.infinity,
                              child: Button(
                                  styleBtn: ElevatedButton.styleFrom(
                                      padding:
                                          EdgeInsets.symmetric(vertical: 20),
                                      shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(20.0),
                                      )),
                                  onPress: () async {
                                    // _formKey.currentState?.saveAndValidate();
                                    // debugPrint(_formKey.currentState?.value.toString());

                                    // _formKey.currentState?.validate();
                                    if (_formKey.currentState?.validate() ??
                                        false) {
                                      await handleSubmit(
                                          context,
                                          TransactionForm.fromJson(_formKey
                                                  .currentState?.instantValue ??
                                              {}));
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(SnackBar(
                                              content: Text('Success')));
                                    }
                                    // Navigator.pop(context);
                                  },
                                  text: 'Save'),
                            ),
                            Space(15),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
