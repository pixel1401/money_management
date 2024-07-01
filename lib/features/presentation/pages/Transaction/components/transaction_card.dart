import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:money_management/core/helpers/helpers.dart';
import 'package:money_management/features/domain/entity/post.dart';
import 'package:money_management/features/presentation/shared/ui/Text/text.dart';
import 'package:intl/intl.dart';

class TransactionCard extends StatefulWidget {
  final Post post;
  const TransactionCard({super.key , required this.post});

  @override
  State<TransactionCard> createState() => TransactionCardState();
}

class TransactionCardState extends State<TransactionCard> {


  @override
  Widget build(BuildContext context) {
    
    String formattedDate = '';

    if(DateTime.tryParse(widget.post.date) == null ) {
      formattedDate = '';
    }else {
      formattedDate = DateFormat('dd.MM.yyyy').format(DateTime.parse(widget.post.date));
    }

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
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextMy(widget.post.category, variant: TextMyVariant.regular1, type: TextMyType.secondary,),
                TextMy('- ${widget.post.amount}' , variant: TextMyVariant.regular3, type: TextMyType.danger,)
              ],
            ),
            Row(
              children: [
                TextMy(formattedDate, variant: TextMyVariant.small,type: TextMyType.disabled, ),
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