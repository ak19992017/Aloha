import 'package:aloha/constant.dart';
import 'package:aloha/home.dart';
import 'package:aloha/sign_in.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Supabase.initialize(
    url: SuperbaseCredentials.url,
    anonKey: SuperbaseCredentials.key,
  );

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Aloha',
      debugShowCheckedModeBanner: false,
      // darkTheme: ThemeData.dark(),
      themeMode: ThemeMode.system,
      theme: ThemeData(
        fontFamily: 'Poppins',
        useMaterial3: true,
      ),
      initialRoute: SplashScreen.routeName,
      routes: {
        SplashScreen.routeName: (context) => SplashScreen(),
        SignInScreen.routeName: (context) => SignInScreen(),
        HomeScreen.routeName: (context) => HomeScreen(),
      },
      // home: SignInScreen(),
    );
  }
}

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
