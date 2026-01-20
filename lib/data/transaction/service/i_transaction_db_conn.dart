import 'package:flutter_project_1/data/transaction/transaction.dart';

abstract interface class ITransactionDbConnection {
  Future<bool> create(Transaction transaction);

  Future<List<Transaction>> read(Transaction query);

  Future<List<Transaction>> readAll();

  Future<bool> update(Transaction transaction);

  Future<bool> delete(Transaction transaction);
}
