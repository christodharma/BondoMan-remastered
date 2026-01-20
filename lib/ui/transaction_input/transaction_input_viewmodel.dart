import 'package:flutter/material.dart';
import 'package:flutter_project_1/data/transaction/repository/db_repo.dart';
import 'package:flutter_project_1/data/transaction/transaction.dart';

class TransactionInputViewModel extends ChangeNotifier {
  String? errorMessage;
  final TransactionDbRepository repo;

  TransactionInputViewModel(this.repo);

  Future<bool> submitTransaction({
    required String name,
    required String nominalString,
    required int categoryInt,
    required String location,
    required DateTime dateTime,
  }) async {
    if (name.isEmpty || nominalString.isEmpty || location.isEmpty) {
      errorMessage = "All fields must be filled!";
      return false;
    }
    var category = categoryInt == 0 ? Category.send : Category.receive;
    return repo.create(
      Transaction.withNoId(
        name: name,
        nominal: double.parse(nominalString),
        category: category,
        location: location,
        dateTime: dateTime,
      ),
    );
  }
}
