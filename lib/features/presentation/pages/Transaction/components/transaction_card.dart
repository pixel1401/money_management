import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:money_management/core/helpers/helpers.dart';
import 'package:money_management/features/presentation/shared/ui/Text/text.dart';

class TransactionCard extends StatefulWidget {
  const TransactionCard({super.key});

  @override
  State<TransactionCard> createState() => TransactionCardState();
}

class TransactionCardState extends State<TransactionCard> {
  @override
  Widget build(BuildContext context) {
    return  Card(
      color: HexColor('#fff'),
      shadowColor: Colors.black26,
      elevation: 5,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
      child: Container(
        color: Colors.white,
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
        child: const Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextMy('Shopping', variant: TextMyVariant.h3, type: TextMyType.secondary,),
                TextMy('- 5120' , variant: TextMyVariant.h4, type: TextMyType.danger,)
              ],
            ),
            Row(
              children: [
                TextMy('26 Nov 2021', variant: TextMyVariant.h6,type: TextMyType.disabled, ),
              ],
            )
          ],
        ),
      ),
    );
  }
}


// CATEGOry
// NAME
// AMOUNT
// DATE