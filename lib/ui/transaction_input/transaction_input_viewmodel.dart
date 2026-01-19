import 'package:flutter/material.dart';
import 'package:flutter_project_1/data/mocks/mock_transaction_db.dart';
import 'package:flutter_project_1/data/transaction/repository/db_repo.dart';
import 'package:flutter_project_1/data/transaction/transaction.dart';

class TransactionInputViewModel extends ChangeNotifier {
  String? errorMessage;
  final TransactionDbRepository repo;

  TransactionInputViewModel(this.repo);

  Future<bool> submitTransaction({
    required TextEditingController nameController,
    required TextEditingController nominalStringController,
    int? categoryInt,
    required TextEditingController locationController,
    DateTime? dateTime,
  }) async {
    if (nameController.text.isEmpty ||
        nominalStringController.text.isEmpty ||
        locationController.text.isEmpty ||
        categoryInt == null ||
        dateTime == null
    ) {
      errorMessage = "All fields must be filled!";
      return false;
    }
    var category = categoryInt == 0 ? Category.send : Category.receive;
    print("Before add: ${MockTransactionDb.counter} items");
    await repo.create(
      Transaction.withNoId(
        name: nameController.text,
        nominal: double.parse(nominalStringController.text),
        category: category,
        location: locationController.text,
        dateTime: dateTime,
      ),
    );
    print("After add: ${MockTransactionDb.counter} items");
    return true;
  }
}
