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
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _nominalController = TextEditingController();
  final _categoryKey = GlobalKey<FormFieldState<bool>>();
  final _locationController = TextEditingController();
  final _dateTimeKey = GlobalKey<FormFieldState<DateTime>>();

  String? _validateTextInput(String? value) {
    if (value!.isEmpty) {
      return "Field can't be empty";
    }
    if (!RegExp(r'^[a-zA-Z0-9 _.\-()]+$').hasMatch(value)) {
      return "Item name contains invalid characters";
    }
    return null;
  }

  @override
  void dispose() {
    _nameController.dispose();
    _nominalController.dispose();
    _locationController.dispose();
    super.dispose();
  }

  void _submit(TransactionInputViewModel vm) {
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(const SnackBar(content: Text('Submitting transaction..')));

    vm
        .submitTransaction(
          name: _nameController.text,
          nominalString: _nominalController.text,
          isExpense: _categoryKey.currentState!.value!,
          location: _locationController.text,
          dateTime: _dateTimeKey.currentState!.value!,
        )
        .then((response) {
          if (!context.mounted) return;
          _respondToSubmitSuccess(response);
        });
  }

  void _respondToSubmitSuccess(bool response) {
    if (response) {
      ScaffoldMessenger.of(context).clearSnackBars();
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Success!')));
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) => ChangeNotifierProvider(
    create: (BuildContext context) =>
        TransactionInputViewModel(context.read<TransactionDbRepository>()),
    child: Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Container(
        padding: .all(16),
        child: Form(
          key: _formKey,
          child: Column(
            spacing: 16,
            children: [
              // input item name
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(
                  labelText: "Item Name",
                  border: OutlineInputBorder(),
                ),
                validator: _validateTextInput,
              ),
              // input nominal
              TextFormField(
                keyboardType: .number,
                inputFormatters: <TextInputFormatter>[
                  FilteringTextInputFormatter.digitsOnly,
                ],
                controller: _nominalController,
                decoration: const InputDecoration(
                  labelText: "Price",
                  border: OutlineInputBorder(),
                ),
                validator: _validateTextInput,
              ),
              // input transaction location
              TextFormField(
                controller: _locationController,
                decoration: const InputDecoration(
                  labelText: "Location",
                  border: OutlineInputBorder(),
                ),
                validator: _validateTextInput,
              ),
              // input category
              FormField<bool>(
                key: _categoryKey,
                validator: (value) {
                  if (value == null) {
                    return 'Please select an option';
                  }
                  return null;
                },
                builder: (state) {
                  return RadioGroup<bool>(
                    groupValue: state.value,
                    onChanged: (bool? value) {
                      state.didChange(value);
                    },
                    child: Column(
                      children: [
                        Text("Category"),
                        RadioListTile(
                          value: true,
                          activeColor: Colors.red,
                          title: const Text("Pengeluaran"),
                        ),
                        RadioListTile(
                          value: false,
                          activeColor: Colors.green,
                          title: const Text("Pemasukan"),
                        ),
                      ],
                    ),
                  );
                },
              ),
              // input date
              FormField<DateTime>(
                key: _dateTimeKey,
                validator: (value) {
                  if (value == null) {
                    return "Pick date of transaction";
                  }
                  return null;
                },
                builder: (FormFieldState<DateTime> field) => Row(
                  mainAxisAlignment: .spaceBetween,
                  children: [
                    Text(
                      field.value != null
                          ? "${field.value!.day}/${field.value!.month}/${field.value!.year}"
                          : "Pick a date",
                    ),
                    OutlinedButton.icon(
                      onPressed: () async {
                        final pickedDate = await showDatePicker(
                          context: context,
                          initialEntryMode: DatePickerEntryMode.calendarOnly,
                          initialDate: field.value ?? DateTime.now(),
                          firstDate: DateTime.now().copyWith(
                            year: DateTime.now().year - 1,
                          ),
                          lastDate: DateTime.now(),
                        );
                        if (pickedDate != null) {
                          field.didChange(pickedDate);
                        }
                      },
                      label: Text("Pick date"),
                    ),
                  ],
                ),
              ),
              // submit button
              Consumer<TransactionInputViewModel>(
                builder:
                    (
                      BuildContext context,
                      TransactionInputViewModel value,
                      Widget? child,
                    ) => ElevatedButton.icon(
                      onPressed: () {
                        if (!_formKey.currentState!.validate()) return;
                        if (_categoryKey.currentState!.hasError) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                _categoryKey.currentState!.errorText!,
                              ),
                            ),
                          );
                          return;
                        }
                        if (_dateTimeKey.currentState!.hasError) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                _dateTimeKey.currentState!.errorText!,
                              ),
                            ),
                          );
                          return;
                        }
                        _submit(value);
                      },
                      label: Text("Submit"),
                    ),
              ),
            ],
          ),
        ),
      ),
    ),
  );
}
