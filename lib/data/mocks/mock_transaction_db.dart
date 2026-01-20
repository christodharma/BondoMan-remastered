import 'package:flutter_project_1/data/transaction/transaction.dart';

class MockTransactionDb {
  static final List<Transaction> _list = [];
  static int _counter = 0;

  static List<Transaction> get list => _list;
  static int get counter => _counter;

  static void add(Transaction transaction) =>
      _list.add(Transaction.addId(transaction, ++_counter));

  static void remove(Transaction query) {
    var select = _list.where((itr) => itr == query);
    var selectApprox = _list.where((itr) => itr.approximately(query));
    if (select.length > 1 || selectApprox.length > 1) {
      return;
    }

    if (select.length == 1) {
      return _list.removeWhere((tr) => tr == query);
    }
    if (selectApprox.length == 1) {
      return _list.removeWhere((tr) => tr.approximately(query));
    }
  }

  static List<Transaction>? get(Transaction query) {
    var queryById = _list.where((tr) => tr == query).toList();
    if (queryById.isNotEmpty) {
      return queryById;
    }

    var queryByFields = _list.where((tr) => tr.approximately(query)).toList();
    if (queryByFields.isNotEmpty) {
      return queryByFields;
    }
    return null;
  }

  static void dispose() {
    _list.clear();
    _counter = 0;
  }
}
