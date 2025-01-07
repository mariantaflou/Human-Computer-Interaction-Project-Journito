import 'package:flutter/material.dart';
import '../widgets/ai_button.dart';

class HomeScreen extends StatefulWidget {  // Changed to StatefulWidget
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  DateTime _currentDate = DateTime.now();  // Add current date

  // Add date formatting helper methods
  String _dayOfWeek(int day) {
    const days = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
    return days[day - 1];
  }

  String _monthOfYear(int month) {
    const months = [
      'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun',
      'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'
    ];
    return months[month - 1];
  }

  // Add navigation methods
  void _navigateToPreviousDate() {
    setState(() {
      _currentDate = _currentDate.subtract(const Duration(days: 1));
    });
  }

  void _navigateToNextDate() {
    setState(() {
      _currentDate = _currentDate.add(const Duration(days: 1));
    });
  }

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
            const SizedBox(height: 40),
            // Logo and Profile Picture
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(width: 56),
                const Text(
                  'Journito',
                  style: TextStyle(
                    fontFamily: 'Cursive',
                    fontSize: 45,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFFC09B80),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 16),
                  child: CircleAvatar(
                    radius: 20,
                    backgroundColor: Colors.white,
                    child: IconButton(
                      icon: const Icon(
                        Icons.person,
                        color: Colors.grey,
                      ),
                      onPressed: () {
                        // Navigate to Profile screen if needed
                      },
                    ),
                  ),
                ),
              ],
            ),
            const Spacer(),
            // Updated Date Navigation
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  icon: const Icon(Icons.chevron_left, color: Colors.white),
                  onPressed: _navigateToPreviousDate,
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, '/calendar');
                  },
                  child: Text(
                    '${_dayOfWeek(_currentDate.weekday)}, ${_currentDate.day} ${_monthOfYear(_currentDate.month)} ${_currentDate.year}',
                    style: const TextStyle(
                      fontSize: 22,
                      color: Colors.white,
                    ),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.chevron_right, color: Colors.white),
                  onPressed: _navigateToNextDate,
                ),
              ],
            ),
            const SizedBox(height: 20),
            // Rest of the widgets remain the same
            GestureDetector(
              onTap: () {
                Navigator.pushNamed(context, '/journaling');
              },
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                margin: const EdgeInsets.symmetric(horizontal: 40),
                decoration: BoxDecoration(
                  color: const Color(0xff4d6d6d),
                  borderRadius: BorderRadius.circular(27),
                ),
                child: const Center(
                  child: Text(
                    'How was your day?',
                    style: TextStyle(
                      fontSize: 32,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 40),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                SizedBox(
                  width: 180,
                  height: 200,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xffc9a77a),
                      padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                    onPressed: () {
                      Navigator.pushNamed(context, '/tasks');
                    },
                    child: const Text(
                      "Today's Tasks",
                      style: TextStyle(
                        fontSize: 25,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  width: 180,
                  height: 200,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xffc9a77a),
                      padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                    onPressed: () {
                      Navigator.pushNamed(context, '/experiences');
                    },
                    child: const Text(
                      "Find\nExperiences",
                      style: TextStyle(
                        fontSize: 25,
                        color: Colors.white,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ],
            ),
            const Spacer(),
            buildAIButton(context),
          ],
        ),
      ),
    );
  }
}