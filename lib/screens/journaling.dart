import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import '../widgets/ai_button.dart';

class JournalingScreen extends StatefulWidget {
  const JournalingScreen({super.key});

  @override
  _JournalingScreenState createState() => _JournalingScreenState();
}

class _JournalingScreenState extends State<JournalingScreen> {
  final TextEditingController _textController = TextEditingController();
  File? _attachedImage;

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
              Color(0xff52717B),
              Color(0xff52717B),
            ],
          ),
        ),
        child: Column(
          children: [
            const SizedBox(height: 40),
            // Title
            _buildTitle(context),
            const SizedBox(height: 20),
            // Date Section
            _buildDateSection(context),
            const SizedBox(height: 20),
            // Buttons
            _buildButtonRow(context),
            const SizedBox(height: 20),
            // Journaling Frame
            _buildJournalingFrame(context),
            // Bottom Buttons
            _buildBottomButtonRow(context),
          ],
        ),
      ),
    );
  }

  // Title
  Widget _buildTitle(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamedAndRemoveUntil(
          context,
          '/home',
              (Route<dynamic> route) => false,
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
    );
  }

  // Date Section
  Widget _buildDateSection(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        IconButton(
          onPressed: () {
            // Navigate to the previous date
            _navigateToPreviousDate(context);
          },
          icon: const Icon(
            Icons.arrow_back_ios_new,
            color: Colors.white,
          ),
        ),
        GestureDetector(
          onTap: () {
            Navigator.pushNamed(context, '/calendar');
          },
          child: Text(
            _formattedDate(),
            style: const TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        IconButton(
          onPressed: () {
            // Navigate to the next date
            _navigateToNextDate(context);
          },
          icon: const Icon(
            Icons.arrow_forward_ios,
            color: Colors.white,
          ),
        ),
      ],
    );
  }

  // Button Row
  Widget _buildButtonRow(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        _buildButton(context, 'Find Experiences', '/experiences'),
        _buildButton(context, "Today's Tasks", '/tasks'),
      ],
    );
  }

  // Journaling Frame
  Widget _buildJournalingFrame(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Container(
          decoration: BoxDecoration(
            color: const Color(0xff627E87),
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.2),
                blurRadius: 4,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Column(
            children: [
              Expanded(
                child: TextField(
                  controller: _textController,
                  maxLines: null,
                  textInputAction: TextInputAction.newline,
                  decoration: const InputDecoration(
                    contentPadding: EdgeInsets.all(16),
                    hintText: 'Write your thoughts...',
                    hintStyle: TextStyle(color: Colors.white70),
                    border: InputBorder.none,
                  ),
                  style: const TextStyle(color: Colors.white),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  if (_attachedImage != null)
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Image.file(
                          _attachedImage!,
                          fit: BoxFit.contain,
                        ),
                      ),
                    ),
                  IconButton(
                    onPressed: () {
                      _attachPicture(context);
                    },
                    icon: const Icon(
                      Icons.attach_file,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Bottom Button Row
  Widget _buildBottomButtonRow(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _buildBottomButton(Icons.check, 'Finish', () {
            // Add finish editing logic
            _saveJournal();
            Navigator.pop(context);
          }),
          buildAIButton(context),  // AI Button
        ],
      ),
    );
  }

  // Button Builder
  Widget _buildButton(BuildContext context, String title, String route) {
    return ElevatedButton(
      onPressed: () {
        Navigator.pushNamed(context, route);
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color(0xffc9a77a),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(25),
        ),
        minimumSize: const Size(140, 48),
      ),
      child: Text(
        title,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 16,
        ),
      ),
    );
  }

  // Finish Button
  Widget _buildBottomButton(IconData icon, String label, VoidCallback onPressed) {
    return ElevatedButton.icon(
      onPressed: onPressed,
      icon: Icon(icon, color: const Color(0xff1f3f42)),
      label: Text(
        label,
        style: const TextStyle(color: Color(0xff1f3f42)),
      ),
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color(0xffc9a77a),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(25),
        ),
        minimumSize: const Size(120, 48),
      ),
    );
  }


  // Format Date Function
  String _formattedDate() {
    final now = DateTime.now();
    return '${_dayOfWeek(now.weekday)} ${now.day} ${_monthOfYear(now.month)} ${now.year}';
  }

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

  void _navigateToPreviousDate(BuildContext context) {
    // Add logic to navigate to the previous date
  }

  void _navigateToNextDate(BuildContext context) {
    // Add logic to navigate to the next date
  }

  void _attachPicture(BuildContext context) async {
    final picker = ImagePicker();
    final pickedImage = await picker.pickImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      setState(() {
        _attachedImage = File(pickedImage.path);
      });
    }
  }

  void _saveJournal() {
    // Save the journal entry using the _textController.text and _attachedImage
  }
}