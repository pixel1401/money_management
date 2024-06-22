import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

class Input extends StatelessWidget {
  final FormBuilderTextField? textInput;
  final FormBuilderDropdown? dropdown;
  final FormBuilderDateTimePicker? date;
  const Input({super.key, this.dropdown, this.textInput, this.date});

  @override
  Widget build(BuildContext context) {
    const decoration = InputDecoration(
      filled: true,
      fillColor: Colors.white,
      contentPadding: EdgeInsets.only(left: 14.0, bottom: 18.0, top: 18.0),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Colors.grey),
        borderRadius: BorderRadius.all(Radius.circular(12)),
      ),
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Colors.black12),
        borderRadius: BorderRadius.all(Radius.circular(12)),
      ),
      border: OutlineInputBorder(
        borderSide: BorderSide(color: Colors.red),
        borderRadius: BorderRadius.all(Radius.circular(15.7)),
      ),
    );

    if (textInput != null) {
      return FormBuilderTextField(
        name: textInput!.name,
        enabled: textInput!.enabled,
        decoration:
            decoration.copyWith(hintText: textInput!.decoration.hintText),
        validator: textInput!.validator ??
            (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter some text';
              }
              return null;
            },
      );
    } else if (dropdown != null) {
      return FormBuilderDropdown(
        name: dropdown!.name,
        decoration: InputDecoration(
          filled: true,
          fillColor: Colors.white,
          hintText: dropdown!.decoration.hintText,
          hintStyle: const TextStyle(color: Colors.grey),
          contentPadding:
              const EdgeInsets.only(left: 14.0, bottom: 18.0, top: 18.0),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.grey),
            borderRadius: BorderRadius.circular(12),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.black12),
            borderRadius: BorderRadius.circular(12),
          ),
          border: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.red),
            borderRadius: BorderRadius.circular(15.7),
          ),
        ),
        items: dropdown!.items,
      );
    }else if (date != null) {
      return FormBuilderDateTimePicker(
        name: date!.name,
        decoration: decoration.copyWith(hintText: date!.decoration.hintText),
        inputType: InputType.date,
        validator: date!.validator,
      );
    }

    return const SizedBox();
  }
}
