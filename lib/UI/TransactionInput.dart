import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_project_1/Data/Transaction.dart';

class TransactionInput extends StatefulWidget {
  const TransactionInput({super.key});

  @override
  State<TransactionInput> createState() => _TransactionInputState();
}

class _TransactionInputState extends State<TransactionInput> {
  late Transaction input = Transaction(
    name: null,
    nominal: null,
    category: null,
    location: null,
    dateTime: null,
  );

  @override
  Widget build(BuildContext context) {
    //TODO add validators
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Align(
          alignment: .topCenter,
          child: Column(
            spacing: 16,
            children: [
              TextFormField(
                onChanged: (String? value) {
                  input.name = value;
                },
                decoration: const InputDecoration(
                  labelText: "Item Name",
                  border: OutlineInputBorder(),
                ),
              ),
              TextFormField(
                keyboardType: .number,
                inputFormatters: <TextInputFormatter>[
                  FilteringTextInputFormatter.digitsOnly,
                ],
                onChanged: (String? value) {
                  // TODO add callback
                },
                decoration: const InputDecoration(
                  labelText: "Price",
                  border: OutlineInputBorder(),
                ),
              ),
              RadioGroup<Category>(
                groupValue: input.category,
                onChanged: (Category? value) {
                  setState(() {
                    input.category = value;
                  });
                },
                child: Column(
                  children: [
                    ListTile(
                      title: const Text("Pengeluaran"),
                      leading: Radio<Category>(value: Category.send),
                    ),
                    ListTile(
                      title: const Text("Pemasukan"),
                      leading: Radio<Category>(value: Category.receive),
                    ),
                  ],
                ),
              ),
              // TODO date picker button calling date picker dialog
              // TODO submit button
            ],
          ),
        ),
      ),
    );
  }
}
