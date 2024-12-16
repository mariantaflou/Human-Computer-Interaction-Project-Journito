import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

class CalendarScreen extends StatefulWidget {
  const CalendarScreen({super.key});

  @override
  State<CalendarScreen> createState() => _CalendarScreenState();
}

class _CalendarScreenState extends State<CalendarScreen> {
  final CalendarFormat _calendarFormat = CalendarFormat.month;
  DateTime _focusedDay = DateTime(DateTime.now().year, DateTime.now().month, 1);
  DateTime? _selectedDay;

  // Mock data for days with logs and tasks (you'll replace this with actual data)
  final Set<DateTime> _daysWithLogs = {
    DateTime(2024, 12, 5),
    DateTime(2024, 12, 10),
    DateTime(2024, 12, 15),
  };

  final Set<DateTime> _daysWithTasks = {
    DateTime(2024, 12, 7),
    DateTime(2024, 12, 12),
    DateTime(2024, 12, 18),
    DateTime(2024, 12, 15),
  };

  // Helper function to compare only year, month, and day
  bool _isSameDay(DateTime day1, DateTime day2) {
    return day1.year == day2.year && day1.month == day2.month && day1.day == day2.day;
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
                    Expanded(
                      child: TableCalendar(
                        firstDay: DateTime.utc(2022, 1, 1),
                        lastDay: DateTime.utc(2025, 12, 31),
                        focusedDay: _focusedDay,
                        calendarFormat: _calendarFormat,
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
                          weekdayStyle: TextStyle(color: Colors.white), // Change weekday color
                          weekendStyle: TextStyle(color: Colors.grey), // Change weekend color
                        ),

                        selectedDayPredicate: (day) {
                          return isSameDay(_selectedDay, day);
                        },
                        onDaySelected: (selectedDay, focusedDay) {
                          setState(() {
                            _selectedDay = selectedDay;
                            _focusedDay = focusedDay;
                          });
                        },
                        onPageChanged: (focusedDay) {
                          setState(() {
                            _focusedDay = focusedDay;
                          });
                        },
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
                            bool hasLog = _daysWithLogs.any((d) => _isSameDay(d, day));
                            bool hasTask = _daysWithTasks.any((d) => _isSameDay(d, day));

                            if (hasLog && hasTask) {
                              return _buildMarker(Colors.purple);
                            } else if (hasLog) {
                              return _buildMarker(Colors.green);
                            } else if (hasTask) {
                              return _buildMarker(Colors.blue);
                            }
                            return null;
                          },
                        ),
                      ),
                    ),
                    _buildLogsAndStreaksSection(),
                    _buildBottomButtons(context),
                    const SizedBox(height: 16),
                  ],
                ),
              ),
            ),
            _buildAIButton(context),
          ],
        ),
      ),
    );
  }

  Widget _buildMarker(Color color) {
    return Positioned(
      bottom: 1,
      child: Container(
        height: 5,
        width: 20,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(2),
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

  Widget _buildLogsAndStreaksSection() {
    return Padding(
      padding: const EdgeInsets.all(16),
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
        child: const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Streak',
                  style: TextStyle(color: Colors.white, fontSize: 16),
                ),
                Text(
                  '7',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Logs',
                  style: TextStyle(color: Colors.white, fontSize: 16),
                ),
                Text(
                  '11',
                  style: TextStyle(
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
      padding: const EdgeInsets.symmetric(vertical: 6.0, horizontal: 24.0),
      child: ElevatedButton.icon(
        onPressed: () {
          Navigator.pushNamed(context, route);
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

  Widget _buildAIButton(BuildContext context) {
    return Align(
      alignment: Alignment.bottomRight,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: GestureDetector(
          onTap: () {
            Navigator.pushNamed(context, '/ai_chat');
          },
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
    );
  }
}
