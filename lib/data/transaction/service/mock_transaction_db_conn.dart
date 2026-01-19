import 'package:flutter_project_1/data/mocks/mock_transaction_db.dart';
import 'package:flutter_project_1/data/transaction/service/i_transaction_db_conn.dart';
import 'package:flutter_project_1/data/transaction/transaction.dart';

class MockTransactionDbConnection implements ITransactionDbConnection {
  @override
  Future<bool> create(Transaction transaction) async {
    MockTransactionDb.add(transaction);
    return true;
  }

  @override
  Future<bool> delete(Transaction transaction) async {
    MockTransactionDb.remove(transaction);
    return true;
  }

  @override
  Future<List<Transaction>> read(Transaction query) async =>
      MockTransactionDb.get(query) ?? [];

  @override
  Future<List<Transaction>> readAll() async => MockTransactionDb.list;

  @override
  Future<bool> update(Transaction transaction) async {
    var select = MockTransactionDb.get(transaction);
    if (select != null && select.length > 1) {
      return false;
    }
    if (select != null && select.length == 1) {
      MockTransactionDb.remove(transaction);
      return true;
    }
    return false;
  }
}
