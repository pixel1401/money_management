import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:money_management/config/theme/theme.dart';
import 'package:money_management/core/helpers/helpers.dart';
import 'package:money_management/features/domain/entity/post.dart';
import 'package:money_management/features/presentation/shared/ui/Text/text.dart';
import 'package:intl/intl.dart';

class TransactionCard extends StatefulWidget {
  final Post post;
  const TransactionCard({super.key, required this.post});

  @override
  State<TransactionCard> createState() => TransactionCardState();
}

class TransactionCardState extends State<TransactionCard> {
  @override
  Widget build(BuildContext context) {
    String formattedDate = '';

    if (DateTime.tryParse(widget.post.date) == null) {
      formattedDate = '';
    } else {
      formattedDate =
          DateFormat('dd.MM.yyyy').format(DateTime.parse(widget.post.date));
    }


    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      child: Row(
        children: [
          Container(
            height: 50,
            width: 50,
            decoration: BoxDecoration(
                color: (widget.post.color) != null
                    ? HexColor(widget.post.color!)
                    : violet(ColorOpacity.twenty),
                borderRadius: BorderRadius.circular(10)),
          ),
          const SizedBox(
            width: 9,
          ),
          Expanded(
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextMy(
                      widget.post.category,
                      type: TextMyType.secondary,
                    ),
                    TextMy(
                      '- ${widget.post.amount}\$',
                      variant: TextMyVariant.regular1,
                      type: TextMyType.danger,
                    )
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextMy(
                      widget.post.name,
                      variant: TextMyVariant.small,
                      type: TextMyType.disabled,
                    ),
                    TextMy(
                      formattedDate,
                      variant: TextMyVariant.small,
                      type: TextMyType.disabled,
                    ),
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}


// CATEGOry
// NAME
// AMOUNT
// DATE