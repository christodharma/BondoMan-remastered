import 'package:flutter/material.dart';
import 'package:flutter_project_1/data/authorization/repository/auth_repo.dart';
import 'package:flutter_project_1/data/authorization/service/supabase_auth.dart';
import 'package:flutter_project_1/data/external_service/supabase_adaptor.dart';
import 'package:flutter_project_1/data/transaction/repository/db_repo.dart';
import 'package:flutter_project_1/data/transaction/service/mock_transaction_db_conn.dart';
import 'package:flutter_project_1/ui/login/login.dart';
import 'package:flutter_project_1/ui/route_generator.dart';
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
      title: 'BondoMan Remastered',
      theme: ThemeData(colorScheme: .fromSeed(seedColor: Colors.deepPurple)),
      initialRoute: Login.routeName,
      onGenerateRoute: RouteGenerator.generateRoute,
    );
  }
}
