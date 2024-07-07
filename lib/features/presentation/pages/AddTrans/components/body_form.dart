import 'package:flex_color_picker/flex_color_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:money_management/core/helpers/helpers.dart';
import 'package:money_management/features/presentation/bloc/sheet/sheet_cubit.dart';
import 'package:money_management/features/presentation/shared/ui/Button/button.dart';
import 'package:money_management/features/presentation/shared/ui/Input/Input.dart';

import '../types/transaction_form.dart';

class BodyForm extends StatefulWidget {
  final GlobalKey<FormBuilderState> formKey;
  final Future<void> Function(BuildContext context, TransactionForm data) handleSubmit;
  final bool isCreateCategory;
  final String dropdownValue;
  final Function onIsCreateCategory;
  final Function onDropdownValue;
  const BodyForm(
      {super.key,
      required this.formKey,
      required this.handleSubmit,
      required this.isCreateCategory,
      required this.dropdownValue,
      required this.onIsCreateCategory,
      required this.onDropdownValue});

  @override
  State<BodyForm> createState() => _BodyFormState();
}

class _BodyFormState extends State<BodyForm> {
  Color? pickColorForCategory;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.only(top: 30, left: 15, right: 15),
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(40), topRight: Radius.circular(40))),
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
                    initialValue: widget.isCreateCategory,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                    ),
                    onChanged: (e) {
                      widget.onIsCreateCategory(e ?? false);
                    },
                  ),
                  if (!widget.isCreateCategory)
                    Column(
                      children: [
                        Space(15),
                        Input(
                          dropdown: FormBuilderDropdown<String>(
                            name: 'category',
                            decoration:
                                const InputDecoration(hintText: 'Category'),
                            items: (context
                                        .watch<SheetCubit>()
                                        .state
                                        .categories ??
                                    [])
                                .map<DropdownMenuItem<String>>((String value) {
                              return DropdownMenuItem<String>(
                                  value: value, child: Text(value));
                            }).toList(),
                            enabled: !widget.isCreateCategory,
                            onChanged: (String? value) {
                              widget.onDropdownValue(value ?? '');
                            },
                          ),
                        ),
                      ],
                    ),
                  if (widget.isCreateCategory)
                    Column(
                      children: [
                        Space(15),
                        Input(
                          textInput: FormBuilderTextField(
                            name: 'createCategory',
                            enabled: widget.isCreateCategory,
                            decoration: InputDecoration(
                              hintText: 'createCategory',
                            ),
                          ),
                        ),
                      ],
                    ),
                  Space(15),
                  FormBuilderField(
                    name: 'color',
                    builder: (FormFieldState<dynamic> field) {
                      return Row(
                        children: [
                          Container(
                            width: 50,
                            height: 50,
                            decoration: BoxDecoration(
                                color: pickColorForCategory,
                                borderRadius: BorderRadius.circular(10),
                                border:
                                    Border.all(color: Colors.grey, width: 1)),
                          ),
                          Space(5, 10),
                          Button(
                              onPress: () async {
                                var pickColor = await showColorPickerDialog(
                                    context, Colors.black);
                                setState(() {
                                  pickColorForCategory = pickColor;
                                });
                                field.didChange(colorToHex(pickColor));
                              },
                              text: 'Pick color'),
                        ],
                      );
                    },
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
                            padding: EdgeInsets.symmetric(vertical: 20),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20.0),
                            )),
                        onPress: () async {
                          // _formKey.currentState?.saveAndValidate();
                          // debugPrint(_formKey.currentState?.value.toString());

                          // _formKey.currentState?.validate();
                          if (widget.formKey.currentState?.validate() ??
                              false) {
                            await widget.handleSubmit(
                                context,
                                TransactionForm.fromJson(
                                    widget.formKey.currentState?.instantValue ??
                                        {}));
                            ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(content: Text('Success')));
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
    );
  }
}
