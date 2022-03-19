import 'package:flutter/material.dart';
import 'package:gametv_app/screens/home.dart';
import 'package:gametv_app/screens/login.dart';
import 'package:gametv_app/services/app_state.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => AppStateProvider(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late Object user;

  Object checkLoginStatus() async {
    final prefs = await SharedPreferences.getInstance();

    return prefs.get('user');
  }

  @override
  void initState() {
    super.initState();
    user = checkLoginStatus();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'GameTV App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: user == null ? const Login() : const Home(),
    );
  }
}
