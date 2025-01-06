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
                                'description': 'The National Glyptotheque houses an extensive collection of sculptures from ancient Greece and Rome.',
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
                                      'description': "The National Garden, a haven of tranquility in the heart of Athens, offers a welcome escape from the city's bustle. This expansive park, once the private gardens of the Greek royal family, boasts a diverse collection of flora, including exotic trees and flowers. It's a perfect spot for a leisurely stroll, a picnic, or simply relaxing amidst the greenery.",
                                      'location': 'Leof. Vasileos Konstantinou 50, Athina 115 25, Greece',
                                      'distance': '1.9 kilometers away!',
                                      'what to do': 'You can stroll through the gardens, enjoy the greenery, visit the small zoo, or even have a picnic.',
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
                                      'description': "Start a new series. I'd suggest the new Netflix series, 'The Lincoln Lawyer.' This thrilling legal drama follows Mickey Haller, a charismatic defense attorney who operates out of the back of his Lincoln Town Car. 1  As he takes on high-profile cases across Los Angeles, Mickey navigates a web of corruption, deceit, and danger. 2  With each case, the stakes get higher, and Mickey must use all his wit and cunning to defend his clients and expose the truth.",
                                      'location': 'Your Living Room',
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
                                      'description': "The Peace and Friendship Stadium, also known as the Olympic Stadium, is a beautiful place for a bike ride. It's located in Nea Filadelfia, Athens, and is easily accessible by bike. The stadium is surrounded by a large park with plenty of space to ride and explore. You can also enjoy the views of the stadium and the surrounding area.",
                                      'location': 'Leof. Posidonos 36, Nea Filadelfia, Athens, Greece',
                                      'distance': '13 kilometers away',
                                      'what to do': "The stadium is located on the coast, so you can enjoy beautiful views of the Aegean Sea as you ride. The park surrounding the stadium is a great place to explore. There are many different types of trees and flowers, as well as a small lake.",
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
