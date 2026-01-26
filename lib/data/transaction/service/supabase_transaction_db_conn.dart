import 'package:flutter_project_1/data/transaction/service/i_transaction_db_conn.dart';
import 'package:flutter_project_1/data/transaction/transaction.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseTransactionDbConn implements ITransactionDbConnection {
  final SupabaseClient client;

  static const String _transactionsTable = "transactions";

  SupabaseTransactionDbConn(this.client);

  @override
  Future<bool> create(Transaction transaction) async {
    await client.from(_transactionsTable).insert(transaction.toJSON());
    return true;
  }

  @override
  Future<bool> delete(Transaction transaction) async {
    await client.from(_transactionsTable).delete().eq('id', transaction.id!);
    return true;
  }

  @override
  Future<List<Transaction>> read(Transaction query) async {
    var searchParams = query.toJSONSearchParams();
    var builder = client.from(_transactionsTable).select();
    for (var entry in searchParams.entries) {
      builder.eq(entry.key, entry.value);
    }
    var response = await builder;
    return response.map((e) => e.toTransaction()).toList();
  }

  @override
  Future<List<Transaction>> readAll() async {
    var response = await client.from(_transactionsTable).select();
    return response.map((e) => e.toTransaction()).toList();
  }

  @override
  Future<bool> update(Transaction transaction) async {
    await client
        .from(_transactionsTable)
        .update(transaction.toJSON())
        .eq('id', transaction.id!);
    return true;
  }
}

extension TransactionMapper on Map<String, dynamic> {
  Transaction toTransaction() {
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

extension JsonMapper on Transaction {
  Map<String, dynamic> toJSON() {
    return {
      'item_name': name,
      'nominal': nominal,
      'is_expense': category == .send ? true : false,
      'location': location,
      'created_at': dateTime!.toIso8601String(),
    };
  }

  Map<String, dynamic> toJSONSearchParams() {
    if (id != null) {
      return {'id': id};
    } else {
      var map = <String, dynamic>{};
      if (name != null) {
        map.addAll({'item_name': name});
      }
      if (nominal != null) {
        map.addAll({'nominal': nominal});
      }
      if (category != null) {
        map.addAll({'is_expense': category});
      }
      if (location != null) {
        map.addAll({'location': location});
      }
      if (dateTime != null) {
        map.addAll({'created_at': dateTime!.toIso8601String()});
      }
      return map;
    }
  }
}
