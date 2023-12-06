import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:intl/intl.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mobile_studio_gallery/kesimpulan/tampilan_kesimpulan.dart';
import 'package:mobile_studio_gallery/menu/tampilan_utama.dart';
import 'package:google_fonts/google_fonts.dart';

class CalendarScreen extends StatefulWidget {
  final Map<String, dynamic> paket;
  final int studioIndex;
  final String docId;

  const CalendarScreen({
    Key? key,
    required this.paket,
    required this.studioIndex,
    required this.docId,
  }) : super(key: key);

  @override
  _CalendarScreenState createState() => _CalendarScreenState();
}

class _CalendarScreenState extends State<CalendarScreen> {
  late CalendarFormat _calendarFormat;
  late DateTime _focusedDay;
  late DateTime _selectedDay;
  late String _selectedTime;
  bool isTimeSelected = false;
  Map<DateTime, List<bool>> selectedTimesMap = {};
  String _selectedDate = '';
  String _selectedHour = ''; // Changed from _selectedTime to _selectedHour
  String _status = '';
  String namaPaket = '';

  final List<String> timeSlots = [
    '09:00 - 09:30',
    '09:40 - 10:10',
    '10:20 - 10:50',
    '11:00 - 11:30',
    '11:40 - 12:10',
    '12:20 - 12:50',
    '13:00 - 13:30',
    '13:40 - 14:10',
    '14:20 - 14:50',
    '15:00 - 15:30',
    '15:40 - 16:10',
    '16:20 - 16:50',
    '17:00 - 17:30',
    '17:40 - 18:10',
    '18:20 - 18:30',
    '18:40 - 19:10',
    '19:20 - 19:50',
    '20:00 - 20:30',
    '20:40 - 21:10',
    '21:20 - 22:50',
  ];

  List<String> existingSelectedTimes = [];
  Map<String, List<String>> selectedTimesByPackage = {};

  @override
  void initState() {
    super.initState();
    _calendarFormat = CalendarFormat.month;
    _focusedDay = DateTime.now();
    _selectedDay = DateTime.now();
    _selectedTime = '';
    namaPaket = widget.paket['nama_paket'];
    getDataFromFirestore(paket: widget.paket['nama_paket']);
  }

  Future<void> getDataFromFirestore({required String paket}) async {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    QuerySnapshot snapshot = await firestore.collection('Pemesanan').get();

    setState(() {
      existingSelectedTimes = snapshot.docs
          .map<String>((document) =>
              '${(document.data() as Map<String, dynamic>)['tanggal']} ${(document.data() as Map<String, dynamic>)['jam']} ${(document.data() as Map<String, dynamic>)['nama_paket']}')
          .toList();
    });

    snapshot.docs.forEach((DocumentSnapshot document) {
      Map<String, dynamic> data = document.data() as Map<String, dynamic>;

      String namaPaket = data['nama_paket'];
      DateTime selectedDay = DateFormat('dd-MM-yyyy HH:mm')
          .parse('${data['tanggal']} ${data['jam']}');

      // Pastikan selectedTimesByPackage memiliki entri untuk nama paket
      selectedTimesByPackage.putIfAbsent(
        namaPaket,
        () => List.generate(25, (index) => 'false'),
      );

      int timeIndex = timeSlots.indexOf(data['jam']);
      if (timeIndex != -1 && namaPaket == paket) {
        // Update status waktu pemesanan berdasarkan nama paket
        selectedTimesByPackage[namaPaket]![timeIndex] = 'true';
      }
    });
  }

  String formatDateTime(DateTime dateTime) {
    return DateFormat('dd-MM-yyyy HH:mm - HH:mm').format(dateTime);
  }

  bool isTimeAvailable(String newSelectedDateTime) {
    return !existingSelectedTimes.contains(newSelectedDateTime);
  }

  bool isTimeBooked(String selectedDateTime) {
    return existingSelectedTimes.contains(selectedDateTime);
  }

  void _showErrorDialog(String errorMessage) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Error'),
          content: Text(errorMessage),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }

  void sendDataToFirestore() async {
    if (_selectedDay != null && _selectedTime.isNotEmpty) {
      String selectedDate = DateFormat('dd-MM-yyyy').format(_selectedDay);
      _selectedDate = selectedDate;
      _status = 'DiBooking';

      String selectedDateTime =
          '$selectedDate $_selectedTime ${widget.paket['nama_paket']}';

      bool dateExists =
          existingSelectedTimes.any((time) => time.contains(selectedDate));

      bool timeExists = existingSelectedTimes.contains(selectedDateTime);

      if (!dateExists || !timeExists) {
        FirebaseFirestore firestore = FirebaseFirestore.instance;

        String currentDateTime =
            DateFormat('yyyyMMddHHmmss').format(DateTime.now());
        String customDocumentName = "${widget.docId}_$currentDateTime";

        Map<String, dynamic> data = {
          'tanggal': _selectedDate,
          'jam': _selectedTime,
          'status': _status,
          'nama_paket': namaPaket,
          // ... tambahkan field lain yang diperlukan
        };

        if (_selectedDay != null && _selectedTime.isNotEmpty) {
          // Menggunakan metode 'set' untuk mengatur data ke dokumen dengan nama yang disediakan
          await firestore
              .collection('Booking')
              .doc(customDocumentName)
              .set(data);

          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text('Sukses'),
                content: Text('Pemesanan berhasil!'),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => PaketApp(),
                        ),
                      );
                    },
                    child: Text('OK'),
                  ),
                ],
              );
            },
          );
        } else {
          String errorMessage = 'Data tidak lengkap.';
          print(errorMessage);
          _showErrorDialog(errorMessage);
        }
      } else {
        String errorMessage =
            'Tanggal atau waktu sudah dipilih atau sudah di-booking. Pilih tanggal atau waktu lain.';
        print(errorMessage);
        _showErrorDialog(errorMessage);
      }
    } else {
      String errorMessage = 'Data tidak lengkap.';
      print(errorMessage);
      _showErrorDialog(errorMessage);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
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
                    color: Colors.black,
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
                        color: Colors.black,
                        fontSize: 18.0,
                        fontWeight: FontWeight.w600,
                        height: 6.0,
                      ),
                    ),
                  ),
                  // Spacer untuk menjaga jarak antara ikon dan teks
                )
              ],
            ),
            Container(
              width: 330.0,
              height: 285.0,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(25.0),
                color: Colors
                    .black, // Set the background color to black for a dark theme
              ),
              child: TableCalendar(
                calendarFormat: _calendarFormat,
                focusedDay: _focusedDay,
                firstDay: DateTime.now(),
                lastDay: DateTime.utc(2024, 12, 31),
                selectedDayPredicate: (day) {
                  return isSameDay(_selectedDay, day);
                },
                onDaySelected: (selectedDay, focusedDay) {
                  setState(() {
                    _selectedDay = selectedDay;
                    selectedTimesMap.putIfAbsent(
                      _selectedDay,
                      () => List.generate(25, (index) => false),
                    );
                    _selectedDate =
                        DateFormat('dd-MM-yyyy').format(selectedDay);
                    print(
                        '_selectedDate: $_selectedDate'); // Add this line to print the selected date
                  });

                  getDataFromFirestore(paket: widget.paket['nama_paket']);
                },
                onFormatChanged: (format) {
                  setState(() {
                    _calendarFormat = format;
                  });
                },
                calendarStyle: CalendarStyle(
                  todayTextStyle: TextStyle(
                    fontSize: 15.0,
                    color: Colors.black, // Warna teks saat tanggal dipilih
                  ),
                  selectedDecoration: BoxDecoration(
                    color: Colors
                        .white70, // Set color for selected date in dark theme
                    shape: BoxShape.rectangle,
                  ),
                  selectedTextStyle: TextStyle(
                    fontSize: 15.0,
                    color: Colors.black, // Warna teks saat tanggal dipilih
                  ),
                  defaultTextStyle: TextStyle(
                    fontSize: 15.0,
                    color: Colors.white, // Set default text color in dark theme
                  ),
                  weekendTextStyle: TextStyle(
                    color: Colors
                        .white, // Set text color for weekends in dark theme
                  ),
                  outsideDaysVisible: true,
                ),
                daysOfWeekStyle: DaysOfWeekStyle(
                  weekdayStyle: TextStyle(color: Colors.white),
                  weekendStyle: TextStyle(
                    color: Colors
                        .white60, // Set text color for weekends in dark theme
                  ),
                ),
                headerStyle: HeaderStyle(
                  formatButtonVisible: false,
                  titleCentered: true,
                  titleTextStyle: TextStyle(
                    fontSize: 19.0,
                    color: Colors.white,
                  ),
                  headerPadding: EdgeInsets.all(8.0),
                  leftChevronIcon: Icon(
                    Icons.chevron_left,
                    color: Colors.white,
                  ),
                  rightChevronIcon: Icon(
                    Icons.chevron_right,
                    color: Colors.white,
                  ),
                ),
                rowHeight: 32.0,
              ),
            ),
            SizedBox(height: 25.0),
            if (_selectedDay != null)
              Center(
                child: Container(
                  width: 345.0,
                  height: 375.0,
                  decoration: BoxDecoration(
                    color: Colors.grey[900],
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Text(
                        ' Pilih Jam',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 19.0,
                        ),
                      ),
                      SizedBox(height: 10),
                      Text(
                        ' Jadwal yang tersedia',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 15.0,
                        ),
                      ),
                      if (selectedTimesMap.containsKey(_selectedDay) &&
                          selectedTimesMap[_selectedDay] != null)
                        GridView.builder(
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 4,
                            crossAxisSpacing: 0.0,
                            mainAxisSpacing: 0.0,
                            childAspectRatio: 1.5,
                          ),
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemCount: timeSlots.length,
                          itemBuilder: (context, index) {
                            String selectedDate =
                                DateFormat('dd-MM-yyyy').format(_selectedDay);
                            String selectedTime = timeSlots[index];
                            String newSelectedDateTime =
                                '$selectedDate $selectedTime ${widget.paket['nama_paket']}';

                            bool isBooked = isTimeBooked(newSelectedDateTime);
                            bool isSelected =
                                selectedTimesMap.containsKey(_selectedDay) &&
                                    selectedTimesMap[_selectedDay]![index];

                            if (isBooked) {
                              // Jika waktu sudah dibooking, tidak perlu menampilkannya
                              return SizedBox.shrink();
                            }

                            return GestureDetector(
                              onTap: () async {
                                String selectedDate = DateFormat('dd-MM-yyyy')
                                    .format(_selectedDay);
                                String selectedTime = timeSlots[index];
                                String newSelectedDateTime =
                                    '$selectedDate $selectedTime ${widget.paket['nama_paket']}';

                                if (isTimeSelected &&
                                    _selectedTime == timeSlots[index]) {
                                  // Reset pemilihan waktu jika waktu yang sama diklik lagi
                                  setState(() {
                                    selectedTimesMap[_selectedDay] =
                                        List.generate(25, (index) => false);
                                    _selectedTime = '';
                                    isTimeSelected = false;
                                  });
                                } else if (selectedTimesMap
                                        .containsKey(_selectedDay) &&
                                    !existingSelectedTimes
                                        .contains(newSelectedDateTime) &&
                                    !(selectedTimesMap[_selectedDay]![index] ??
                                        false)) {
                                  // Pilih waktu jika belum dipilih
                                  setState(() {
                                    selectedTimesMap[_selectedDay] =
                                        List.generate(25, (index) => false);

                                    selectedTimesMap[_selectedDay]![index] =
                                        true;
                                    _selectedTime = timeSlots[index];
                                    isTimeSelected = true;
                                  });
                                } else {
                                  // Tampilkan pesan jika waktu sudah dipilih atau sudah di-booking
                                  _showErrorDialog(
                                      'Waktu sudah dipilih atau sudah di-booking. Pilih waktu lain.');
                                }
                              },
                              child: Container(
                                width: 100.0,
                                height: 150.0,
                                child: Card(
                                  color: isSelected
                                      ? Colors.blue[100]
                                      : Color(0xFF445256),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(5.0),
                                  ),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      isSelected
                                          ? Icon(
                                              Icons
                                                  .check_circle, // Gunakan ikon centang kecil jika waktu dipilih
                                              color: Colors.black,
                                              size: 20.0,
                                            )
                                          : Container(), // Kosongkan container jika waktu tidak dipilih
                                      SizedBox(
                                          height: isSelected
                                              ? 0.0
                                              : 0.0), // Berikan sedikit spasi jika ada centang
                                      Text(
                                        timeSlots[index],
                                        style: TextStyle(
                                          color: isSelected
                                              ? Colors.black
                                              : Colors.white,
                                          fontSize: 11,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          },
                        )
                      else
                        Center(
                          child: Container(
                            padding: EdgeInsets.symmetric(
                                vertical: 8.0, horizontal: 15.0),
                            decoration: BoxDecoration(
                              border:
                                  Border.all(color: Colors.red), // Red border
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  'Pilih tanggal terlebih dahulu',
                                  style: TextStyle(
                                    color: Colors.red,
                                    fontSize: 15.0,
                                  ),
                                ),
                                SizedBox(
                                    width:
                                        8.0), // Add spacing between icon and text
                                Icon(
                                  Icons.error,
                                  color: Colors.red,
                                ),
                              ],
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
              ),
            SizedBox(height: 5),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: ElevatedButton(
          onPressed: () {
            if (_selectedTime.isNotEmpty) {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => SelectStudio(
                    paket: widget.paket,
                    docId: widget.docId,
                    selectedStudioIndex: widget.studioIndex,
                    selectedDate: _selectedDate,
                    selectedTime: _selectedTime,
                  ),
                ),
              );
            } else {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: Text('Oops!'),
                    content: Text('Harap pilih jadwal terlebih dahulu.'),
                    actions: [
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: Text('OK'),
                      ),
                    ],
                  );
                },
              );
            }
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
    );
  }
}
