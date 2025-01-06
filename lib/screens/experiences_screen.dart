import 'package:flutter/material.dart';

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
            Padding(
              padding: const EdgeInsets.only(top: 40),
              child: Center(
                child: GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
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
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              'Find Experiences',
              style: TextStyle(
                fontSize: 22,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 10),
            Expanded(
              child: Container(
                decoration: const BoxDecoration(
                  color: Color(0xff52717b),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30),
                  ),
                ),
                padding: const EdgeInsets.fromLTRB(40, 20, 40, 0),
                child: Column(
                  children: [
                    _buildExperienceButton(
                      context,
                      label: 'Visit the Art Museum',
                      isLarge: true,
                      experienceData: {
                        'title': 'Visit the Art Museum',
                        'description': 'Explore timeless works of art and sculptures.',
                        'location': 'City Art Museum',
                        'date': 'January 15, 2025',
                      },
                    ),
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
            Padding(
              padding: const EdgeInsets.all(16),
              child: Align(
                alignment: Alignment.bottomRight,
                child: GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, '/ai_chat');
                  },
                  child: Container(
                    width: 60,
                    height: 60,
                    decoration: const BoxDecoration(
                      color: Color(0xffc9a77a),
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(15),
                        topRight: Radius.circular(15),
                        bottomLeft: Radius.circular(15),
                        bottomRight: Radius.circular(5),
                      ),
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
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildExperienceButton(
      BuildContext context, {
        required String label,
        required bool isLarge,
        required Map<String, String> experienceData,
      }) {
    return SizedBox(
      height: isLarge ? 120 : 100,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xffCDA68A),
          padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(30),
              topRight: Radius.circular(30),
              bottomLeft: Radius.circular(30),
              bottomRight: Radius.circular(5),
            ),
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
          style: const TextStyle(
            fontSize: 18,
            color: Colors.white,
          ),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
