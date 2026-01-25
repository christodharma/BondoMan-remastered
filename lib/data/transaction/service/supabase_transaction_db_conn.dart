import 'package:flutter_project_1/data/transaction/service/i_transaction_db_conn.dart';
import 'package:flutter_project_1/data/transaction/transaction.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseTransactionDbConn implements ITransactionDbConnection {
  final SupabaseClient client;

  SupabaseTransactionDbConn(this.client);

  @override
  Future<bool> create(Transaction transaction) {
    // TODO: implement create
    throw UnimplementedError();
  }

  @override
  Future<bool> delete(Transaction transaction) {
    // TODO: implement delete
    throw UnimplementedError();
  }

  @override
  Future<List<Transaction>> read(Transaction query) {
    // TODO: implement read
    throw UnimplementedError();
  }

  @override
  Future<List<Transaction>> readAll() async {
    var response = await client.from("transactions").select();
    return response.map((e) => e.toTransaction()).toList();
  }

  @override
  Future<bool> update(Transaction transaction) {
    // TODO: implement update
    throw UnimplementedError();
  }
}

extension TransactionMapper on Map<String, dynamic> {
  Transaction toTransaction(){
    return Transaction(
      id: this['id'] as int,
      name: this['item_name'],
      nominal: (this['nominal'] as num?)?.toDouble(),
      category: this['is_expense'] as bool ? .send : .receive,
      location: this['location'],
      dateTime: DateTime.tryParse(this['created_at']),
    );
  }
}
