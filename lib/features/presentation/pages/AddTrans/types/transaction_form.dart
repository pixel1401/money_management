import 'package:json_annotation/json_annotation.dart';
import 'package:money_management/features/domain/entity/post.dart';

part 'transaction_form.g.dart';

@JsonSerializable()
class TransactionForm {
  String? name, amount, category, createCategory, color;
  @JsonKey(fromJson: _fromJson)
  DateTime time;
  bool isCreateCategory;

  TransactionForm({
    this.name,
    this.amount,
    this.category,
    this.createCategory,
    this.color,
    required this.time,
    required this.isCreateCategory,
  });

  factory TransactionForm.fromJson(Map<String, dynamic> json) => _$TransactionFormFromJson(json);
  static Map<String, dynamic> toJson(Post post) {
    return {
      'name': post.name,
      'amount': post.amount,
      'category': post.category,
      'createCategory': post.category,
      'color': post.color,
      'time': DateTime.tryParse(post.date) ?? DateTime.now(),
    };
  }

  static DateTime _fromJson(dynamic json) => json is String ? DateTime.parse(json) : json;

}
