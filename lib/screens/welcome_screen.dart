import 'package:flutter/material.dart';
import 'login.dart';

class WelcomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Gradient background
          Container(
            width: double.infinity, // Takes the full width of the screen
            height: double.infinity, // Takes the full height of the screen
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Color(0xff1f3f42),
                  Color(0xff2d4d4e),
                  Color(0xff52717b),
                ],
              ),
            ),
          ),
          // "Journito" text centered within the screen
          Positioned(
            top: MediaQuery.of(context).size.height * 0.3, // Centered vertically
            left: 40,
            child: Text(
              "Journito",
              style: TextStyle(
                fontSize: 70,
                fontFamily: 'Mervale Script', // Use Mervale Script font
                color: Color(0xFFE0A28E), // Set the color to #E0A28E
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
          // Log in button at the bottom of the screen
          Positioned(
            bottom: 50, // Adjust the distance from the bottom
            left: 30,
            right: 30,
            child: ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => LoginScreen()),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blueAccent, // Button color
                padding: EdgeInsets.symmetric(horizontal: 40, vertical: 12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
              child: Text(
                'Log In',
                style: TextStyle(fontSize: 18),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
