import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:shared_preferences/shared_preferences.dart';
import '../widgets/ai_button.dart';

class JournalingScreen extends StatefulWidget {
  final DateTime selectedDate;

  const JournalingScreen({Key? key, required this.selectedDate}) : super(key: key);

  @override
  _JournalingScreenState createState() => _JournalingScreenState();
}

class _JournalingScreenState extends State<JournalingScreen> {
  final TextEditingController _textController = TextEditingController();
  File? _attachedImage;

  @override
  void initState() {
    super.initState();
    _loadJournalEntry();
  }

  Future<void> _loadJournalEntry() async {
    final prefs = await SharedPreferences.getInstance();
    final key = _formattedDate();
    final savedContent = prefs.getString(key) ?? '';
    _textController.text = savedContent;
  }

  Future<void> _saveJournal() async {
    final prefs = await SharedPreferences.getInstance();
    final key = _formattedDate();
    await prefs.setString(key, _textController.text);
  }

  String _formattedDate() {
    final now = widget.selectedDate;
    return '${now.year}-${now.month.toString().padLeft(2, '0')}-${now.day.toString().padLeft(2, '0')}';
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
    return Text(
      _formattedDate(),
      style: const TextStyle(
        color: Colors.white,
        fontSize: 20,
        fontWeight: FontWeight.bold,
      ),
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
}
