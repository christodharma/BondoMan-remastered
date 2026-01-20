import 'package:flutter/material.dart';
import 'package:flutter_project_1/data/transaction/repository/db_repo.dart';
import 'package:flutter_project_1/data/transaction/transaction.dart';

class HistoryViewModel extends ChangeNotifier {
  final TransactionDbRepository _repo;

  bool _loading = false;
  List<Transaction> _transactions = [];

  bool get isLoading => _loading;
  List<Transaction> get transactions => _transactions;

  HistoryViewModel(this._repo) {
    _repo.addListener(_onAdd);
  }

  void _onAdd(){
    load();
  }

  Future<void> load() async {
    _loading = true;
    notifyListeners();

    _transactions = await _repo.getAll();

    _loading = false;
    notifyListeners();
  }

  // TODO route to transaction edit
  void editTransaction() {}
}
