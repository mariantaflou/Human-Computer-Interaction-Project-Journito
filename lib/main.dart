import 'package:flutter/material.dart';
import 'package:journito/screens/information_screen.dart';
import 'screens/welcome_screen.dart';
import 'screens/ai_chat.dart';
import 'screens/calendar.dart';
import 'screens/home_screen.dart';
import 'screens/journaling.dart';
import 'screens/login.dart';
import 'screens/tasks_screen.dart';
import 'screens/experiences_screen.dart';
import 'screens/preferences_screen.dart'; // Import the PreferencesScreen

void main() async {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Journito App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/', // Start with the WelcomeScreen
      routes: {
        '/': (context) => const WelcomeScreen(),
        '/login': (context) => const LoginScreen(),
        '/home': (context) => const HomeScreen(),
        '/preferences': (context) => PreferencesScreen(), // New Preferences Screen route
        '/ai_chat': (context) => const ChatWithAIScreen(),
        '/tasks': (context) => const TasksScreen(),
        '/calendar': (context) => const CalendarScreen(),
        '/journaling': (context) => const JournalingScreen(),
        '/experiences': (context) => const ExperiencesScreen(),
        '/information': (context) => const InformationScreen(),
      },
    );
  }
}
