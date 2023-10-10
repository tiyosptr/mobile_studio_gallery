import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:mobile_studio_gallery/login/login_page.dart';
import 'package:mobile_studio_gallery/login/tampilan_pendaftaran1.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(DaftarAwal());
}

class DaftarAwal extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Awal(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class Awal extends StatelessWidget {
  // List of image paths
  final List<String> imageList = [
    "images/image 1.png",
    "images/image 2.png",
    "images/image 3.png",
    // Add more image paths as needed
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          // Carousel Slider sebagai latar belakang
          CarouselSlider(
            items: imageList.map((imagePath) {
              return ColorFiltered(
                colorFilter: ColorFilter.mode(
                  Colors.black.withOpacity(0.6),
                  BlendMode.darken,
                ),
                child: Image.asset(
                  imagePath,
                  fit: BoxFit.cover,
                ),
              );
            }).toList(),
            options: CarouselOptions(
              height: MediaQuery.of(context).size.height,
              autoPlay: true,
              viewportFraction: 1,
              disableCenter: true,
              autoPlayInterval: Duration(seconds: 3),
              autoPlayAnimationDuration: Duration(milliseconds: 800),
              autoPlayCurve: Curves.fastOutSlowIn,
            ),
          ),

          // Kontainer untuk tombol dan teks
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Align(
                alignment: Alignment.center, // Mengatur teks di tengah
                child: Opacity(
                  opacity:
                      0.6, // Ubah nilai ini antara 0 (sepenuhnya transparan) hingga 1 (tidak transparan).
                  child: Text(
                    "Selamat Datang!",
                    style: TextStyle(
                      fontSize: 24.0,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              Align(
                alignment: Alignment.center,
                child: Opacity(
                  opacity:
                      0.6, // Ubah nilai ini antara 0 (sepenuhnya transparan) hingga 1 (tidak transparan).
                  child: Text(
                    "Silakan pilih salah satu opsi:",
                    style: TextStyle(
                      fontSize: 16.0,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 30.0), // Spasi antara teks dan tombol
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).push(
                        PageRouteBuilder(
                          pageBuilder:
                              (context, animation, secondaryAnimation) {
                            return LoginPage(); // Gantilah dengan halaman kedua yang ingin Anda tampilkan
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
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                    ),
                    child: Text(
                      "Daftar/Masuk",
                      style: TextStyle(
                        fontSize: 17.0,
                        color: Colors.black,
                      ),
                    ),
                  ),

                  SizedBox(width: 30.0), // Spasi antara tombol
                  ElevatedButton(
                    onPressed: () {
                      // Aksi yang diambil saat tombol "Masuk sebagai Tamu" ditekan
                      print("Tombol Masuk sebagai Tamu ditekan");
                      // Tambahkan aksi sesuai kebutuhan Anda
                    },
                    style: ElevatedButton.styleFrom(
                      primary:
                          Colors.transparent, // Ubah primary ke transparent
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                    ),
                    child: Text(
                      "Masuk sebagai Tamu",
                      style: TextStyle(
                        fontSize: 17.0,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 5.0), // Spasi antara teks dan tombol
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(height: 50.0), // Tambahkan spasi di sini
                  Text(
                    "Belum punya akun? ",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 15.0,
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.of(context).push(
                        PageRouteBuilder(
                          pageBuilder:
                              (context, animation, secondaryAnimation) {
                            return RegistrationPage1(); // Gantilah dengan halaman yang ingin Anda tampilkan saat daftar
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
                              child:
                                  child, // Halaman yang akan ditampilkan saat daftar
                            );
                          },
                        ),
                      );
                    },
                    child: Text(
                      "Daftar",
                      style: TextStyle(
                        color: Colors.blue,
                        fontSize: 15.0,
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  )
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
