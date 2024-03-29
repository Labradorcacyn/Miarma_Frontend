import 'package:flutter/material.dart';
import 'package:miarma_app/screens/login_screen.dart';
import 'package:miarma_app/utils/preferences.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    PreferenceUtils.init();

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'MeteroApp',
      theme: ThemeData(),
      initialRoute: '/',
      routes: {
        '/': (context) => const LoginScreen(),
      },
    );
  }
}
