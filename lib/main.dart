// main.dart
import 'package:flutter/material.dart';
import 'package:car_app/home_screen.dart';
import 'package:car_app/list_screen.dart';
import 'package:car_app/list_screen2.dart';
import 'package:car_app/map_screen.dart';

void main() async {
  runApp(Main());
}

class Main extends StatefulWidget {
  @override
  _MainState createState() => _MainState();
}

class _MainState extends State<Main> {
  int _currentIndex = 0;

  final List<Widget> _pages = [
    HomeScreen(),
    ListScreen(),
    ListScreen2(),
    MapScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Car App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: Text('Car App'),
          backgroundColor: Colors.black87,
        ),
        body: _pages[_currentIndex],
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: _currentIndex,
          onTap: (index) {
            setState(() {
              _currentIndex = index;
            });
          },
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home',
              backgroundColor: Colors.black87,
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.local_gas_station),
              label: 'Entries',
              backgroundColor: Colors.black87,
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.build),
              label: 'Entries',
              backgroundColor: Colors.black87,
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.map),
              label: 'Map',
              backgroundColor: Colors.black87,
            ),
          ],
        ),
      ),
    );
  }
}
