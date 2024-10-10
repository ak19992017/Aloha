import 'package:aloha/auth/signin.dart';
import 'package:aloha/auth/splash.dart';
import 'package:aloha/constant.dart';
import 'package:aloha/home.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Supabase.initialize(
      url: SuperbaseCredentials.url, anonKey: SuperbaseCredentials.key);

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
      // themeMode: ThemeMode.system,
      theme: ThemeData(fontFamily: 'Poppins', useMaterial3: true),
      initialRoute: SplashScreen.routeName,
      routes: {
        SplashScreen.routeName: (context) => SplashScreen(),
        SignInScreen.routeName: (context) => SignInScreen(),
        HomeScreen.routeName: (context) => HomeScreen(),
      },
    );
  }
}
