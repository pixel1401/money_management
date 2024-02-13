import 'package:flutter/material.dart';
import 'package:money_management/features/presentation/pages/Auth/auth.dart';
import 'package:money_management/features/presentation/pages/Home/home.dart';
import 'package:money_management/features/presentation/pages/Transaction/transaction.dart';
import 'package:money_management/features/presentation/widgets/bottom_navigation_bar.dart';

class Wrapper extends StatefulWidget {
  const Wrapper({super.key});

  @override
  State<Wrapper> createState() => _WrapperState();
}

class _WrapperState extends State<Wrapper> {
  int selectIndex = 0;

  void handleBottomWrap(int index) {
    setState(() => {selectIndex = index});
    switch (selectIndex) {
      case 3:
        Navigator.popAndPushNamed(context, '/welcome');
        break;
    
      default:
    }
  }

  List pages = const [
    HomePage(),
    Transaction(),
    HomePage(),
    HomePage(),
    AuthPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          constraints:
              BoxConstraints(maxHeight: MediaQuery.of(context).size.height),
          child: pages[selectIndex] ?? const HomePage(),
        ),
      ),
      bottomNavigationBar: BottomNavigationBarWrap(
          selectedIndex: selectIndex, onItemTapped: handleBottomWrap),
    );
  }
}
