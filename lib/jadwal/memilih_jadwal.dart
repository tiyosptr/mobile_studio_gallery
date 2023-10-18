import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

void main() {
  runApp(BookingApp());
}

class BookingApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: BookingScreen(),
    );
  }
}

class BookingScreen extends StatefulWidget {
  @override
  _BookingScreenState createState() => _BookingScreenState();
}

class _BookingScreenState extends State<BookingScreen> {
  CalendarFormat _calendarFormat = CalendarFormat.month;
  DateTime _focusedDay = DateTime.now();
  DateTime? selectedDay;
  Map<DateTime, List<dynamic>> _events = {
    DateTime(2023, 10, 15): ['Event 1'],
    DateTime(2023, 10, 20): ['Event 2'],
    DateTime(2023, 10, 25): ['Event 3'],
  };

  // Daftar jam yang tersedia
  List<String> availableTimes = [
    '09:00 AM',
    '10:00 AM',
    '11:00 AM',
    '12:00 PM',
    '01:00 PM',
    '02:00 PM',
    '03:00 PM',
    '04:00 PM',
    '05:00 PM',
  ];

  // Logika untuk menampilkan jadwal jam pembookingan
  void _showBookingDialog(DateTime selectedDate) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Pilih Jam Booking untuk ${selectedDate.day}/${selectedDate.month}/${selectedDate.year}'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text('Pilihan Jam:'),
              Column(
                children: availableTimes
                    .map((time) => ElevatedButton(
                          onPressed: () {
                            // Tambahkan logika untuk pemilihan jam
                            // Misalnya, pilih jam yang dipilih oleh pengguna
                            print('Anda telah memilih jam: $time');
                            Navigator.pop(context);
                          },
                          child: Text(time),
                        ))
                    .toList(),
              ),
            ],
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('Batal'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          // Background element
          Container(
            color: Colors.white,
          ),
          // TableCalendar
          Positioned(
            top: 120,
            left: 20,
            right: 20,
            child: TableCalendar(
              calendarFormat: _calendarFormat,
              focusedDay: _focusedDay,
              firstDay: DateTime.utc(2023, 1, 1),
              lastDay: DateTime.utc(2023, 12, 31),
              eventLoader: _getEventsForDay,
              onDaySelected: (selectedDay, focusedDay) {
                setState(() {
                  this.selectedDay = selectedDay;
                });
                if (_events.containsKey(selectedDay)) {
                  _showBookingDialog(selectedDay);
                }
              },
              calendarStyle: CalendarStyle(
                todayDecoration: BoxDecoration(
                  color: Colors.blue,
                  borderRadius: BorderRadius.circular(10.0),
                ),
                selectedDecoration: BoxDecoration(
                  color: Colors.green,
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  List<dynamic> _getEventsForDay(DateTime date) {
    return _events[date] ?? [];
  }
}
