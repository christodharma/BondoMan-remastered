import 'dart:io';
import 'package:excel/excel.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:flutter_project_1/data/transaction/transaction.dart';

class SpreadsheetExporter {
  final _excel = Excel.createExcel();
  late final Sheet _sheet;

  static const String _exportFileName = 'BondoMan_export.xlsx';
  String _directory = "";

  Future<String> get directory async {
    if (_directory.isNotEmpty) {
      return _directory;
    }
    return await _fetchPath();
  }

  SpreadsheetExporter() {
    _setSheetName();
    _setHeaderRow();
    _fetchPath();
  }

  void _setSheetName() {
    _excel.rename(_excel.getDefaultSheet() ?? 'Sheet1', 'Transactions');
    _sheet = _excel['Transactions'];
    _excel.setDefaultSheet(_sheet.sheetName);
  }

  void _setHeaderRow() {
    _sheet.appendRow(TransactionsToSheet.headers);
  }

  Future<String> _fetchPath() async {
    var dir = await getDownloadsDirectory();
    _directory = dir!.path;
    return _directory;
  }

  Future<void> _saveToFile() async {
    var fileBytes = _excel.save();
    var directoryTarget = join(await directory, _exportFileName);

    File(directoryTarget)
      ..createSync(recursive: true)
      ..writeAsBytesSync(fileBytes!);
  }

  void _appendTransactionRows(List<Transaction> transactions) {
    for (var transaction in transactions) {
      _sheet.appendRow(transaction.toCellValues());
    }
  }

  Future<void> export(List<Transaction> transactions) async {
    _appendTransactionRows(transactions);
    await _saveToFile();
  }
}

extension TransactionsToSheet on Transaction {
  static const List<String> _fields = [
    'id',
    'name',
    'nominal',
    'is_expense',
    'location',
    'date',
  ];
  static final List<TextCellValue> headers = _fields
      .map((e) => TextCellValue((e)))
      .toList();

  List<CellValue> toCellValues() => <CellValue>[
    TextCellValue(id!.toString()),
    TextCellValue(name!),
    DoubleCellValue(nominal!),
    BoolCellValue(category == .send ? true : false),
    TextCellValue(location!),
    DateCellValue(
      year: dateTime!.year,
      month: dateTime!.month,
      day: dateTime!.day,
    ),
  ];
}
