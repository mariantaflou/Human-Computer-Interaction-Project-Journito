import 'package:flutter/material.dart';
import 'package:journito/screens/tasks_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:table_calendar/table_calendar.dart';
import '../widgets/ai_button.dart';
import 'dart:convert';

class CalendarScreen extends StatefulWidget {
  const CalendarScreen({Key? key}) : super(key: key);

  @override
  _CalendarScreenState createState() => _CalendarScreenState();
}

class _CalendarScreenState extends State<CalendarScreen> {
  final CalendarFormat _calendarFormat = CalendarFormat.month;
  DateTime _focusedDay = DateTime(DateTime.now().year, DateTime.now().month, 1);
  DateTime? _selectedDay;
  List<String> _loggedDates = [];
  List<String> _datesWithTasks = [];
  int _currentStreak = 0;

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    await _loadLoggedDates();
    await _loadDatesWithTasks();
  }

  Future<void> _loadLoggedDates() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _loggedDates = prefs.getStringList('logs') ?? [];
      _calculateStreak();
    });
  }

  Future<void> _loadDatesWithTasks() async {
    final prefs = await SharedPreferences.getInstance();
    final tasksJson = prefs.getString('tasks');
    if (tasksJson != null) {
      final List<dynamic> taskList = jsonDecode(tasksJson);
      Set<String> dates = {};
      for (var task in taskList) {
        if (task['date'] != null) {
          final taskDate = DateTime.parse(task['date']);
          final formattedDate =
              '${taskDate.year}-${taskDate.month.toString().padLeft(2, '0')}-${taskDate.day.toString().padLeft(2, '0')}';
          dates.add(formattedDate);
        }
      }
      setState(() {
        _datesWithTasks = dates.toList();
      });
    }
  }

  void _calculateStreak() {
    if (_loggedDates.isEmpty) {
      _currentStreak = 0;
      return;
    }

    List<DateTime> dates = _loggedDates
        .map((dateStr) => DateTime.parse(dateStr))
        .toList()
      ..sort((a, b) => b.compareTo(a));

    DateTime today = DateTime.now();
    today = DateTime(today.year, today.month, today.day);

    int streak = 0;
    DateTime currentDate = today;

    for (var i = 0; i <= dates.length; i++) {
      String currentDateStr =
          '${currentDate.year}-${currentDate.month.toString().padLeft(2, '0')}-${currentDate.day.toString().padLeft(2, '0')}';

      if (_loggedDates.contains(currentDateStr)) {
        streak++;
        currentDate = currentDate.subtract(const Duration(days: 1));
      } else {
        break;
      }
    }

    _currentStreak = streak;
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
            _buildTitleAndProfile(),
            const SizedBox(height: 20),
            Expanded(
              child: Container(
                decoration: const BoxDecoration(
                  color: Color(0xff52717B),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(45),
                    topRight: Radius.circular(45),
                  ),
                ),
                child: Column(
                  children: [
                    TableCalendar(
                      firstDay: DateTime.utc(2022, 1, 1),
                      lastDay: DateTime.utc(2025, 12, 31),
                      focusedDay: _focusedDay,
                      calendarFormat: _calendarFormat,
                      selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
                      onDaySelected: (selectedDay, focusedDay) {
                        setState(() {
                          _selectedDay = selectedDay;
                          _focusedDay = focusedDay;
                        });
                      },
                      headerStyle: const HeaderStyle(
                        formatButtonVisible: false,
                        titleCentered: true,
                        titleTextStyle: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                        leftChevronIcon: Icon(Icons.chevron_left, color: Colors.white),
                        rightChevronIcon: Icon(Icons.chevron_right, color: Colors.white),
                      ),
                      daysOfWeekStyle: const DaysOfWeekStyle(
                        weekdayStyle: TextStyle(color: Colors.white),
                        weekendStyle: TextStyle(color: Colors.grey),
                      ),
                      calendarStyle: const CalendarStyle(
                        todayDecoration: BoxDecoration(
                          color: Color(0xff1f3f42),
                          shape: BoxShape.circle,
                        ),
                        selectedDecoration: BoxDecoration(
                          color: Color(0xff627E87),
                          shape: BoxShape.circle,
                        ),
                        defaultTextStyle: TextStyle(color: Colors.white),
                        weekendTextStyle: TextStyle(color: Colors.white),
                        outsideDaysVisible: false,
                      ),
                      calendarBuilders: CalendarBuilders(
                        markerBuilder: (context, day, events) {
                          final dateString =
                              '${day.year}-${day.month.toString().padLeft(2, '0')}-${day.day.toString().padLeft(2, '0')}';

                          if (_loggedDates.contains(dateString) &&
                              _datesWithTasks.contains(dateString)) {
                            return Stack(
                              children: [
                                _buildMarker(const Color(0xff1f3f42), isLeft: true),  // Log marker (left)
                                _buildMarker(const Color(0xffc9a77a), isLeft: false),  // Task marker (right)
                              ],
                            );
                          } else if (_loggedDates.contains(dateString)) {
                            return Stack(
                              children: [
                                _buildMarker(const Color(0xff1f3f42), isLeft: true),  // Single log marker
                              ],
                            );
                          } else if (_datesWithTasks.contains(dateString)) {
                            return Stack(
                              children: [
                                _buildMarker(const Color(0xffc9a77a), isLeft: true),  // Single task marker
                              ],
                            );
                          }

                          return null;
                        },
                      ),
                    ),
                    const SizedBox(height: 16),
                    _buildLogsAndStreaksSection(),
                    const SizedBox(height: 20),
                    _buildBottomButtons(context),
                    const SizedBox(height: 16),
                  ],
                ),
              ),
            ),
            buildAIButton(context),
          ],
        ),
      ),
    );
  }

  Widget _buildMarker(Color color, {bool isLeft = true}) {
    return Positioned(
      bottom: 1,
      left: isLeft ? 14 : null,
      right: isLeft ? null : 14,
      child: Container(
        height: 6,
        width: 6,
        decoration: BoxDecoration(
          color: color,
          shape: BoxShape.circle,
        ),
      ),
    );
  }

  Widget _buildTitleAndProfile() {
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
              onPressed: () {},
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildLogsAndStreaksSection() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 24),
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
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Streak',
                  style: TextStyle(color: Colors.white, fontSize: 16),
                ),
                Text(
                  _currentStreak.toString(),
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Logs',
                  style: TextStyle(color: Colors.white, fontSize: 16),
                ),
                Text(
                  _loggedDates.length.toString(),
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBottomButtons(BuildContext context) {
    return Column(
      children: [
        _buildButton(context, 'Add Log', Icons.edit, '/journaling'),
        _buildButton(context, 'Add Task', Icons.add, '/tasks'),
        _buildButton(context, 'Find Experiences', Icons.search, '/experiences'),
      ],
    );
  }

  Widget _buildButton(BuildContext context, String title, IconData icon, String route) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 24.0),
      child: ElevatedButton.icon(
        onPressed: () {
          if (_selectedDay == null) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Please select a date first')),
            );
            return;
          }

          if (route == '/tasks') {
            // For tasks route, use push instead of pushNamed to pass the widget directly
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => TasksScreen(selectedDate: _selectedDay),
              ),
            ).then((_) {
              _loadLoggedDates();
              _loadDatesWithTasks();
            });
          } else {
            // For other routes, use the existing navigation
            Navigator.pushNamed(
              context,
              route,
              arguments: {'selectedDate': _selectedDay},
            ).then((_) {
              _loadLoggedDates();
              _loadDatesWithTasks();
            });
          }
        },
        icon: Icon(icon, color: const Color(0xff1f3f42)),
        label: Text(
          title,
          style: const TextStyle(color: Colors.white),
        ),
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xffc9a77a),
          minimumSize: const Size(double.infinity, 48),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(25),
          ),
        ),
      ),
    );
  }
}
