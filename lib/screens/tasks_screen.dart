import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../widgets/ai_button.dart';

class TasksScreen extends StatefulWidget {
  final DateTime? selectedDate;

  const TasksScreen({
    super.key,
    this.selectedDate,  // Add this line
  });

  @override
  State<TasksScreen> createState() => _TasksScreenState();
}

class _TasksScreenState extends State<TasksScreen> {
  final List<Task> tasks = [];
  late DateTime defaultDate;


  @override
  void initState() {
    super.initState();
    defaultDate = widget.selectedDate ?? DateTime.now();
    _loadTasks();
  }

  // Sort tasks by date
  void _sortTasks() {
    tasks.sort((a, b) => a.date.compareTo(b.date));
  }

  Future<void> _loadTasks() async {
    final prefs = await SharedPreferences.getInstance();
    final tasksJson = prefs.getString('tasks');
    if (tasksJson != null) {
      final List<dynamic> taskList = jsonDecode(tasksJson);
      setState(() {
        tasks.clear();
        tasks.addAll(taskList.map((json){
          final task = Task.fromJson(json);
          task.isExpanded = false; // Force isExpanded to be false
          return task;
        }));
        _sortTasks(); // Sort tasks after loading
      });
    }
  }

  Future<void> _saveTasks() async {
    _sortTasks(); // Sort tasks before saving
    final prefs = await SharedPreferences.getInstance();
    final tasksJson = jsonEncode(tasks.map((task) => task.toJson()).toList());
    await prefs.setString('tasks', tasksJson);
  }

  void _deleteTask(int index) {
    setState(() {
      tasks.removeAt(index);
    });
    _saveTasks();
  }

  void _addNewTask() {
    setState(() {
      tasks.add(Task(
        title: 'New Task',
        date: defaultDate,
        location: 'Unknown',
        notes: 'Details here',
      ));
      _sortTasks(); // Sort tasks after adding new task
    });
    _saveTasks();
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
            Expanded(
              child: Column(
                children: [
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 16),
                    child: Text(
                      "My Tasks",
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  Expanded(
                    child: ListView.builder(
                      itemCount: tasks.length,
                      itemBuilder: (context, index) {
                        return TaskWidget(
                          task: tasks[index],
                          onDelete: () => _deleteTask(index),
                          onSave: () {
                            _saveTasks();
                            setState(() {}); // Refresh the list after saving
                          },
                        );
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 0, left: 16.0, right: 0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        GestureDetector(
                          onTap: _addNewTask,
                          child: Container(
                            width: 60,
                            height: 60,
                            decoration: BoxDecoration(
                              color: const Color(0xffc9a77a),
                              borderRadius: BorderRadius.circular(15),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.2),
                                  blurRadius: 4,
                                  offset: const Offset(0, 2),
                                ),
                              ],
                            ),
                            child: const Center(
                              child: Icon(
                                Icons.add,
                                size: 30,
                                color: Color(0xff2d4d4e),
                              ),
                            ),
                          ),
                        ),
                        buildAIButton(context),
                      ],
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

class Task {
  String title;
  DateTime date;
  String location;
  String notes;
  bool isExpanded;

  Task({
    required this.title,
    required this.date,
    required this.location,
    required this.notes,
    this.isExpanded = false,
  });

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'date': date.toIso8601String(),
      'location': location,
      'notes': notes,
      'isExpanded': isExpanded,
    };
  }

  factory Task.fromJson(Map<String, dynamic> json) {
    return Task(
      title: json['title'],
      date: DateTime.parse(json['date']),
      location: json['location'],
      notes: json['notes'],
      isExpanded: json['isExpanded'] ?? false,
    );
  }
}

class TaskWidget extends StatefulWidget {
  final Task task;
  final VoidCallback onDelete;
  final VoidCallback onSave;

  const TaskWidget({
    super.key,
    required this.task,
    required this.onDelete,
    required this.onSave
  });

  @override
  State<TaskWidget> createState() => _TaskWidgetState();
}

class _TaskWidgetState extends State<TaskWidget> {
  late TextEditingController _titleController;
  late TextEditingController _locationController;
  late TextEditingController _notesController;
  late DateTime _selectedDate;

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController(text: widget.task.title);
    _locationController = TextEditingController(text: widget.task.location);
    _notesController = TextEditingController(text: widget.task.notes);
    _selectedDate = widget.task.date;
  }

  @override
  void dispose() {
    _titleController.dispose();
    _locationController.dispose();
    _notesController.dispose();
    super.dispose();
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2030), // Extended the last date to 2030
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.dark(
              primary: Color(0xffc9a77a),
              surface: Color(0xff52717B),
            ),
          ),
          child: child!,
        );
      },
    );
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }

  void _saveTask() {
    setState(() {
      widget.task.title = _titleController.text;
      widget.task.date = _selectedDate;
      widget.task.location = _locationController.text;
      widget.task.notes = _notesController.text;
      widget.task.isExpanded = false;
    });
    widget.onSave();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 20),
      decoration: BoxDecoration(
        color: const Color(0xff6A838B),
        borderRadius: BorderRadius.circular(30),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.task.title,
                      style: const TextStyle(
                        fontSize: 22,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      '${widget.task.date.day}/${widget.task.date.month}/${widget.task.date.year}',
                      style: const TextStyle(
                        fontSize: 16,
                        color: Colors.white70,
                      ),
                    ),
                  ],
                ),
              ),
              IconButton(
                icon: Icon(
                  widget.task.isExpanded
                      ? Icons.keyboard_arrow_up
                      : Icons.keyboard_arrow_down,
                  color: Colors.white,
                ),
                onPressed: () {
                  setState(() {
                    widget.task.isExpanded = !widget.task.isExpanded;
                  });
                },
              ),
            ],
          ),
          if (widget.task.isExpanded) ...[
            const SizedBox(height: 10),
            _buildEditableField('Title', _titleController),
            // Date picker button
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Date',
                    style: TextStyle(color: Colors.white70, fontSize: 16),
                  ),
                  TextButton(
                    onPressed: () => _selectDate(context),
                    child: Text(
                      '${_selectedDate.day}/${_selectedDate.month}/${_selectedDate.year}',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            _buildEditableField('Location', _locationController),
            _buildEditableField('Notes', _notesController),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ElevatedButton(
                  onPressed: _saveTask,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xffc9a77a),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25),
                    ),
                    minimumSize: const Size(100, 40),
                  ),
                  child: const Text(
                    'Save',
                    style: TextStyle(
                      color: Color(0xff1f3f42),
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.delete, color: Colors.white),
                  onPressed: widget.onDelete,
                ),
              ],
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildEditableField(String label, TextEditingController controller) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(color: Colors.white70, fontSize: 16),
        ),
        TextField(
          controller: controller,
          style: const TextStyle(color: Colors.white),
          decoration: const InputDecoration(
            enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.white54),
            ),
            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.white),
            ),
          ),
        ),
      ],
    );
  }
}
