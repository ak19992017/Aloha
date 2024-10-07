import 'package:aloha/auth/signin.dart';
import 'package:aloha/home.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SplashScreen extends StatefulWidget {
  static const routeName = '/';

  const SplashScreen({super.key});

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  late Future<bool> _userSessionFuture;

  @override
  void initState() {
    super.initState();
    _userSessionFuture = _getUserSessionStatus();
  }

  Future<bool> _getUserSessionStatus() async {
    try {
      final Session? session = supabase.auth.currentSession;
      return session != null;
    } catch (error) {
      // Handle error gracefully (e.g., show error message)
      print(error); // Log the error for debugging
      return false; // Assume no session on error
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: _userSessionFuture,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            bool userLoginStatus = snapshot.data as bool;
            return userLoginStatus ? HomeScreen() : SignInScreen();
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}
