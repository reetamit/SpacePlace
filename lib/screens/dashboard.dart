import 'package:flutter/material.dart';
import 'package:flutter_commapp/screens/Explore.dart';
import 'package:flutter_commapp/screens/home.dart';
import 'package:flutter_commapp/screens/profile.dart';
import 'package:flutter_commapp/screens/request.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({Key? key}) : super(key: key);

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  int _selectedIndex = 0;

  void navigateTo(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  final List _pages = [
    // homepage
    //HomePage(),
    ExplorePage(),

    // settings page
    RequestScreen(),

    // profile page
    ProfileFormScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //appBar: AppBar(title: Text('Dashboard')),
      body: _pages[_selectedIndex],
      appBar: AppBar(
        title: Text(
          _selectedIndex == 0
              ? 'Home'
              : _selectedIndex == 1
              ? 'Request'
              : 'Profile',
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: navigateTo,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(
            icon: Icon(Icons.request_page),
            label: 'Requests',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Settings',
          ),
        ],
      ),
    );
  }
}
