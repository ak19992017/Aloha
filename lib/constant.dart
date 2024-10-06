import 'package:supabase_flutter/supabase_flutter.dart';

class SuperbaseCredentials {
  static const String url = "https://kapnkypovldoarardosa.supabase.co";
  static const String key =
      "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImthcG5reXBvdmxkb2FyYXJkb3NhIiwicm9sZSI6ImFub24iLCJpYXQiOjE2ODY3NDYwODEsImV4cCI6MjAwMjMyMjA4MX0.Q58r_x_o6harkCTKUY-dEKDCiqfe4bdf317mJMu_N9c";

  static SupabaseClient supabaseClient = SupabaseClient(url, key);
  final supabase = Supabase.instance.client;
}
