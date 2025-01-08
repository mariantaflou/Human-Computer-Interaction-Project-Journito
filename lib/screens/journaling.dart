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
  List<File> _attachedImages = [];
  //DateTime _currentDate = DateTime.now();
  late DateTime _currentDate;
  bool _initialized = false;

  @override
  void initState() {
    super.initState();
    _currentDate = DateTime.now(); // Set default value
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!_initialized) {
      final args = ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;
      _currentDate = args?['selectedDate'] ?? DateTime.now();
      _loadJournalEntry();
      _initialized = true;
    }
  }

  Future<void> _loadJournalEntry() async {
    final prefs = await SharedPreferences.getInstance();
    final key = _formattedDate();
    final savedContent = prefs.getString('${key}_text') ?? '';
    final savedImages = prefs.getStringList('${key}_images') ?? [];

    setState(() {
      _textController.text = savedContent;
      _attachedImages = savedImages.map((path) => File(path)).toList();
    });
    await _cleanupEmptyJournal();
  }

  Future<void> _saveJournal() async {
    final prefs = await SharedPreferences.getInstance();
    final key = _formattedDate();

    // Check if content is empty
    bool hasContent = _textController.text.trim().isNotEmpty || _attachedImages.isNotEmpty;

    // Get current logged dates
    List<String> loggedDates = prefs.getStringList('logs') ?? [];

    if (hasContent) {
      // Save the content
      await prefs.setString('${key}_text', _textController.text);

      final imagePaths = _attachedImages.map((image) => image.path).toList();
      await prefs.setStringList('${key}_images', imagePaths);

      // Add date to logs if not already present
      if (!loggedDates.contains(key)) {
        loggedDates.add(key);
        await prefs.setStringList('logs', loggedDates);
      }
    } else {
      // Content is empty, remove all traces of the journal entry
      await prefs.remove('${key}_text');
      await prefs.remove('${key}_images');

      // Remove date from logs if present
      if (loggedDates.contains(key)) {
        loggedDates.remove(key);
        await prefs.setStringList('logs', loggedDates);
      }
    }

    Navigator.pop(context);
  }

  Future<void> _cleanupEmptyJournal() async {
    final prefs = await SharedPreferences.getInstance();
    final key = _formattedDate();

    // Get text and images for current date
    final savedText = prefs.getString('${key}_text') ?? '';
    final savedImages = prefs.getStringList('${key}_images') ?? [];

    // If both are empty, remove the date from logs
    if (savedText.trim().isEmpty && savedImages.isEmpty) {
      List<String> loggedDates = prefs.getStringList('logs') ?? [];
      if (loggedDates.contains(key)) {
        loggedDates.remove(key);
        await prefs.setStringList('logs', loggedDates);
        await prefs.remove('${key}_text');
        await prefs.remove('${key}_images');
      }
    }
  }

  String _formattedDate() {
    return '${_currentDate.year}-${_currentDate.month.toString().padLeft(2, '0')}-${_currentDate.day.toString().padLeft(2, '0')}';
  }

  void _navigateToPreviousDate() {
    setState(() {
      _currentDate = _currentDate.subtract(const Duration(days: 1));
      _loadJournalEntry();
    });
  }

  void _navigateToNextDate() {
    setState(() {
      _currentDate = _currentDate.add(const Duration(days: 1));
      _loadJournalEntry();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
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
          child: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  constraints: const BoxConstraints(minHeight: 200),
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
                if (_attachedImages.isNotEmpty)
                  Container(
                    height: 150,
                    margin: const EdgeInsets.symmetric(vertical: 8),
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: _attachedImages.length,
                      itemBuilder: (context, index) {
                        return Stack(
                          children: [
                            Container(
                              margin: const EdgeInsets.symmetric(horizontal: 8),
                              width: 150,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: Image.file(
                                  _attachedImages[index],
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            Positioned(
                              top: 5, // Adjust the position to center the smaller icon
                              right: 10,
                              child: Container(
                                width: 20, // Reduced circle size
                                height: 20,
                                decoration: BoxDecoration(
                                  color: Colors.black.withOpacity(0.5),
                                  shape: BoxShape.circle,
                                ),
                                child: IconButton(
                                  padding: EdgeInsets.zero, // Remove padding
                                  icon: const Icon(
                                    Icons.close,
                                    color: Colors.white,
                                    size: 14, // Smaller "X" size
                                  ),
                                  onPressed: () => _removeImage(index),
                                ),
                              ),
                            ),
                          ],
                        );
                      },
                    ),
                  ),
                Align(
                  alignment: Alignment.centerRight,
                  child: IconButton(
                    onPressed: _attachPicture,
                    icon: const Icon(
                      Icons.attach_file,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _removeImage(int index) {
    setState(() {
      _attachedImages.removeAt(index);
    });
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
              Navigator.pushNamed(context, '/calendar');
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
          buildAIButton(context),
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
        _attachedImages.add(File(pickedImage.path));
      });
    }
  }
}
