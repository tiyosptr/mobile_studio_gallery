import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mobile_studio_gallery/menu/tampilan_utama.dart';
import 'package:mobile_studio_gallery/user/ganti_data_bank.dart';
import 'package:mobile_studio_gallery/user/ganti_email.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mobile_studio_gallery/login/tampilan_awal.dart';
import 'package:mobile_studio_gallery/pesanan/tampilan_pesanan_new.dart';
import 'package:mobile_studio_gallery/main.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(Tampilan());
}

class Tampilan extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Container(
        padding: EdgeInsets.all(16.0),
        child: TampilanDataPribadi(),
        // Menggunakan TampilanDataPribadi di sini
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart),
            label: 'Pesanan',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.location_pin),
            label: 'Lokasi',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profil',
          ),
        ],
        currentIndex: 3,
        onTap: (index) {
          switch (index) {
            case 0:
              // Navigate to Home
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => PaketApp()),
              );
              break;
            case 1:
              // Navigate to Pesanan
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => PesananPage2()),
              );
              break;
            case 2:
              // Navigate to Maps
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const MyMap()),
              );
              break;
            case 3:
              break;
          }
        },
        backgroundColor: Color(0xFF232D3F), // Background color
        selectedItemColor: Colors.white, // Selected item color
        unselectedItemColor: Colors.grey, // Unselected item color
        selectedLabelStyle: TextStyle(fontWeight: FontWeight.bold),
        unselectedLabelStyle: TextStyle(fontWeight: FontWeight.normal),
        elevation: 10, // Elevation
        type: BottomNavigationBarType.fixed, // To ensure all labels are visible
      ), // Use the BottomNavigation widget here
    );
  }
}

class TampilanDataPribadi extends StatelessWidget {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<Map<String, dynamic>> getUserData() async {
    final uid = _auth.currentUser?.uid;
    if (uid == null) {
      return {}; // Return an empty map if the user is not authenticated
    }

    try {
      final userData = await _firestore.collection('users').doc(uid).get();
      if (userData.exists) {
        return userData.data() as Map<String, dynamic>;
      }
    } catch (e) {
      print('Error fetching user data: $e');
    }

    return {}; // Return an empty map if there's an error or no data
  }

  Future<void> signOutFromGoogle(BuildContext context) async {
    await _auth.signOut();

    // Setelah logout, arahkan pengguna ke tampilan awal
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => Awal()),
      (Route<dynamic> route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<DocumentSnapshot>(
      stream: _firestore
          .collection('users')
          .doc(_auth.currentUser?.uid)
          .snapshots(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator();
        }

        if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        }

        final userData = snapshot.data?.data() as Map<String, dynamic> ?? {};
        final bankData = userData['bank'] as Map<String, dynamic>?;
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
                              MaterialPageRoute(
                                  builder: (context) => GantiData()),
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
              Text('${userData['email'] as String? ?? 'No email available'}',
                  style: GoogleFonts.roboto(
                    textStyle: TextStyle(
                      color: Colors.white60,
                      fontSize: 16.0,
                    ),
                  )),
              SizedBox(height: 30),
              Text('Nama Lengkap',
                  style: GoogleFonts.roboto(
                    textStyle: TextStyle(
                        color: Colors.white,
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold),
                  )),
              Text(
                  '${userData['nama_lengkap'] as String? ?? 'No email available'}',
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
              Text(
                  '${userData['nama_pengguna'] as String? ?? 'No email available'}',
                  style: GoogleFonts.roboto(
                    textStyle: TextStyle(
                      color: Colors.white60,
                      fontSize: 16.0,
                    ),
                  )),
              SizedBox(height: 30),
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
              if (bankData != null)
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Nama Bank: ${bankData['nama'] as String? ?? 'Tidak tersedia'}',
                      style: GoogleFonts.roboto(
                        textStyle: TextStyle(
                          color: Colors.white60,
                          fontSize: 16.0,
                        ),
                      ),
                    ),
                    Text(
                      'Jenis Bank: ${bankData['jenis'] as String? ?? 'Tidak tersedia'}',
                      style: GoogleFonts.roboto(
                        textStyle: TextStyle(
                          color: Colors.white60,
                          fontSize: 16.0,
                        ),
                      ),
                    ),
                    Text(
                      'No Rekening: ${bankData['no_rekening'] as String? ?? 'Tidak tersedia'}',
                      style: GoogleFonts.roboto(
                        textStyle: TextStyle(
                          color: Colors.white60,
                          fontSize: 16.0,
                        ),
                      ),
                    ),
                  ],
                )
              else
                Text(
                  'Tidak ada data bank',
                  style: GoogleFonts.roboto(
                    textStyle: TextStyle(
                      color: Colors.white60,
                      fontSize: 16.0,
                    ),
                  ),
                ),
              ElevatedButton(
                onPressed: () async {
                  await signOutFromGoogle(context);
                  // Panggil fungsi logout saat tombol keluar ditekan
                },
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(Colors.red),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(200.0),
                    ),
                  ),
                ),
                child: const SizedBox(
                  height: 45.0,
                  width: double.infinity,
                  child: Center(
                    child: Text(
                      'Logout',
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
