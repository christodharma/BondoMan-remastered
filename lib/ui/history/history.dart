import 'package:flutter/material.dart';
import 'package:flutter_project_1/data/transaction/repository/db_repo.dart';
import 'package:flutter_project_1/data/transaction/transaction.dart';
import 'package:flutter_project_1/ui/history/history_viewmodel.dart';
import 'package:flutter_project_1/ui/transaction_input/transaction_input.dart';
import 'package:provider/provider.dart';

class History extends StatelessWidget {
  const History({super.key});

  static const routeName = "/history";

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (BuildContext context) =>
          HistoryViewModel(context.read<TransactionDbRepository>())..load(),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          title: const Text("Transactions"),
        ),
        body: Align(
          alignment: .topCenter,
          child: Consumer<HistoryViewModel>(
            builder:
                (BuildContext context, HistoryViewModel value, Widget? child) {
                  if (value.isLoading) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  return ListView.builder(
                    itemCount: value.transactions.length,
                    itemBuilder: (context, index) =>
                        _HistoryItem(transaction: value.transactions[index]),
                  );
                },
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.pushNamed(context, TransactionInput.routeName);
          },
          child: const Icon(Icons.add),
        ),
      ),
    );
  }
}

class _HistoryItem extends StatelessWidget {
  const _HistoryItem({required this.transaction});

  final Transaction transaction;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ConstrainedBox(
        constraints: BoxConstraints(
          minHeight: 100,
          minWidth: 300,
          maxWidth: 350,
        ),
        child: Padding(
          padding: EdgeInsetsGeometry.fromLTRB(6, 4, 6, 4),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Left side
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    transaction.dateTime.toString(),
                    textAlign: TextAlign.left,
                  ),
                  Text(
                    transaction.name ?? "No name",
                    textAlign: TextAlign.left,
                  ),
                  Text(
                    'IDR ${transaction.nominal.toString()}',
                    textAlign: TextAlign.left,
                  ),
                ],
              ),
              // Right side
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(transaction.category.toString()),
                  Text(transaction.location.toString()),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
