import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class JadwalPemotretan extends StatelessWidget {
  final Map<String, dynamic> paket;
  final int selectedStudioIndex;
  final String selectedDate;
  final String selectedTime;
  final bool upfrontPaymentSelected;
  final double totalHarga;
  final String selectedBank;
  final String orderCode;

  JadwalPemotretan({
    required this.paket,
    required this.selectedStudioIndex,
    required this.selectedDate,
    required this.selectedTime,
    required this.upfrontPaymentSelected,
    required this.totalHarga,
    required this.selectedBank,
    required this.orderCode,
  });
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Stack(
          children: [
            MyStepper(
              selectedDate: selectedDate,
              selectedTime: selectedTime,
            ),
            Positioned(
              top: 0,
              left: 0,
              height: 80.0,
              child: IconButton(
                icon: Icon(Icons.arrow_back),
                onPressed: () {
                  // Aksi untuk kembali ke layar sebelumnya
                  Navigator.pop(context);
                  // Tambahkan logika untuk navigasi kembali atau sesuai kebutuhan
                  print('Back button pressed');
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class MyStepper extends StatefulWidget {
  final String selectedDate;
  final String selectedTime;

  MyStepper({required this.selectedDate, required this.selectedTime});

  @override
  _MyStepperState createState() => _MyStepperState();
}

class _MyStepperState extends State<MyStepper> {
  int _currentStep = 0;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _buildStepIndicator(1),
            _buildStepIndicator(2),
            _buildStepIndicator(3),
          ],
        ),
        SizedBox(height: 20),
        _buildStepContent(_currentStep + 1),
      ],
    );
  }

  Widget _buildStepIndicator(int step) {
    bool isClickable = step <=
        _currentStep + 1; // Jika langkah <= langkah saat ini, maka dapat diklik

    return GestureDetector(
      onTap: isClickable
          ? () {
              // Hanya memperbarui langkah jika langkah saat ini dapat diklik
              setState(() {
                _currentStep = step - 1;
              });
            }
          : null, // Mengatur onTap ke null jika langkah tidak dapat diklik
      child: Container(
        width: 30,
        height: 30,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: isClickable
              ? Colors.blue
              : Colors
                  .grey, // Mengganti warna untuk langkah yang tidak dapat diklik
        ),
        child: Center(
          child: Text(
            '$step',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildStepContent(int step) {
    switch (step) {
      case 1:
        return Step1(
            selectedDate: widget.selectedDate,
            selectedTime: widget.selectedTime);
      default:
        return Container();
    }
  }
}

class Step1 extends StatelessWidget {
  final String selectedDate;
  final String selectedTime;

  Step1({required this.selectedDate, required this.selectedTime});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        KeteranganJadwalPemotretan(
            selectedDate: selectedDate, selectedTime: selectedTime),
      ],
    );
  }
}

class KeteranganJadwalPemotretan extends StatelessWidget {
  final String selectedDate;
  final String selectedTime;

  KeteranganJadwalPemotretan(
      {required this.selectedDate, required this.selectedTime});

  String _formatDateString(String dateString) {
    DateTime date = DateFormat('dd-MM-yyyy').parse(dateString);
    return DateFormat('dd MMMM yyyy').format(date);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          'Keterangan Jadwal Pemotretan',
          style: GoogleFonts.roboto(
            textStyle: TextStyle(
              color: Colors.black,
              fontSize: 20.0,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        SizedBox(height: 200),
        Text(
          'Jadwal Pemotretan',
          style: GoogleFonts.roboto(
            textStyle: TextStyle(
              color: Colors.black,
              fontSize: 18.0,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        Text(
          '${_formatDateString(selectedDate)} $selectedTime ',
          style: GoogleFonts.roboto(
            textStyle: TextStyle(
              color: Colors.black,
              fontSize: 16.0,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        SizedBox(height: 10),
        Text(
          'Kamu sudah bisa melakukan pemotretan Diharapkan untuk datang ke studio 10 menit sebelum pemotretan',
          style: GoogleFonts.roboto(
            textStyle: TextStyle(
              color: Colors.black,
              fontSize: 14.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
