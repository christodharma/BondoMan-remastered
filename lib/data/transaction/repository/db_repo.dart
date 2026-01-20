import 'package:flutter/material.dart';
import 'package:flutter_project_1/data/transaction/service/i_transaction_db_conn.dart';
import 'package:flutter_project_1/data/transaction/transaction.dart';

class TransactionDbRepository extends ChangeNotifier {
  final ITransactionDbConnection conn;
  List<Transaction>? _cache;

  TransactionDbRepository(this.conn);

  Future<bool> create(Transaction transaction) async {
    var result = await conn.create(transaction);
    _cache = null;
    notifyListeners();
    return result;
  }

  Future<List<Transaction>> getAll() async {
    if (_cache != null) return _cache!;
    _cache = await conn.readAll();
    return _cache!;
  }

  // TODO add editing transactions
}
