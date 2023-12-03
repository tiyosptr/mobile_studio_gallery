import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(PembayaranDP());
}

class PembayaranDP extends StatelessWidget {
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
            _buildStepIndicator(2),
            _buildStepIndicator(3),
          ],
        ),
        SizedBox(height: 20),
        _buildStepContent(_currentStep + 2),
      ],
    );
  }

  Widget _buildStepIndicator(int step) {
    return GestureDetector(
      onTap: () {
        // Ketika step di tap, tampilkan konten sesuai dengan step yang di tap
        setState(() {
          _currentStep = step - 2;
        });
      },
      child: Container(
        width: 30,
        height: 30,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: step <= _currentStep + 2 ? Color(0xFF101717) : Colors.grey,
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
        return Column(
          children: [],
        );
      case 2:
        return Column(
          children: [
            Card(
              color: Color(0xFF101717),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              clipBehavior: Clip.antiAliasWithSaveLayer,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Image.asset(
                    'images/family.jpg',
                    height: 160,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(15),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Paket Keluarga',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                            Text(
                              'Belum Lunas',
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 8),
                        Row(
                          children: [
                            Icon(
                              Icons.people,
                              color: Colors.white,
                              size: 18,
                            ),
                            SizedBox(width: 4),
                            Text(
                              '2-10 Orang People',
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 8),
                        Row(
                          children: [
                            Icon(
                              Icons.timer,
                              color: Colors.white,
                              size: 18,
                            ),
                            SizedBox(width: 4),
                            Text(
                              '30 Menit',
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 8),
                        Row(
                          children: [
                            Icon(
                              Icons.local_laundry_service,
                              color: Colors.white,
                              size: 18,
                            ),
                            SizedBox(width: 4),
                            Text(
                              '2x Ganti Pakaian',
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Status: Belum Lunas',
                    style: GoogleFonts.roboto(
                      textStyle: TextStyle(
                          color: Colors.black,
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold),
                    )),
                Text('Rp.100.000',
                    style: GoogleFonts.roboto(
                      textStyle: TextStyle(
                          color: Colors.black,
                          fontSize: 16.0,
                          fontWeight: FontWeight.bold),
                    )),
              ],
            ),
            SizedBox(height: 8),
            Container(
              height: 1,
              color: Colors.black,
            ),
            SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text('Dimohon untuk melakukan pelunasan',
                    style: GoogleFonts.roboto(
                      textStyle: TextStyle(
                          color: Colors.black,
                          fontSize: 14.0,
                          fontWeight: FontWeight.bold),
                    )
                ),
              ],
            ),
            SizedBox(height: 150),
            ElevatedButton(
              onPressed: () {
                // Tambahkan logika untuk menangani tombol
                print('Status Pembayaran Button Pressed');
              },
              style: ElevatedButton.styleFrom(
                primary: Color(0xFF445256), // Warna latar belakang tombol
                onPrimary: Colors
                    .white, // Warna teks tombol saat tombol tidak dalam keadaan ditekan
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(
                      10.0), // Atur border radius sesuai keinginan
                ),
                side: BorderSide(
                  color: Colors.white, // Warna border
                  width: 2.0, // Lebar border
                ),
              ),
              child: Text(
                'Status Pembayaran                      Belum Lunas',
                style: TextStyle(
                  color: Colors.white, // Warna teks tombol
                ),
              ),
            ),
          ],
        );
      case 3:
        return Column(
          children: [
            Text(
              'Selesai',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 20),
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
              Text(
                'Data Foto Kamu',
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold),
              ),
            ]),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton.icon(
                  onPressed: () {
                    // Tambahkan logika untuk menangani tombol
                    print('Google Drive Button Pressed');
                  },
                  style: ElevatedButton.styleFrom(
                    primary: Color.fromARGB(255, 223, 241, 252),
                    // Warna teks tombol saat tombol tidak dalam keadaan ditekan
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(
                          5.0), // Atur border radius sesuai keinginan
                    ),
                    fixedSize: Size(
                        380, 30), // Sesuaikan lebar dan tinggi sesuai kebutuhan
                  ),
                  icon: Icon(
                    CupertinoIcons.paperplane_fill,
                    color: Colors.blueAccent,
                  ),
                  label: Text(
                    'Google Drive',
                    style: GoogleFonts.roboto(
                      textStyle:
                          TextStyle(color: Colors.blueAccent, fontSize: 17.0),
                    ),
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Untuk mendapatkan print foto dan bingkai,\nharap hubungi admin ',
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 14.0,
                      fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ],
        );

      default:
        return Container();
    }
  }
}
