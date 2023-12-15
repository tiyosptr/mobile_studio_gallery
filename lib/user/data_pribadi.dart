import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
// import 'package:mobile_studio_gallery/navigation/bar.dart';
import 'package:mobile_studio_gallery/user/ganti_data_bank.dart';
import 'package:mobile_studio_gallery/user/ganti_email.dart';
import 'package:mobile_studio_gallery/navigation/bar_pribadi.dart';

void main() {
  runApp(Tampilan());
}

class Tampilan extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Container(
        padding: EdgeInsets.all(16.0),
        child: TampilanDataPribadi(), // Menggunakan TampilanDataPribadi di sini
      ),
             bottomNavigationBar: BottomNavigation(), // Use the BottomNavigation widget here

    );
  }
}

class TampilanDataPribadi extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text('Data Pribadi',
              style: GoogleFonts.roboto(
                textStyle: TextStyle(
                    color: Colors.white,
                    fontSize: 24.0,
                    fontWeight: FontWeight.bold),
              )),
          SizedBox(height: 30),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Email',
                  style: GoogleFonts.roboto(
                    textStyle: TextStyle(
                        color: Colors.white,
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold),
                  )),
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        // Aksi ketika tombol "Ganti" di-klik
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => GantiData()),
                        );
                        // Misalnya, tampilkan dialog penggantian untuk email
                      },
                      child: Text('Ganti'),
                    ),
                  ],
                ),
              ),
            ],
          ),
          Text('jhondhoe@gmail.com',
              style: GoogleFonts.roboto(
                textStyle: TextStyle(
                  color: Colors.white60,
                  fontSize: 16.0,
                ),
              )),
          SizedBox(height: 30),
          Text('Nama Pengguna',
              style: GoogleFonts.roboto(
                textStyle: TextStyle(
                    color: Colors.white,
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold),
              )),
          Text('Jhondhoe',
              style: GoogleFonts.roboto(
                textStyle: TextStyle(
                  color: Colors.white60,
                  fontSize: 16.0,
                ),
              )),
          SizedBox(height: 30),
          Text(
            'Password',
            style: TextStyle(
                fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
          ),
          Text(
            '**********',
            style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.white60),
          ),
          SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Data Bank',
                  style: GoogleFonts.roboto(
                    textStyle: TextStyle(
                        color: Colors.white,
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold),
                  )),
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        // Aksi ketika tombol "Ganti" di-klik
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => GantiDataBank()),
                        );
                        // Misalnya, tampilkan dialog penggantian untuk data bank
                      },
                      child: Text('Ganti'),
                    ),
                  ],
                ),
              ),
            ],
          ),
          Text('jhondhoe\nMandiri\n10900*****',
              style: GoogleFonts.roboto(
                textStyle: TextStyle(
                  color: Colors.white60,
                  fontSize: 16.0,
                ),
              )),
        ],
      ),
      // bottomNavigationBar: BottomNavigation()
    );
  }
}
