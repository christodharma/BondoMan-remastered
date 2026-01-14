import 'package:flutter_project_1/data/transaction/i_transaction_db.dart';
import 'package:flutter_project_1/data/transaction/transaction.dart';

class TransactionInputModel {
  final ITransactionDb _connection;

  TransactionInputModel(this._connection);

  Future<bool> create(Transaction transaction) =>
      _connection.create(transaction);

  Future<bool> update(Transaction transaction) =>
      _connection.update(transaction);
}
