import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_project_1/data/external_service/spreadsheet_export.dart';
import 'package:flutter_project_1/data/transaction/repository/db_repo.dart';

class SettingsViewModel extends ChangeNotifier {
  final TransactionDbRepository _repo;

  SettingsViewModel(this._repo);

  Future<void> exportDatabaseToXLSX() async {
    var exporter = SpreadsheetExporter();
    var transactions = await _repo.getAll();
    await exporter.export(transactions);
  }

  Future<void> exportAndSendToEmail() async {}
}
