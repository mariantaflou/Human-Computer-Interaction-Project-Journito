import 'package:flutter/material.dart';
import 'package:journito/screens/information_screen.dart';
//import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'screens/welcome_screen.dart';
import 'screens/ai_chat.dart';
import 'screens/calendar.dart';
import 'screens/home_screen.dart';
import 'screens/journaling.dart';
import 'screens/login.dart';
import 'screens/tasks_screen.dart';
import 'screens/experiences_screen.dart';

void main() async {
  //WidgetsFlutterBinding.ensureInitialized();
  //await dotenv.load();
  //final apiKey = dotenv.env['GEMINI_API_KEY'];
  //print('Loaded API Key: $apiKey'); // Check the value of apiKey
  //if (apiKey == null || apiKey.isEmpty) {
  //  print('Error: GEMINI_API_KEY is not set in the .env file.');
  //}
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
      initialRoute: '/',
      routes: {
      '/': (context) => const WelcomeScreen(),
      '/login': (context) => const LoginScreen(),
      '/home': (context) => const HomeScreen(),
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
