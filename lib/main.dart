import 'package:flutter/material.dart';
import 'package:flutter_project_1/data/authorization/repository/auth_repo.dart';
import 'package:flutter_project_1/data/authorization/service/supabase_auth.dart';
import 'package:flutter_project_1/data/external_service/supabase_adaptor.dart';
import 'package:flutter_project_1/data/transaction/repository/db_repo.dart';
import 'package:flutter_project_1/data/transaction/service/mock_transaction_db_conn.dart';
import 'package:flutter_project_1/ui/history/history.dart';
import 'package:flutter_project_1/ui/login/login.dart';
import 'package:flutter_project_1/ui/transaction_input/transaction_input.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SupabaseEnvironment.initialize();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) =>
              TransactionDbRepository(MockTransactionDbConnection()),
        ),
        ChangeNotifierProvider(
          create: (context) =>
              AuthorizationRepository(SupabaseAuth(SupabaseEnvironment.client)),
        ),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: .fromSeed(seedColor: Colors.deepPurple),
      ),
      initialRoute: History.routeName,
      routes: {
        History.routeName: (context) => const History(),
        TransactionInput.routeName: (context) => const TransactionInput(),
        Login.routeName: (context) => const Login(),
      },
    );
  }
}
