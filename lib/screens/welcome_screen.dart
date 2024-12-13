import 'package:flutter/material.dart';
import 'login.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
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
        child: Column(
          children: [
            const SizedBox(height: 80),
            // App Title
            const Align(
              alignment: Alignment.center,
              child: Text(
                'Journito',
                style: TextStyle(
                  fontFamily: 'Cursive',
                  fontSize: 48,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFFC09B80),
                ),
              ),
            ),
            const Spacer(),
            // Welcome Message
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                'Welcome to Journito, your personal journaling and task management app.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.white,
                ),
              ),
            ),
            const SizedBox(height: 40),
            // Log In Button
            SizedBox(
              width: 200,
              height: 60,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xffc9a77a),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const LoginScreen()),
                  );
                },
                child: const Text(
                  'Log In',
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            const Spacer(),
          ],
        ),
      ),
    );
  }
}
