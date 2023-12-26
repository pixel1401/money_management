import 'package:flutter/material.dart';
import 'package:money_management/features/presentation/pages/AddTrans/addTrans.dart';
import 'package:money_management/features/presentation/pages/App/app.dart';
import 'package:money_management/features/presentation/pages/Home/home.dart';
import 'package:money_management/features/presentation/pages/Welcome/welcome.dart';
import 'package:money_management/features/presentation/pages/wrapper.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Money Management',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      // home: const WelcomePage(),
      initialRoute: '/',
      routes: {
        '/welcome': (context)=> WelcomePage(),
        '/': (context) => Wrapper(),
        '/addTrans': (context) => AddTrans()
      },
    );
  }
}
