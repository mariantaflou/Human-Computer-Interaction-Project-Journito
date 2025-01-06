import 'package:flutter/material.dart';
import '../widgets/ai_button.dart';

class ExperiencesScreen extends StatelessWidget {
  const ExperiencesScreen({super.key});

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
            // Title and Profile Icon
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(width: 56), // Balances layout
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
            // Find Experiences Area
            Expanded(
              child: Container(
                decoration: const BoxDecoration(
                  color: Color(0xff52717B),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(45),
                    topRight: Radius.circular(45),
                    bottomLeft: Radius.zero, // Set bottom-left to 0
                    bottomRight: Radius.zero, // Set bottom-right to 0
                  ),
                ),
                child: Column(
                  children: [
                    const Padding(
                      padding: EdgeInsets.symmetric(vertical: 16),
                      child: Text(
                        'Find Experiences',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        decoration: const BoxDecoration(
                          color: Color(0xff52717b),
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(30),
                            topRight: Radius.circular(30),
                          ),
                        ),
                        padding: const EdgeInsets.fromLTRB(20, 40, 20, 0),
                        child: Column(
                          children: [
                            _buildExperienceButton(
                              context,
                              label: 'Visit the Art Museum',
                              isLarge: true,
                              experienceData: {
                                'title': 'Visit the Art Museum',
                                'description': 'It houses an extensive collection of sculptures from ancient Greece and Rome.',
                                'location': 'Leof. Panagioti Kanellopoulou, Athina 115 25, Greece',
                                'distance': '2.2 kilometers away!',
                                'what to do': 'You can explore different exhibits, learn about ancient art and culture, and admire the beautiful sculptures.',
                              },
                            ),
                            const SizedBox(height: 30),
                            Row(
                              children: [
                                Expanded(
                                  child: _buildExperienceButton(
                                    context,
                                    label: 'Walk at the nearest Park',
                                    isLarge: false,
                                    experienceData: {
                                      'title': 'Park Walk',
                                      'description': 'Take a refreshing walk surrounded by nature.',
                                      'location': 'Green Meadows Park',
                                      'date': 'January 12, 2025',
                                    },
                                  ),
                                ),
                                const SizedBox(width: 20),
                                Expanded(
                                  child: _buildExperienceButton(
                                    context,
                                    label: 'Watch Netflix',
                                    isLarge: false,
                                    experienceData: {
                                      'title': 'Netflix Binge',
                                      'description': 'Catch up on your favorite series and movies.',
                                      'location': 'Your Living Room',
                                      'date': 'Anytime',
                                    },
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 30),
                            Row(
                              children: [
                                Expanded(
                                  child: _buildExperienceButton(
                                    context,
                                    label: 'Ride a Bike',
                                    isLarge: false,
                                    experienceData: {
                                      'title': 'Bike Ride',
                                      'description': 'Enjoy a fun and adventurous bike ride.',
                                      'location': 'Hillside Trail',
                                      'date': 'January 18, 2025',
                                    },
                                  ),
                                ),
                                const SizedBox(width: 20),
                                Expanded(
                                  child: _buildExperienceButton(
                                    context,
                                    label: 'Continue the Puzzle',
                                    isLarge: false,
                                    experienceData: {
                                      'title': 'Puzzle Time',
                                      'description': 'Relax and solve a challenging puzzle.',
                                      'location': 'Your Cozy Corner',
                                      'date': 'Anytime',
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    // AI Button
                    buildAIButton(context),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildExperienceButton(BuildContext context, {
    required String label,
    required bool isLarge,
    required Map<String, String> experienceData,
  }) {
    return SizedBox(
      // Adjusted height for both large and small buttons
      height: isLarge ? 100 : 85,
      // Reduced height difference between large and small buttons
      width: double.infinity,
      // Makes buttons take full available width
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xffc9a77a),
          padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
        ),
        onPressed: () {
          Navigator.pushNamed(
            context,
            '/information',
            arguments: experienceData,
          );
        },
        child: Text(
          label,
          style: TextStyle(
            fontSize: isLarge ? 25 : 18, // Slightly larger text for main button
            color: Colors.white,
          ),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
