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
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'Journito',
                  style: TextStyle(
                    fontFamily: 'Cursive',
                    fontSize: 34, // Slightly larger
                    fontWeight: FontWeight.bold,
                    color: Color(0xFFC09B80),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            // Today's Tasks Header
            const Text(
              "Today's Tasks",
              style: TextStyle(
                fontSize: 32, // Larger Header
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 20),
            // Task List with More Tasks
            Expanded(
              child: ListView(
                children: const [
                  TaskRow(task: 'Call Mom'),
                  TaskRow(task: 'Water the Flowers'),
                  TaskRow(task: 'Go to Bank'),
                  TaskRow(task: 'Finish Flutter Project'),
                  TaskRow(task: 'Buy Groceries'),
                  TaskRow(task: 'Prepare for Meeting'),
                  TaskRow(task: 'Clean the House'),
                  TaskRow(task: 'Read a Book'),
                  TaskRow(task: 'Plan Vacation'),
                  TaskRow(task: 'Exercise for 30 Minutes'),
                  TaskRow(task: 'Cook Dinner'),
                ],
              ),
            ),
            // Bottom Buttons: "+" (Left) and AI (Right)
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // "+" Button on Bottom Left
                  CircleAvatar(
                    radius: 28, // Bigger Button
                    backgroundColor: const Color(0xffc9a77a),
                    child: IconButton(
                      icon: const Icon(Icons.add, size: 32, color: Colors.white),
                      onPressed: () {
                        // Add Task Functionality
                      },
                    ),
                  ),
                  // AI Button on Bottom Right
                  GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, '/ai_chat');
                    },
                    child: Container(
                      width: 60,
                      height: 60,
                      decoration: BoxDecoration(
                        color: const Color(0xffc9a77a),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: const Center(
                        child: Text(
                          'AI',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                            color: Color(0xff2d4d4e),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// TaskRow: Task Bar + Down Arrow
class TaskRow extends StatelessWidget {
  final String task;

  const TaskRow({super.key, required this.task});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
      padding: const EdgeInsets.symmetric(vertical: 10),
      decoration: BoxDecoration(
        color: const Color(0xffc09b80),
        borderRadius: BorderRadius.circular(30),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center, // Center the content
        children: [
          Text(
            task,
            style: const TextStyle(
              fontSize: 24, // Bigger Task Text
              color: Colors.white,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(width: 8), // Space between text and arrow
          const Icon(
            Icons.keyboard_arrow_down, // Down Arrow
            color: Colors.white,
            size: 28,
          ),
        ],
      ),
    );
  }
}
