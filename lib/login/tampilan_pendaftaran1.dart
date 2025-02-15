import 'package:flutter/material.dart';
import 'package:mobile_studio_gallery/login/login_page.dart';
import 'package:mobile_studio_gallery/login/tampilan_pendaftaran2.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const Pendaftaran1());
}

class Pendaftaran1 extends StatelessWidget {
  const Pendaftaran1({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: RegistrationPage1(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class RegistrationPage1 extends StatefulWidget {
  const RegistrationPage1({super.key});

  @override
  _RegistrationPageState createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage1> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(20.0),
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    IconButton(
                      icon: const Icon(Icons.arrow_back_ios),
                      onPressed: () {
                        Navigator.pop(
                            context,
                            MaterialPageRoute(
                                builder: (context) => LoginPage()));
                      },
                    ),
                  ],
                ),
                const Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      SizedBox(
                        height: 5.0,
                      ),
                      Text(
                        'Daftar',
                        style: TextStyle(
                          fontSize: 30.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 50.0),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            'Nama Lengkap',
                            style: TextStyle(
                              fontSize: 20.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 30.0),
                          SizedBox(
                            width: 356.0,
                            height: 45.0,
                            child: TextField(
                              decoration: InputDecoration(
                                labelText: 'Masukkan Nama Lengkap',
                                border: OutlineInputBorder(
                                  borderSide: BorderSide(),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 30.0),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            'Alamat Email',
                            style: TextStyle(
                              fontSize: 20.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 30.0),
                          SizedBox(
                            width: 356.0,
                            height: 45.0,
                            child: TextField(
                              decoration: InputDecoration(
                                labelText: 'Masukkan Alamat Email',
                                border: OutlineInputBorder(
                                  borderSide: BorderSide(),
                                ),
                              ),
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
          const SizedBox(height: 10.0),
          Container(
            margin:
                const EdgeInsets.symmetric(horizontal: 25.0, vertical: 20.0),
            child: ElevatedButton(
              onPressed: () {
                Navigator.of(context).push(
                  PageRouteBuilder(
                    pageBuilder: (context, animation, secondaryAnimation) {
                      return RegistrationPage2(); // Gantilah dengan halaman kedua yang ingin Anda tampilkan
                    },
                    transitionsBuilder:
                        (context, animation, secondaryAnimation, child) {
                      const begin =
                          Offset(7.0, 0.0); // Mulai dari kanan ke kiri
                      const end = Offset.zero; // Berakhir di posisi awal
                      const curve = Curves.easeOutCubic; // Kurva animasi
                      var tween = Tween(begin: begin, end: end)
                          .chain(CurveTween(curve: curve));
                      var offsetAnimation = animation.drive(tween);
                      return SlideTransition(
                        position: offsetAnimation,
                        child: child, // Halaman yang akan ditampilkan
                      );
                    },
                  ),
                );
              },
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(Colors.black),
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
                    'Selanjutnya',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
