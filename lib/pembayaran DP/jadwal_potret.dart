import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(JadwalPemotretan());
}

class JadwalPemotretan extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Stack(
          children: [
            MyStepper(),
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
        return Step1();
      default:
        return Container();
    }
  }
}

class Step1 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        KeteranganJadwalPemotretan(),
      ],
    );
  }
}

class KeteranganJadwalPemotretan extends StatelessWidget {
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
                fontWeight: FontWeight.bold),
          ),
        ),
        SizedBox(height: 200),
        Text(
          'Jadwal Pemotretan',
          style: GoogleFonts.roboto(
            textStyle: TextStyle(
                color: Colors.black,
                fontSize: 18.0,
                fontWeight: FontWeight.bold),
          ),
        ),
        Text(
          '13 September 17.00 - 17.30',
          style: GoogleFonts.roboto(
            textStyle: TextStyle(
                color: Colors.black,
                fontSize: 16.0,
                fontWeight: FontWeight.bold),
          ),
        ),
        SizedBox(height: 10),
        Text(
          'Kamu sudah bisa melakukan pemotretan Diharapkan untuk datang ke studio 10 menit sebelum pemotretan',
          style: GoogleFonts.roboto(
            textStyle: TextStyle(
                color: Colors.black,
                fontSize: 14.0,
                fontWeight: FontWeight.bold),
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
