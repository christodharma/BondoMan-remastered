import 'package:flutter/material.dart';
import 'package:flutter_project_1/data/transaction/transaction.dart';
import 'package:flutter_project_1/data/transaction/transaction_input_model.dart';

class TransactionInputViewModel extends ChangeNotifier {
  TransactionInputViewModel(this.model);
  TransactionInputModel model;
  String? errorMessage;

  Future<bool> submitTransaction({
    String? name,
    String? nominalString,
    int? categoryInt,
    String? location,
    DateTime? dateTime,
  }) async {
    if (name == null ||
        nominalString == null ||
        categoryInt == null ||
        location == null ||
        dateTime == null) {
      errorMessage = "All fields must be filled!";
      return false;
    }
    var category = categoryInt == 0 ? Category.send : Category.receive;
    var transaction = Transaction.withNoId(
      name: name,
      nominal: double.parse(nominalString),
      category: category,
      location: location,
      dateTime: dateTime,
    );
    return await model.create(transaction);
  }
}
