import 'package:flutter/material.dart';
import 'package:flutter_project_1/data/transaction/service/i_transaction_db_conn.dart';
import 'package:flutter_project_1/data/transaction/transaction.dart';

class TransactionDbRepository extends ChangeNotifier {
  final ITransactionDbConnection conn;
  List<Transaction>? _cache;

  TransactionDbRepository(this.conn);

  Future<bool> create(Transaction transaction) async {
    return await conn.create(transaction);
  }

  Future<List<Transaction>> readAll() async {
    if (_cache != null) {
      return _cache!;
    }
    final result = await conn.readAll();
    _cache = result;
    return result;
  }
}
