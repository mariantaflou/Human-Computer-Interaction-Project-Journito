import 'package:flutter/material.dart';
import 'screens/welcome_screen.dart';
import 'screens/login.dart'; // Import the login screen
import 'screens/home_screen.dart';
import 'screens/ai_chat.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Journito App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const WelcomeScreen(),
        '/login': (context) => const LoginScreen(),
        '/home': (context) => const HomeScreen(), // Define the home screen route
        '/ai_chat': (context) => const ChatWithAIScreen(),
      },
    );
  }
}
