import 'package:flutter/material.dart';

class Settings extends StatefulWidget {
  const Settings({super.key});

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  void saveTransactions() {
    // TODO simpan daftar transaksi
  }

  void sendTransactions() {
    // TODO send daftar transaksi
  }

  void logout() {
    // TODO keluar
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: .start,
        crossAxisAlignment: .stretch,
        children: [
          ElevatedButton.icon(
            onPressed: saveTransactions,
            label: Text("Simpan daftar transaksi"),
          ),
          ElevatedButton.icon(
            onPressed: sendTransactions,
            label: Text("Kirim daftar transaksi"),
          ),
          ElevatedButton.icon(
            onPressed: logout,
            label: Text("Keluar", style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }
}
