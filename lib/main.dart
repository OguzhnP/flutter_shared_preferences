import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:grock/grock.dart';
import 'package:storage_example/screens/home_screen.dart';

void main() {
  SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(statusBarColor: Colors.transparent));
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: Grock.navigationKey,
      scaffoldMessengerKey: Grock.scaffoldMessengerKey,
      debugShowCheckedModeBanner: false,
      title: 'Shared Preferences',
      theme: ThemeData(
        primarySwatch: Colors.red,
      ),
      home: const MainScreen(),
    );
  }
}

class MainScreen extends StatelessWidget {
  const MainScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CupertinoNavigationBar(
        middle: Text("Welcome My App"),
      ),
      body: Center(
        child: OutlinedButton(
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const HomeScreen()));
            },
            child: const Text("Shared Preferences Kullanımı")),
      ),
    );
  }
}
