import 'package:flutter/material.dart';
import 'package:money_management/core/helpers/helpers.dart';

class BottomNavigationBarWrap extends StatelessWidget {
  final int selectedIndex;
  final void Function(int)? onItemTapped;
  const BottomNavigationBarWrap({super.key,  required this.selectedIndex , this.onItemTapped});

  @override
  Widget build(BuildContext context) {
    return  BottomNavigationBar(
      backgroundColor: Colors.white,
      selectedItemColor: Colors.amber[800],
      unselectedItemColor: Colors.black,
        items:  <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
            
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.currency_exchange),
            label: 'Transaction',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.auto_graph_sharp),
            label: 'Statitics',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.first_page),
            label: 'Welcome',
          ),
        ],
        currentIndex: selectedIndex,
        onTap: onItemTapped,
      );
  }
}