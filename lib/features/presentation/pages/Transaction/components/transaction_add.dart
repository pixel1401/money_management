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



List<String> list = <String>['One', 'Two', 'Three', 'Four'];

class TransactionAdd extends StatefulWidget {
  const TransactionAdd({super.key});

  @override
  State<TransactionAdd> createState() => TransactionStateAdd();
}

class TransactionStateAdd extends State<TransactionAdd> {
  final _formKey = GlobalKey<FormBuilderState>();

  String dropdownValue = list.first;

  handleSubmit(BuildContext context) async {
    final sheetState = context.read<SheetCubit>().state;

    if (sheetState is SheetSuccess) {
      
      await context.read<SheetCubit>().pushDataSpreadSheet();

      BatchUpdateSpreadsheetRequest request =
          BatchUpdateSpreadsheetRequest(requests: [
        Request(
            updateCells: UpdateCellsRequest(
          fields: "*",
          start: GridCoordinate(
              columnIndex: 2,
              rowIndex: 5,
              sheetId: sheetState.currentFile!.sheets?[0].properties?.sheetId),
          rows: [
            RowData(
              values: [
                CellData(
                    userEnteredValue: ExtendedValue(
                  stringValue: "New Value 111",
                )),
                CellData(
                    userEnteredValue: ExtendedValue(
                  stringValue: "New Value 222",
                )),
                CellData(
                    userEnteredValue:
                        ExtendedValue(stringValue: "New Value 333")),
              ],
            ),
            RowData(values: [
              CellData(
                  userEnteredValue: ExtendedValue(stringValue: 'VAlue2111')),
              CellData(
                  userEnteredValue: ExtendedValue(stringValue: 'VAlue28788')),
            ])
          ],
        ))
      ]);

      // var res = await sheetState.sheetsApi!.spreadsheets
      //     .batchUpdate(request, sheetState.spreadsheetId!, $fields: "*");

      print(sheetState.currentFile);
      print(sheetState.spreadsheetId);
      // print(res);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        BlocBuilder<SheetCubit, SheetState>(builder: (context, state) {
          if (state is SheetSuccess) {
            return Text('SUCCES');
          }
          return Text('ERROR');
        }),
        FormBuilder(
          key: _formKey,
          child: Column(
            children: [
              TextMy(
                'Title',
                variant: TextMyVariant.h1,
              ),
              Space(5),
              FormBuilderDropdown<String>(
                name: 'category',
                initialValue: list.first,
                onChanged: (String? value) {
                  setState(() {
                    dropdownValue = value!;
                  });
                },
                items: list.map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                      value: value, child: Text(value));
                }).toList(),
              ),
              FormBuilderTextField(
                name: 'name',
                decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: "Введите логин",
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
              FormBuilderField(
                name: 'time',
                builder: (FormFieldState<dynamic> field) {
                  return Button(
                      onPress: () async {
                        DateTime? pickedDate = await showDatePicker(
                            context: context,
                            initialDate: DateTime.now(), //get today's date
                            firstDate: DateTime(
                                2000), //DateTime.now() - not to allow to choose before today.
                            lastDate: DateTime(2101));

                        field.didChange(pickedDate);
                      },
                      text: 'Time');
                },
              ),
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
                      debugPrint(
                          _formKey.currentState?.instantValue.toString());
                      handleSubmit(context);
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
}
