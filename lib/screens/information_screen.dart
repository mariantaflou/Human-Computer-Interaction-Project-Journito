import 'package:flutter/material.dart';
import '../widgets/ai_button.dart';

class InformationScreen extends StatelessWidget {
  const InformationScreen({super.key});

  Widget _buildSection(String title, String? content) {
    if (content == null || content.isEmpty) {
      return const SizedBox.shrink();
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 18,
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 10),
        Text(
          content,
          style: const TextStyle(
            fontSize: 16,
            color: Colors.white,
          ),
        ),
        const SizedBox(height: 20),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final Map<String, String> experienceData =
    ModalRoute.of(context)?.settings.arguments as Map<String, String>;
    final title = experienceData['title'] ?? 'Experience';
    final description = experienceData['description'];
    final location = experienceData['location'];
    final todo = experienceData['what to do'];
    final distance = experienceData['distance'];
    final screenWidth = MediaQuery.of(context).size.width;
    final containerWidth = screenWidth * 0.8; // 80% of screen width

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
            // Header with Journito
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(width: 56), // Balances layout
                GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, '/home');
                  },
                  child: const Text(
                    'Journito',
                    style: TextStyle(
                      fontFamily: 'Cursive',
                      fontSize: 45,
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
                        // Navigate to Profile screen if needed
                      },
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 50),
            // Main Content Area
            Expanded(
              child: Container(
                decoration: const BoxDecoration(
                  color: Color(0xff52717B),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(45),
                    topRight: Radius.circular(45),
                  ),
                ),
                child: Column(
                  children: [
                    const SizedBox(height: 20),
                    // Title
                    Text(
                      title,
                      style: const TextStyle(
                        fontSize: 28,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 20),
                    // Scrollable Information Container
                    Expanded(
                      child: SingleChildScrollView(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: SizedBox( // Add SizedBox to fix the width
                            width: 400, // Set the fixed width
                            child: Container(
                              padding: const EdgeInsets.all(20),
                              decoration: BoxDecoration(
                                color: const Color(0xff6A838B),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  _buildSection('Information:', description),
                                  _buildSection('Distance:', distance),
                                  _buildSection('Location:', location),
                                  _buildSection('What to do:', todo),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    // Bottom Buttons
                    Padding(
                      padding: const EdgeInsets.only(bottom: 0, left: 16.0, right: 0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          // Done Button
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xffc9a77a),
                              padding: const EdgeInsets.symmetric(
                                  vertical: 15, horizontal: 30),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30),
                              ),
                            ),
                            onPressed: () {
                              Navigator.pushNamed(context, '/experiences');
                            },
                            child: const Text(
                              'Explore more',
                              style: TextStyle(fontSize: 16, color: Color(0xff2d4d4e)),
                            ),
                          ),
                          // AI Button
                          buildAIButton(context),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}