import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:money_management/config/theme/theme.dart';
import 'package:money_management/core/helpers/helpers.dart';
import 'package:money_management/features/presentation/shared/ui/Text/text.dart';

class HeaderPrice extends StatelessWidget {
  const HeaderPrice({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: red(),
      height: MediaQuery.of(context).size.height * 0.3,
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          const TextMy(
            'How much?',
            type: TextMyType.secondary,
            style: TextStyle(color: Colors.white38),
          ),
          Row(
            children: [
              const TextMy(
                '\$',
                variant: TextMyVariant.titleX,
                style: TextStyle(color: Colors.white, fontSize: 55),
              ),
              Space(0, 15),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.65,
                child:  FormBuilderTextField(
                  name: 'amount',
                  style: const TextStyle(color: Colors.white, fontSize: 45),
                  cursorColor: Colors.white,
                  decoration:
                      const InputDecoration(border: InputBorder.none),
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
    );
  }
}
