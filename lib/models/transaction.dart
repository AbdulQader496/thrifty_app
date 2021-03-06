import 'package:thrifty_app/config/encrypt.dart';
import 'package:thrifty_app/models/models.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Transaction {
  final String id;
  final Category category;
  final String description;
  final DateTime timestamp;
  final double amount;

  Transaction({
    this.id,
    this.category,
    this.description,
    this.timestamp,
    this.amount,
  });

  factory Transaction.fromJson(Map<String, dynamic> json) => Transaction(
        id: json['id'] as String,
        category: Category.fromJson(json['category'] as Map<String, dynamic>),
        description: decrypt(json['description']),
        timestamp: (json['timestamp'] as Timestamp).toDate(),
        amount: double.parse(decrypt(json['amount'])),
      );

  Map<String, dynamic> toJson() => <String, dynamic>{
        'id': this.id,
        'category': this.category.toJson(),
        'description': encrypt(this.description),
        'timestamp': this.timestamp,
        'amount': encrypt(this.amount.toString()),
      };
}

String decrypt(json) {
}
String encrypt(json) {
}