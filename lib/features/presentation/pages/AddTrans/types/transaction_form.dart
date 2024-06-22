import 'package:json_annotation/json_annotation.dart';

part 'transaction_form.g.dart';

@JsonSerializable()
class TransactionForm {
  String? name, amount, category, createCategory;
  @JsonKey(fromJson: _fromJson, toJson: _toJson)
  DateTime time;
  bool isCreateCategory;

  TransactionForm({
    this.name,
    this.amount,
    this.category,
    this.createCategory,
    required this.time,
    required this.isCreateCategory,
  });

  factory TransactionForm.fromJson(Map<String, dynamic> json) => _$TransactionFormFromJson(json);
  Map<String, dynamic> toJson() => _$TransactionFormToJson(this);

  static DateTime _fromJson(dynamic json) => json is String ? DateTime.parse(json) : json;
  static String _toJson(DateTime time) => time.toIso8601String();
}
