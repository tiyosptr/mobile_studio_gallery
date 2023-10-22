import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(JadwalApp());
}

class JadwalApp extends StatefulWidget {
  const JadwalApp({Key? key}) : super(key: key);

  @override
  _JadwalAppState createState() => _JadwalAppState();
}

class _JadwalAppState extends State<JadwalApp> {
  DateTime _selectedDate = DateTime.now();
  bool _showTimePicker = false;

  List<String> timeSlots = [
    "09:00 - 09:30",
    "09:40 - 10:10",
    "10:20 - 10:50",
    "11:00 - 11:30",
    "11:40 - 12:10",
    "12:20 - 12:50",
    "13:00 - 13:30",
    "13:40 - 14:10",
    "14:20 - 14:50",
    "15:00 - 15:30",
    "15:40 - 16:10",
    "16:20 - 16:50",
    "17:00 - 17:30",
    "17:40 - 18:10",
    "18:20 - 18:30",
    "18:40 - 19:10",
    "19:20 - 19:50",
    "20:00 - 20:30",
    "20:40 - 21:10",
  ];

  List<String> scheduleList = [];
  List<String> getScheduleForDate(DateTime date) {
    return timeSlots;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Color(0x101010),
        body: Center(
          child: Column(
            children: [
              // Row untuk ikon panah kembali dan teks "Pilih Tanggal"
              Row(
                mainAxisAlignment: MainAxisAlignment
                    .start, // Mengatur tata letak dari kiri ke kanan
                children: [
                  // Ikon panah kembali dengan Navigator
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(
                          context); // Aksi untuk kembali ke layar sebelumnya
                    },
                    child: Icon(
                      Icons.arrow_back,
                      color: Colors.white,
                    ),
                  ),
                  // Teks "Pilih Tanggal"
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal:
                            20.0), // Atur margin horizontal jika diperlukan
                    child: Text(
                      'Pilih Tanggal',
                      style: GoogleFonts.poppins(
                        textStyle: TextStyle(
                          color: Colors.white,
                          fontSize: 18.0,
                          height: 7.0,
                        ),
                      ),
                    ),
                    // Spacer untuk menjaga jarak antara ikon dan teks
                  )
                ],
              ),

              Container(
                width: 300.0,
                height: 230.0,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(25.0),
                  color: Colors.white,
                ),
                child: TableCalendar(
                  firstDay: DateTime.utc(2023, 10, 1),
                  lastDay: DateTime.utc(2023, 12, 31),
                  focusedDay: DateTime.now(),
                  onDaySelected: (selectedDay, focusedDay) {
                    setState(() {
                      _selectedDate = selectedDay;
                      _showTimePicker = true;
                      scheduleList = getScheduleForDate(_selectedDate);
                    });
                  },
                  calendarStyle: CalendarStyle(
                    todayDecoration: BoxDecoration(
                      color: Colors.black, // Warna latar belakang untuk tanggal "Today"
                      shape: BoxShape.rectangle, // Bentuk lingkaran untuk border radius
                    ),
                    selectedDecoration: BoxDecoration(
                        color: Colors.black, // Warna latar belakang untuk tanggal terpilih
                      shape: BoxShape.rectangle, // Bentuk lingkaran untuk border radius
                    ),
                  ),
                  daysOfWeekHeight: 0,
                  calendarFormat: CalendarFormat.month,
                  headerStyle: HeaderStyle(
                    formatButtonVisible: false,
                  ),
                  rowHeight: 30.0,
                ),
              ),
              SizedBox(height: 15.0),
              if (_showTimePicker)
                Center(
                  child: Container(
                    width: 335.0,
                    height: 335.0,
                    decoration: BoxDecoration(
                      color: Color(0xFF41E1E1C),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Text(
                          'Pilih Jam',
                          style: GoogleFonts.poppins(
                              textStyle: TextStyle(
                                  color: Colors.white, fontSize: 18.0)),
                        ),
                        SizedBox(height: 10),
                        Text(
                          'Jadwal yang tersedia',
                          style: GoogleFonts.roboto(
                              textStyle: TextStyle(
                                  color: Colors.white, fontSize: 14.0)),
                        ),
                        if (scheduleList.isNotEmpty)
                          GridView.builder(
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 4,
                              mainAxisSpacing: 0,
                              childAspectRatio: 1.8,
                              crossAxisSpacing: 0,
                            ),
                            itemCount: scheduleList.length,
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            itemBuilder: (BuildContext context, int index) {
                              return Card(
                                color: Color(0xFF445256),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(5.0),
                                ),
                                child: Center(
                                  child: Padding(
                                    padding: const EdgeInsets.all(5.0),
                                    child: Text(
                                      scheduleList[index],
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 10.0,
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                      ],
                    ),
                  ),
                ),
            ],
          ),
        ),
        bottomNavigationBar: Container(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => JadwalApp(),
                ),
              );
            },
            style: ElevatedButton.styleFrom(
              primary: Color(0xFF445256),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5.0),
              ),
            ),
            child: Padding(
              padding: EdgeInsets.all(10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Pesan Sekarang',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16.0,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
