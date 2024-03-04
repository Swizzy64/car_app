import 'package:flutter/material.dart';
import 'package:car_app/input_screen.dart'; // Import the input page
import 'package:car_app/input_screen2.dart';
import 'package:car_app/statistics_screen.dart';

import 'package:flutter/material.dart';
import 'package:car_app/input_screen.dart'; // Import the input page
import 'package:car_app/input_screen2.dart';
import 'package:car_app/statistics_screen.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: 180.0,
              height: 180.0,
              child: Stack(
                children: [
                  ElevatedButton(
                    onPressed: () {
                      // Navigate to the input page when the button is pressed
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => InputScreen()),
                      );
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Icon(
                        Icons.local_gas_station,
                        size: 100,
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      primary: Colors.black87,
                    ),
                  ),
                  Positioned(
                    bottom: 60.0,
                    right: 28.0,
                    child: ClipOval(
                      child: Container(
                        padding: EdgeInsets.all(8.0),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.black87,
                        ),
                        child: Icon(
                          Icons.add,
                          size: 20,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              width: 180.0,
              height: 180.0,
              child: Stack(
                children: [
                  ElevatedButton(
                    onPressed: () {
                      // Navigate to the input page when the button is pressed
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => InputScreen2()),
                      );
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Icon(
                        Icons.build,
                        size: 100,
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      primary: Colors.black87,
                    ),
                  ),
                  Positioned(
                    bottom: 60.0,
                    right: 28.0,
                    child: ClipOval(
                      child: Container(
                        padding: EdgeInsets.all(8.0),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.black87,
                        ),
                        child: Icon(
                          Icons.add,
                          size: 20,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              width: 180.0,
              height: 180.0,
              child: Stack(
                children: [
                  ElevatedButton(
                    onPressed: () {
                      // Navigate to the input page when the button is pressed
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => StatisticsScreen()),
                      );
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Icon(
                        Icons.bar_chart,
                        size: 100,
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      primary: Colors.black87,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      backgroundColor: Colors.white54,
    );
  }
}
