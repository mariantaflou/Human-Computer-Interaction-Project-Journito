import 'package:flutter/material.dart';

class PreferencesScreen extends StatelessWidget {
  final List<String> preferences = [
    'History and Culture',
    'Arts and Creativity',
    'Outdoor Activities',
    'Technology and Innovation',
    'Food and Drink',
    'Music and Performance',
    'Painting and Visual Arts',
    'Museums',
    'Movies',
    'Sports',
    'Adventure and Travel',
    'Fitness and Wellness',
    'Photography',
    'Gaming',
    'Reading and Writing',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xff335e5b),
              Color(0xff4d7572),
            ],
          ),
        ),
        child: Column(
          children: [
            const SizedBox(height: 60),
            // Header
            const Text(
              'What do you like?',
              style: TextStyle(
                fontFamily: 'Mervale Script',
                fontSize: 30,
                fontWeight: FontWeight.bold,
                color: Color(0xffE0A28E),
              ),
            ),
            const SizedBox(height: 20),
            // Preferences List
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color: const Color(0xff4a6764), // Greenish background
                  borderRadius: BorderRadius.circular(30),
                ),
                margin: const EdgeInsets.symmetric(horizontal: 16),
                padding: const EdgeInsets.all(16),
                child: ListView.builder(
                  itemCount: preferences.length,
                  itemBuilder: (context, index) {
                    return PreferenceOption(label: preferences[index]);
                  },
                ),
              ),
            ),
            // Check Button
            Padding(
              padding: const EdgeInsets.all(16),
              child: GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, '/home');
                },
                child: Container(
                  width: 60,
                  height: 60,
                  decoration: const BoxDecoration(
                    color: Color(0xffc9a77a),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.check,
                    size: 30,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class PreferenceOption extends StatefulWidget {
  final String label;

  const PreferenceOption({Key? key, required this.label}) : super(key: key);

  @override
  _PreferenceOptionState createState() => _PreferenceOptionState();
}

class _PreferenceOptionState extends State<PreferenceOption> {
  bool isSelected = false;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(vertical: 5),
      leading: GestureDetector(
        onTap: () {
          setState(() {
            isSelected = !isSelected;
          });
        },
        child: Container(
          width: 24,
          height: 24,
          decoration: BoxDecoration(
            color: isSelected ? const Color(0xffc9a77a) : Colors.transparent,
            border: Border.all(
              color: const Color(0xffc9a77a),
              width: 2,
            ),
            borderRadius: BorderRadius.circular(6), // Smooth corners
          ),
          child: isSelected
              ? const Icon(
            Icons.check,
            color: Colors.white,
            size: 16,
          )
              : null,
        ),
      ),
      title: Text(
        widget.label,
        style: const TextStyle(
          fontSize: 18,
          color: Colors.white,
        ),
      ),
      onTap: () {
        setState(() {
          isSelected = !isSelected;
        });
      },
    );
  }
}
