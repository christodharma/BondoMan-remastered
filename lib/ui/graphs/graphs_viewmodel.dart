import 'package:flutter/material.dart';
import 'package:flutter_project_1/data/transaction/repository/db_repo.dart';
import 'package:flutter_project_1/data/transaction/transaction.dart';

class GraphsViewModel extends ChangeNotifier {
  final TransactionDbRepository _repo;

  bool _loading = false;
  bool _isDisposed = false;

  double _totalSend = 0;
  double _totalReceive = 0;

  double get totalSend => _totalSend;
  double get totalReceive => _totalReceive;

  GraphsViewModel(this._repo) {
    // TODO? convert to home page view model?
    _repo.addListener(_onAdd);
  }

  void _onAdd() {
    load();
  }

  void _safeNotifyListeners() {
    if (!_isDisposed) notifyListeners();
  }

  Future<void> load() async {
    _loading = true;
    _safeNotifyListeners();

    var transactions = await _repo.getAll();
    for (var tx in transactions) {
      switch (tx.category) {
        case .send:
          _totalSend += tx.nominal ?? 0;
          break;
        case .receive:
          _totalReceive += tx.nominal ?? 0;
          break;
        default:
          break;
      }
    }
    _loading = false;
    _safeNotifyListeners();
  }
}
