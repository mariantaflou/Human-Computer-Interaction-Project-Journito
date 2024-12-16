import 'package:flutter/material.dart';

class TasksScreen extends StatelessWidget {
  const TasksScreen({super.key});

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
                const SizedBox(width: 56), // Empty space for balance
                GestureDetector(
                  onTap: () {
                    Navigator.pushNamedAndRemoveUntil(
                      context,
                      '/home', // Navigate to HomeScreen
                      (Route<dynamic> route) => false, // Clear all routes
                    );
                  },
                  child: const Text(
                    'Journito',
                    style: TextStyle(
                      fontFamily: 'Cursive',
                      fontSize: 34,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFFC09B80),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 16),
                  child: CircleAvatar(
                    radius: 20,
                    backgroundColor: Colors.white,
                    child: IconButton(
                      icon: const Icon(Icons.person, color: Colors.grey),
                      onPressed: () {
                        // Navigate to Profile Screen
                      },
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            // Today's Tasks Header
            const Text(
              "Today's Tasks",
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 20),
            // Task Buttons List with Rounded Top Corners
            Expanded(
              child: Container(
                decoration: const BoxDecoration(
                  color: Color(0xff52717b), // Background color
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30), // Rounded top-left corner
                    topRight: Radius.circular(30), // Rounded top-right corner
                  ),
                ),
                child: ListView(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  children: const [
                    TaskButton(task: 'Call Mom'),
                    TaskButton(task: 'Water the Flowers'),
                    TaskButton(task: 'Go to Bank'),
                    TaskButton(task: 'Finish Homework'),
                    TaskButton(task: 'Read a Book'),
                    TaskButton(task: 'Buy Groceries'),
                    TaskButton(task: 'Schedule Appointment'),
                    TaskButton(task: 'Walk the Dog'),
                    TaskButton(task: 'Call Kostis'),
                    TaskButton(task: 'Send email to professor')
                  ],
                ),
              ),
            ),
            // Bottom Buttons (Add Task and AI Button)
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Add Task Button
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: CircleAvatar(
                    radius: 25,
                    backgroundColor: Colors.white,
                    child: IconButton(
                      icon: const Icon(Icons.add, size: 30, color: Colors.grey),
                      onPressed: () {
                        // Add Task Functionality
                      },
                    ),
                  ),
                ),
                // AI Button
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, '/ai_chat');
                    },
                    child: Container(
                      width: 50,
                      height: 50,
                      decoration: BoxDecoration(
                        color: const Color(0xffc9a77a),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: const Center(
                        child: Text(
                          'AI',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                            color: Color(0xff2d4d4e),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class TaskButton extends StatelessWidget {
  final String task;

  const TaskButton({super.key, required this.task});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 20),
      decoration: BoxDecoration(
        color: const Color(0xffc09b80),
        borderRadius: BorderRadius.circular(30),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Center(
              child: Text(
                task,
                style: const TextStyle(
                  fontSize: 22,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          const Icon(
            Icons.keyboard_arrow_down,
            color: Colors.white,
            size: 28,
          ),
        ],
      ),
    );
  }
}

