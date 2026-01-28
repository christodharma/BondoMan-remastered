import 'package:flutter/material.dart';
import 'package:flutter_project_1/data/authorization/repository/i_auth_repo.dart';
import 'package:flutter_project_1/data/transaction/repository/db_repo.dart';
import 'package:flutter_project_1/ui/route_generator.dart';
import 'package:flutter_project_1/ui/settings/settings_viewmodel.dart';
import 'package:provider/provider.dart';

class Settings extends StatelessWidget {
  const Settings({super.key});

  @override
  Widget build(BuildContext context) => ChangeNotifierProvider(
    create: (context) =>
        SettingsViewModel(context.read<TransactionDbRepository>()),
    child: Scaffold(
      appBar: AppBar(
        title: const Text("Settings"),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Container(
        padding: .all(16),
        child: Consumer2<SettingsViewModel, IAuthorizationRepository>(
          builder:
              (
                context,
                SettingsViewModel value,
                IAuthorizationRepository value2,
                Widget? child,
              ) => Column(
                mainAxisAlignment: .start,
                crossAxisAlignment: .stretch,
                children: [
                  ElevatedButton.icon(
                    onPressed: () async {
                      await value.exportDatabaseToXLSX();
                      if (!context.mounted) return;
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text("Exported to Documents folder")),
                      );
                    },
                    label: Text("Simpan daftar transaksi"),
                  ),
                  // ElevatedButton.icon(
                  //   onPressed: () async {
                  //     await value.exportAndSendToEmail();
                  //   },
                  //   label: Text("Kirim daftar transaksi"),
                  // ),
                  ElevatedButton.icon(
                    onPressed: () {
                      value2.removeSession().then((_) {
                        if (!context.mounted) return;
                        Navigator.of(context).pushNamedAndRemoveUntil(
                          RouteGenerator.routeMap[RouteNames.login]!,
                          (_) => false,
                        );
                      });
                    },
                    label: Text("Keluar", style: TextStyle(color: Colors.red)),
                  ),
                ],
              ),
        ),
      ),
    ),
  );
}
