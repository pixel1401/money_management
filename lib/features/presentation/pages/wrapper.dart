import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:money_management/features/presentation/widgets/bottom_navigation_bar.dart';

class Wrapper extends StatefulWidget {
  final Widget child;
  const Wrapper({super.key, required this.child});

  @override
  State<Wrapper> createState() => _WrapperState();
}

class _WrapperState extends State<Wrapper> {
  int selectIndex = 0;

  void handleBottomWrap(int index) {
    setState(() => {selectIndex = index});
    switch (selectIndex) {
      case 1:
        context.go('/');
        break;
      case 2:
        context.go('/');
        break;
      case 3:
        context.go('/welcome');
        break;
      case 4:
        context.go('/auth');
      default:
    }
  }

  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          constraints:
              BoxConstraints(maxHeight: MediaQuery.of(context).size.height),
          child: widget.child,
        ),
      ),
      bottomNavigationBar: BottomNavigationBarWrap(
          selectedIndex: selectIndex, onItemTapped: handleBottomWrap),
    );
  }
}
