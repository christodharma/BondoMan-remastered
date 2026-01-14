import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class TransactionInput extends StatefulWidget {
  const TransactionInput({super.key});

  @override
  State<TransactionInput> createState() => _TransactionInputState();
}

class _TransactionInputState extends State<TransactionInput> {
  final nameController = TextEditingController();
  final nominalController = TextEditingController();
  int? category;
  final locationController = TextEditingController();
  DateTime? dateTime;

  void _pressPickDate() async {
    var pickedDate = await showDatePicker(
      context: context,
      initialEntryMode: DatePickerEntryMode.calendarOnly,
      initialDate: DateTime.now(),
      firstDate: DateTime(2024),
      lastDate: DateTime.now(),
    );
    setState(() {
      dateTime = pickedDate;
    });
  }

  @override
  void dispose() {
    nameController.dispose();
    nominalController.dispose();
    locationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    //TODO add validators
    return Scaffold(
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // input item name
          Padding(
            padding: .directional(top: 8, bottom: 8),
            child: TextFormField(
              controller: nameController,
              decoration: const InputDecoration(
                labelText: "Item Name",
                border: OutlineInputBorder(),
              ),
            ),
          ),
          // input nominal
          Padding(
            padding: .directional(top: 8, bottom: 8),
            child: TextFormField(
              keyboardType: .number,
              inputFormatters: <TextInputFormatter>[
                FilteringTextInputFormatter.digitsOnly,
              ],
              controller: nominalController,
              decoration: const InputDecoration(
                labelText: "Price",
                border: OutlineInputBorder(),
              ),
            ),
          ),
          // input category
          Padding(
            padding: .directional(top: 8, bottom: 8),
            child: RadioGroup<int>(
              groupValue: category,
              onChanged: (int? value) {
                setState(() {
                  category = value;
                });
              },
              child: Column(
                children: [
                  Text("Category"),
                  ListTile(
                    title: const Text("Pengeluaran"),
                    leading: Radio<int>(
                      value: 0,
                      activeColor: Colors.red,
                    ),
                  ),
                  ListTile(
                    title: const Text("Pemasukan"),
                    leading: Radio<int>(
                      value: 1,
                      activeColor: Colors.green,
                    ),
                  ),
                ],
              ),
            ),
          ),
          // input date
          Padding(
            padding: .directional(top: 8, bottom: 8),
            child: Row(
              mainAxisAlignment: .spaceBetween,
              children: [
                Text(
                  dateTime != null
                      ? "${dateTime!.day}/${dateTime!.month}/${dateTime!.year}"
                      : "Pick a date",
                ),
                OutlinedButton.icon(
                  onPressed: _pressPickDate,
                  label: Text("Pick date"),
                ),
              ],
            ),
          ),
          Padding(
            padding: .directional(top: 8, bottom: 8),
            child: ElevatedButton.icon(
              onPressed: () {
                // TODO on submit
              },
              label: Text("Submit"),
            ),
          ),
        ],
      ),
    );
  }
}
