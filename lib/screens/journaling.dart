import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:shared_preferences/shared_preferences.dart';
import '../widgets/ai_button.dart';

class JournalingScreen extends StatefulWidget {
  const JournalingScreen({Key? key}) : super(key: key);

  @override
  _JournalingScreenState createState() => _JournalingScreenState();
}

class _JournalingScreenState extends State<JournalingScreen> {
  final TextEditingController _textController = TextEditingController();
  File? _attachedImage;
  DateTime _currentDate = DateTime.now(); // Initialize with today's date

  @override
  void initState() {
    super.initState();
    _loadJournalEntry();
  }

  // Load journal entry for the current date
  Future<void> _loadJournalEntry() async {
    final prefs = await SharedPreferences.getInstance();
    final key = _formattedDate();
    final savedContent = prefs.getString(key) ?? '';
    setState(() {
      _textController.text = savedContent;
    });
  }

  // Save the journal entry
  Future<void> _saveJournal() async {
    final prefs = await SharedPreferences.getInstance();
    final key = _formattedDate();
    await prefs.setString(key, _textController.text);
  }

  // Format the date as a string key
  String _formattedDate() {
    return '${_currentDate.year}-${_currentDate.month.toString().padLeft(2, '0')}-${_currentDate.day.toString().padLeft(2, '0')}';
  }

  // Navigate to the previous date
  void _navigateToPreviousDate() {
    setState(() {
      _currentDate = _currentDate.subtract(const Duration(days: 1));
      _loadJournalEntry();
    });
  }

  // Navigate to the next date
  void _navigateToNextDate() {
    setState(() {
      _currentDate = _currentDate.add(const Duration(days: 1));
      _loadJournalEntry();
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
              Color(0xff52717B),
              Color(0xff52717B),
            ],
          ),
        ),
        child: Column(
          children: [
            const SizedBox(height: 40),
            _buildTitle(context),
            const SizedBox(height: 20),
            _buildDateSection(context),
            const SizedBox(height: 20),
            _buildButtonRow(context),
            const SizedBox(height: 20),
            _buildJournalingFrame(context),
            _buildBottomButtonRow(context),
          ],
        ),
      ),
    );
  }

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

  Widget _buildDateSection(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        IconButton(
          onPressed: _navigateToPreviousDate,
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
            '${_dayOfWeek(_currentDate.weekday)}, ${_currentDate.day} ${_monthOfYear(_currentDate.month)} ${_currentDate.year}',
            style: const TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        IconButton(
          onPressed: _navigateToNextDate,
          icon: const Icon(
            Icons.arrow_forward_ios,
            color: Colors.white,
          ),
        ),
      ],
    );
  }

  Widget _buildButtonRow(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        _buildButton(context, 'Find Experiences', '/experiences'),
        _buildButton(context, "Today's Tasks", '/tasks'),
      ],
    );
  }

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
              if (_attachedImage != null)
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Image.file(
                    _attachedImage!,
                    fit: BoxFit.contain,
                  ),
                ),
              IconButton(
                onPressed: _attachPicture,
                icon: const Icon(
                  Icons.attach_file,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildBottomButtonRow(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          ElevatedButton.icon(
            onPressed: () async {
              await _saveJournal();
              Navigator.pop(context);
            },
            icon: const Icon(Icons.check, color: Color(0xff1f3f42)),
            label: const Text(
              'Finish',
              style: TextStyle(color: Color(0xff1f3f42)),
            ),
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xffc9a77a),
              minimumSize: const Size(120, 48),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(25),
              ),
            ),
          ),
          buildAIButton(context), // AI Button
        ],
      ),
    );
  }

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

  Future<void> _attachPicture() async {
    final picker = ImagePicker();
    final pickedImage = await picker.pickImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      setState(() {
        _attachedImage = File(pickedImage.path);
      });
    }
  }
}
