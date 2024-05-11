import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:googleapis/sheets/v4.dart';
import 'package:money_management/core/helpers/helpers.dart';
import 'package:money_management/features/presentation/bloc/sheet/sheet_cubit.dart';

import 'package:money_management/features/presentation/shared/ui/Button/button.dart';
import 'package:money_management/features/presentation/shared/ui/Text/text.dart';

// var spreadsheet = sheets.Spreadsheet();
// spreadsheet.properties =
//     sheets.SpreadsheetProperties(title: 'My Spreadsheet5821');
// spreadsheet.sheets = [
//   sheets.Sheet(properties: sheets.SheetProperties(title: 'Sheet12'))
// ];

// await client.spreadsheets.create(spreadsheet);


class TransactionAdd extends StatefulWidget {
  const TransactionAdd({super.key});

  @override
  State<TransactionAdd> createState() => TransactionStateAdd();
}

class TransactionStateAdd extends State<TransactionAdd> {
  final _formKey = GlobalKey<FormBuilderState>();

  String dropdownValue = '';
  bool isCreateCategory = false;

  handleSubmit(BuildContext context, Map<String, dynamic> data) async {
    final sheetState = context.read<SheetCubit>().state;

    List<CellData>? valuesReq = [];

    Map<String, dynamic> newData = {
      'category': !isCreateCategory ? data['category'] : data['createCategory'],
      'title': data['name'],
      'time': data['time'],
      'amount': data['amount']
    };

    for (var a in newData.values) {
      valuesReq.add(
          CellData(userEnteredValue: ExtendedValue(stringValue: a.toString())));
    }

    // CATEGORY
    // NAME
    // DATE
    // Amount

    await context
        .read<SheetCubit>()
        .pushDataSpreadSheet(rows: [RowData(values: valuesReq)]);
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        BlocBuilder<SheetCubit, SheetState>(builder: (context, state) {
          if (state.isError == false && state.isLoading == false ) {
            return Column(
              children: [
                FormBuilder(
                  key: _formKey,
                  child: Column(
                    children: [
                      TextMy(
                        'Title',
                        variant: TextMyVariant.h1,
                      ),
                      Space(5),
                      FormBuilderSwitch(
                        name: 'isCreateCategory',
                        title: Text('Создать категорию'),
                        initialValue: isCreateCategory,
                        onChanged: (e) {
                          setState(() {
                            isCreateCategory = e ?? false;
                          });
                        },
                      ),
                      Space(5),
                      FormBuilderDropdown<String>(
                        name: 'category',
                        enabled: !isCreateCategory,
                        // initialValue: state.categories?.first ?? '',
                        decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: "Category",
                            fillColor: Colors.black12,
                            filled: true),
                        onChanged: (String? value) {
                          setState(() {
                            dropdownValue = value!;
                          });
                        },
                        items: (state.categories ?? [])
                            .map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                              value: value, child: Text(value));
                        }).toList(),
                      ),
                      Space(5),
                      FormBuilderTextField(
                        name: 'createCategory',
                        enabled: isCreateCategory,
                        decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: "Category name",
                            fillColor: Colors.black12,
                            filled: true),
                        onChanged: (value) {
                          // Обработка изменения ввода текста
                        },
                      ),
                      Space(5),
                      FormBuilderTextField(
                        name: 'name',
                        decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: "Name",
                            fillColor: Colors.black12,
                            filled: true),
                        onChanged: (value) {
                          // Обработка изменения ввода текста
                        },
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter some text';
                          }
                          return null;
                        },
                      ),
                      Space(5),
                      FormBuilderField(
                        name: 'time',
                        builder: (FormFieldState<dynamic> field) {
                          return Button(
                              onPress: () async {
                                DateTime? pickedDate = await showDatePicker(
                                  context: context,
                                  initialDate:
                                      DateTime.now(), //get today's date
                                  firstDate: DateTime(
                                      2000), //DateTime.now() - not to allow to choose before today.
                                  lastDate: DateTime(2101),
                                );

                                field.didChange(pickedDate);
                              },
                              text: 'Time');
                        },
                      ),
                      Space(5),
                      FormBuilderTextField(
                        name: 'amount',
                        keyboardType: TextInputType.number,
                        inputFormatters: <TextInputFormatter>[
                          FilteringTextInputFormatter.digitsOnly,
                        ],
                        decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: "Amount",
                            fillColor: Colors.black12,
                            filled: true),
                        onChanged: (value) {
                          // Обработка изменения ввода текста
                        },
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter some text';
                          }
                          return null;
                        },
                      ),
                      Space(5),
                      Button(
                          onPress: () {
                            // _formKey.currentState?.saveAndValidate();
                            // debugPrint(_formKey.currentState?.value.toString());

                            // _formKey.currentState?.validate();
                            if (_formKey.currentState?.validate() ?? false) {
                              handleSubmit(context,
                                  _formKey.currentState?.instantValue ?? {});
                            }
                            // Navigator.pop(context);
                          },
                          text: 'Submit'),
                    ],
                  ),
                ),
              ],
            );
          }
          return const Center(child: CircularProgressIndicator());
        }),
      ],
    );
  }
}
