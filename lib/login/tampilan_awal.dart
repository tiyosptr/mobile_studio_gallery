import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

void main() => runApp(const Awal());

class Awal extends StatelessWidget {
  const Awal({super.key});



  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Stack(
          fit: StackFit.expand,
          children: [
            // Carousel Slider sebagai latar belakang
            CarouselSlider(
              items: [
                ColorFiltered(
                  colorFilter: ColorFilter.mode(
                    Colors.black
                        .withOpacity(0.7), // Atur tingkat kegelapan di sini
                    BlendMode.darken,
                  ),
                  child: Image.asset("images/image 1.png"),
                ),
                ColorFiltered(
                  colorFilter: ColorFilter.mode(
                    Colors.black.withOpacity(0.7),
                    BlendMode.darken,
                  ),
                  child: Image.asset("images/image 2.png"),
                ),
                ColorFiltered(
                  colorFilter: ColorFilter.mode(
                    Colors.black.withOpacity(0.7),
                    BlendMode.darken,
                  ),
                  child: Image.asset("images/image 3.png"),
                ),
                // Tambahkan lebih banyak gambar sesuai kebutuhan Anda
              ],
              options: CarouselOptions(
                height: MediaQuery.of(context).size.height,
                aspectRatio: MediaQuery.of(context)
                    .size
                    .aspectRatio, // Menggunakan aspect ratio layar

                enableInfiniteScroll: true,
                autoPlay: true,
                autoPlayInterval: const Duration(seconds: 4),
                autoPlayAnimationDuration: const Duration(milliseconds: 800),
                autoPlayCurve: Curves.fastOutSlowIn,
              ),
            ),

            // Kontainer untuk tombol dan teks
            Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        // Aksi yang diambil saat tombol "Daftar" ditekan
                        print("Tombol Daftar ditekan");
                        // Tambahkan aksi sesuai kebutuhan Anda
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                      ),
                      child: const Text(
                        "Daftar/Masuk",
                        style: TextStyle(
                          fontSize: 17.0,
                          color: Colors.black,
                        ),
                      ),
                    ),
                    const SizedBox(width: 30.0), // Spasi antara tombol
                    ElevatedButton(
                      onPressed: () {
                        // Aksi yang diambil saat tombol "Masuk sebagai Tamu" ditekan
                        print("Tombol Masuk sebagai Tamu ditekan");
                        // Tambahkan aksi sesuai kebutuhan Anda
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white.withOpacity(0.1),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                      ),
                      child: const Text(
                        "Masuk sebagai Tamu",
                        style: TextStyle(
                          fontSize: 17.0,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 15.0), // Spasi antara tombol dan teks
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "Belum punya akun? ",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 15.0,
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        // Aksi yang diambil saat tautan "Daftar" ditekan
                        print("Tautan 'Daftar' ditekan");
                        // Tambahkan aksi sesuai kebutuhan Anda
                        // Di sini Anda dapat menavigasi ke halaman pendaftaran atau melakukan aksi lainnya.
                      },
                      child: const Text(
                        "Daftar",
                        style: TextStyle(
                          color: Colors.blue,
                          fontSize: 15.0,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
