import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseEnvironment {
  static const _url = String.fromEnvironment("SUPABASE_URL");
  static const _anonKey = String.fromEnvironment("SUPABASE_ANON_KEY");

  static Future initialize() async {
    await Supabase.initialize(url: _url, anonKey: _anonKey);
  }

  static SupabaseClient get client => Supabase.instance.client;
}
