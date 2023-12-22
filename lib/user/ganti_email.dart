import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

void main() {
  runApp(GantiData());
}

class GantiData extends StatelessWidget {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _namaPenggunaController = TextEditingController();
  final TextEditingController _namaLengkapController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.black12,
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back,
              color: Colors.white,
            ),
            onPressed: () {
              Navigator.pop(context);
              // Aksi ketika tombol kembali di-klik
              // Misalnya, kembali ke layar sebelumnya
            },
          ),
          backgroundColor: Colors.black,
        ),
        body: Padding(
          padding: const EdgeInsets.only(top: 20, left: 24, right: 24),
          child: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text('Ganti Data Akun',
                    style: GoogleFonts.roboto(
                      textStyle: TextStyle(
                          color: Colors.white,
                          fontSize: 24.0,
                          fontWeight: FontWeight.bold),
                    )),
                SizedBox(height: 20),
                Text('Ganti Email',
                    style: GoogleFonts.roboto(
                      textStyle: TextStyle(
                          color: Colors.white,
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold),
                    )),
                SizedBox(height: 10),
                TextFormField(
                  controller: _emailController,
                  obscureText: false,
                  decoration: InputDecoration(
                    fillColor: Colors.white,
                    filled: true,
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide: BorderSide(),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide: BorderSide(),
                    ),
                    labelText: 'Ganti Email',
                  ),
                ),
                SizedBox(height: 20),
                Text('Ganti Nama Lengkap',
                    style: GoogleFonts.roboto(
                      textStyle: TextStyle(
                          color: Colors.white,
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold),
                    )),
                SizedBox(height: 10),

                TextFormField(
                  controller: _namaLengkapController,
                  obscureText: false,
                  decoration: InputDecoration(
                    fillColor: Colors.white,
                    filled: true,
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide: BorderSide(),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide: BorderSide(),
                    ),
                    labelText: 'Ganti Nama Pengguna',
                  ),
                ),
                SizedBox(height: 20),

                TextFormField(
                  controller: _namaPenggunaController,
                  obscureText: false,
                  decoration: InputDecoration(
                    fillColor: Colors.white,
                    filled: true,
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide: BorderSide(),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide: BorderSide(),
                    ),
                    labelText: 'Ganti Nama Pengguna',
                  ),
                ),
                SizedBox(height: 20),

                Text('Ganti Password',
                    style: GoogleFonts.roboto(
                      textStyle: TextStyle(
                          color: Colors.white,
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold),
                    )),
                SizedBox(height: 10),

                TextFormField(
                  initialValue: '*******',
                  obscureText: true,
                  decoration: InputDecoration(
                    fillColor: Colors.white,
                    filled: true,
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide: BorderSide(),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide: BorderSide(),
                    ),
                    labelText: 'Ganti Password',
                  ),
                ),
                SizedBox(height: 20),

                Text('Konfirmasi Password',
                    style: GoogleFonts.roboto(
                      textStyle: TextStyle(
                          color: Colors.white,
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold),
                    )),
                SizedBox(height: 10),

                TextFormField(
                  initialValue: '*******',
                  obscureText: true,
                  decoration: InputDecoration(
                    fillColor: Colors.white,
                    filled: true,
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide: BorderSide(),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide: BorderSide(),
                    ),
                    labelText: 'Konfirmasi Password',
                  ),
                ),
                Expanded(
                    child: SizedBox()), // Memberikan ruang ke tombol konfirmasi
                ElevatedButton(
                  onPressed: () async {
                    // Aksi ketika tombol "Konfirmasi" di-klik
                    // Misalnya, validasi input dan simpan perubahan
                    String newEmail = _emailController.text;
                    String newNamaPengguna = _namaPenggunaController.text;
                    String newNamaLengkap = _namaLengkapController.text;
                    final uid = FirebaseAuth.instance.currentUser?.uid;

                    await FirebaseFirestore.instance
                        .collection('users')
                        .doc(uid)
                        .update({
                      'email': newEmail,
                      'nama_pengguna': newNamaPengguna,
                      'nama_lengkap': newNamaLengkap,
                    });

                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Perubahan data berhasil disimpan.'),
                        duration: Duration(seconds: 2),
                      ),
                    );

                    Navigator.pop(context);
                  },
                  style: ElevatedButton.styleFrom(
                    primary: Color(0xFF445256), // Warna 445256
                  ),
                  child: Text(
                    'Konfirmasi',
                    style: TextStyle(color: Colors.white), // Warna teks putih
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
