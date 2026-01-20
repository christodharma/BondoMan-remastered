import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_project_1/data/transaction/repository/db_repo.dart';
import 'package:flutter_project_1/ui/transaction_input/transaction_input_viewmodel.dart';
import 'package:provider/provider.dart';

class TransactionInput extends StatefulWidget {
  const TransactionInput({super.key});

  static const routeName = "/input";

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
    return ChangeNotifierProvider(
      create: (BuildContext context) =>
          TransactionInputViewModel(context.read<TransactionDbRepository>()),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        ),
        body: Consumer<TransactionInputViewModel>(
          builder:
              (BuildContext context,
              TransactionInputViewModel value,
              Widget? child,) {
            return ListView(
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
                // input transaction location
                Padding(
                  padding: .directional(top: 8, bottom: 8),
                  child: TextFormField(
                    controller: locationController,
                    decoration: const InputDecoration(
                      labelText: "Location",
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
                              value: 0, activeColor: Colors.red),
                        ),
                        ListTile(
                          title: const Text("Pemasukan"),
                          leading: Radio<int>(
                              value: 1, activeColor: Colors.green),
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
                            ? "${dateTime!.day}/${dateTime!.month}/${dateTime!
                            .year}"
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
                      value.submitTransaction(
                          nameController: nameController,
                          nominalStringController: nominalController,
                          categoryInt: category,
                          locationController: locationController,
                          dateTime: dateTime);
                    },
                    label: Text("Submit"),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
