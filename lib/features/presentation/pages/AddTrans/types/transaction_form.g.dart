// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'transaction_form.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TransactionForm _$TransactionFormFromJson(Map<String, dynamic> json) =>
    TransactionForm(
      name: json['name'] as String?,
      amount: json['amount'] as String?,
      category: json['category'] as String?,
      createCategory: json['createCategory'] as String?,
      time: TransactionForm._fromJson(json['time']),
      isCreateCategory: json['isCreateCategory'] as bool,
    );

Map<String, dynamic> _$TransactionFormToJson(TransactionForm instance) =>
    <String, dynamic>{
      'name': instance.name,
      'amount': instance.amount,
      'category': instance.category,
      'createCategory': instance.createCategory,
      'time': TransactionForm._toJson(instance.time),
      'isCreateCategory': instance.isCreateCategory,
    };
