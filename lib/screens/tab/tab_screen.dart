import 'package:banking_app/screens/tab/history/history_screen.dart';
import 'package:banking_app/screens/tab/home/home_screen.dart';
import 'package:banking_app/screens/tab/profile/profile_screen.dart';
import 'package:banking_app/screens/tab/transfer/transfer_screen.dart';
import 'package:flutter/material.dart';

import 'card/card_screen.dart';

class TabScreen extends StatefulWidget {
  const TabScreen({super.key});

  @override
  _TabScreenState createState() => _TabScreenState();
}

class _TabScreenState extends State<TabScreen> {
  int _selectedTabIndex = 0;

  final _pages = [
    HomeScreen(),
    CardScreen(),
    HistoryScreen(),
    ProfileScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedTabIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        shape: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        onPressed: () {
Navigator.push(context, MaterialPageRoute(builder: (context) => TransferScreen()));
        },
        backgroundColor: Colors.deepPurpleAccent,
        child: Icon(Icons.currency_exchange),
      ),
      backgroundColor: Colors.lightBlue,
      body: Center(
        child: _pages.elementAt(_selectedTabIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        unselectedItemColor: Colors.grey,
        selectedItemColor: Colors.black,
        type: BottomNavigationBarType.fixed,
        iconSize: 30,
        backgroundColor: Colors.deepPurple,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.credit_card_outlined), label: 'Card'),
          BottomNavigationBarItem(icon: Icon(Icons.history), label: 'History'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
        ],
        currentIndex: _selectedTabIndex,
        onTap: _onItemTapped,
      ),
    );
  }
}
