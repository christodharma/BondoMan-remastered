import 'package:flutter/foundation.dart';
import 'package:flutter_project_1/data/transaction/transaction.dart';
import 'package:flutter_project_1/data/transaction/i_transaction_db.dart';

class MockTransactionDb implements ITransactionDb {
  List<Transaction> list = [];
  static int _intCounter = 0;

  factory MockTransactionDb() {
    if (!kDebugMode) {
      throw Exception("App mistakenly called debug only feature");
    }
    return MockTransactionDb();
  }

  @override
  Future<bool> create(Transaction transaction) async {
    var added = Transaction.addId(transaction, ++_intCounter);
    list.add(added);
    return true;
  }

  @override
  Future<bool> delete(Transaction transaction) async {
    if (list.remove(transaction)) {
      return true;
    }

    // accept remove only by exact object or by id
    var queryById = list.where((tr) => tr == transaction).toList();
    if (queryById.length == 1) {
      return list.remove(queryById[0]);
    }
    return false;
  }

  @override
  Future<List<Transaction>> read(Transaction query) async {
    var queryById = list.where((tr) => tr == query).toList();
    if (queryById.isNotEmpty) {
      return queryById;
    }

    var queryByFields = list.where((tr) => tr.approximately(query)).toList();
    return queryByFields;
  }

  @override
  Future<List<Transaction>> readAll() async => list;

  @override
  Future<bool> update(Transaction transaction) async {
    var query = list.where((tr) => tr == transaction).toList();
    if (query.length != 1) {
      return false;
    }
    query[0] = transaction;
    return true;
  }

  void dispose() {
    list.clear();
    _intCounter = 0;
  }
}
