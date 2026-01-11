import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_project_1/Data/Transaction.dart';

class TransactionInput extends StatefulWidget {
  const TransactionInput({super.key});

  @override
  State<TransactionInput> createState() => _TransactionInputState();
}

class _TransactionInputState extends State<TransactionInput> {
  final nameController = TextEditingController();
  final nominalController = TextEditingController();
  Category? category;
  final locationController = TextEditingController();
  DateTime? dateTime;

  Transaction toTransaction() {
    return Transaction(
      name: nameController.text,
      nominal: double.tryParse(nominalController.text),
      category: category,
      location: locationController.text,
      dateTime: dateTime,
    );
  }

  void fromTransaction(Transaction source) {
    nameController.text = source.name ?? "";
    nominalController.text = source.nominal.toString();
    category = source.category;
    locationController.text = source.location ?? "";
    dateTime = source.dateTime;
  }

  //TODO implement initState

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
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Align(
          alignment: .topCenter,
          child: Column(
            spacing: 16,
            children: [
              // input item name
              TextFormField(
                controller: nameController,
                decoration: const InputDecoration(
                  labelText: "Item Name",
                  border: OutlineInputBorder(),
                ),
              ),
              // input nominal
              TextFormField(
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
              // input category
              RadioGroup<Category>(
                groupValue: category,
                onChanged: (Category? value) {
                  setState(() {
                    category = value;
                  });
                },
                child: Column(
                  children: [
                    Text("Category"),
                    ListTile(
                      title: const Text("Pengeluaran"),
                      leading: Radio<Category>(
                        value: Category.send,
                        activeColor: Colors.red,
                      ),
                    ),
                    ListTile(
                      title: const Text("Pemasukan"),
                      leading: Radio<Category>(
                        value: Category.receive,
                        activeColor: Colors.green,
                      ),
                    ),
                  ],
                ),
              ),
              // input date
              ElevatedButton.icon(
                icon: const Icon(Icons.calendar_today),
                onPressed: () async {
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
                },
                label: const Text('Pick a date'),
              ),
              ElevatedButton.icon(
                onPressed: () {
                  // TODO add callback (run validation to input obj!)
                },
                label: Text("Submit"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
