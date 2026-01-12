import 'package:flutter/material.dart';
import 'package:flutter_project_1/Data/transaction.dart';

class HistoryPage extends StatefulWidget {
  const HistoryPage({super.key});

  @override
  State<StatefulWidget> createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  final transactions = <Transaction>[
    Transaction(
      name: "Mi Ayam",
      nominal: 15000,
      category: Category.send,
      location: "Malang",
      dateTime: DateTime.now(),
    ),
    Transaction(
      name: "Mi Ayam",
      nominal: 15000,
      category: Category.send,
      location: "Malang",
      dateTime: DateTime.now(),
    ),
    Transaction(
      name: "Mi Ayam",
      nominal: 15000,
      category: Category.send,
      location: "Malang",
      dateTime: DateTime.now(),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Align(
        alignment: Alignment.topCenter,
        child: ListView.builder(
          itemCount: transactions.length,
          itemBuilder: (context, index) {
            return _HistoryItem(transaction: transactions[index]);
          },
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
