import 'package:flutter/material.dart';

class TasksScreen extends StatefulWidget {
  const TasksScreen({super.key});

  @override
  State<TasksScreen> createState() => _TasksScreenState();
}

class _TasksScreenState extends State<TasksScreen> {
  // List of tasks with their details
  final List<Task> tasks = [
    Task(title: 'Call Mom', time: '10:00 AM', location: 'Home', notes: 'Wish her happy birthday'),
    Task(title: 'Water the Flowers', time: '6:00 PM', location: 'Garden', notes: 'Focus on the roses'),
  ];

  void _addNewTask() {
    setState(() {
      tasks.add(Task(
        title: 'New Task',
        time: '12:00 PM',
        location: 'Unknown',
        notes: 'Details here',
      ));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: _addNewTask,
        backgroundColor: const Color(0xffc9a77a),
        child: const Icon(Icons.add, color: Colors.white, size: 30),
      ),
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
            _buildHeader(context),
            const SizedBox(height: 20),
            const Text(
              "Today's Tasks",
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                itemCount: tasks.length,
                itemBuilder: (context, index) {
                  return TaskWidget(
                    task: tasks[index],
                    onDelete: () {
                      setState(() {
                        tasks.removeAt(index);
                      });
                    },
                  );
                },
              ),
            ),
            _buildBottomButtons(),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const SizedBox(width: 56),
        GestureDetector(
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
              fontSize: 34,
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
              onPressed: () {},
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildBottomButtons() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: GestureDetector(
            onTap: () {
              Navigator.pushNamed(context, '/ai_chat');
            },
            child: Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                color: const Color(0xffc9a77a),
                borderRadius: BorderRadius.circular(10),
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
      ],
    );
  }
}

// Task Object
class Task {
  String title;
  String time;
  String location;
  String notes;
  bool isExpanded;

  Task({
    required this.title,
    required this.time,
    required this.location,
    required this.notes,
    this.isExpanded = false,
  });
}

// Task Widget
class TaskWidget extends StatefulWidget {
  final Task task;
  final VoidCallback onDelete;

  const TaskWidget({super.key, required this.task, required this.onDelete});

  @override
  State<TaskWidget> createState() => _TaskWidgetState();
}

class _TaskWidgetState extends State<TaskWidget> {
  late TextEditingController _titleController;
  late TextEditingController _timeController;
  late TextEditingController _locationController;
  late TextEditingController _notesController;

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController(text: widget.task.title);
    _timeController = TextEditingController(text: widget.task.time);
    _locationController = TextEditingController(text: widget.task.location);
    _notesController = TextEditingController(text: widget.task.notes);
  }

  @override
  void dispose() {
    _titleController.dispose();
    _timeController.dispose();
    _locationController.dispose();
    _notesController.dispose();
    super.dispose();
  }

  void _saveTask() {
    setState(() {
      widget.task.title = _titleController.text;
      widget.task.time = _timeController.text;
      widget.task.location = _locationController.text;
      widget.task.notes = _notesController.text;
      widget.task.isExpanded = false; // Collapse after saving
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 20),
      decoration: BoxDecoration(
        color: const Color(0xffc09b80),
        borderRadius: BorderRadius.circular(15),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  widget.task.title,
                  style: const TextStyle(
                    fontSize: 22,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
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
            _buildEditableField('Time', _timeController),
            _buildEditableField('Location', _locationController),
            _buildEditableField('Notes', _notesController),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ElevatedButton(
                  onPressed: _saveTask,
                  child: const Text('Save'),
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