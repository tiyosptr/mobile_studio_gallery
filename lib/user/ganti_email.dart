import 'package:flutter/material.dart';

void main() {
  runApp(GantiData());
}

class GantiData extends StatelessWidget {
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
              color:  Colors.white,
            ),
            onPressed: () {
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
                Text(
                  'Ganti Data Akun',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: 20),
                Text(
                  'Ganti Email',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                TextFormField(
                  initialValue: 'jhondhoe@gmail.com',
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
                Text(
                  'Ganti Nama Pengguna',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                TextFormField(
                  initialValue: 'jhondhoe',
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

                Text(
                  'Ganti Password',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
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

                Text(
                  'Konfirmasi Password',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
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
  onPressed: () {
    // Aksi ketika tombol "Konfirmasi" di-klik
    // Misalnya, validasi input dan simpan perubahan
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
