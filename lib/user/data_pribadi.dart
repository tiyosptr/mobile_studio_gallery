import 'package:flutter/material.dart';

void main() {
  runApp(DataPribadi());
}

class DataPribadi extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Data Pribadi',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Tampilan(),
    );
  }
}

class Tampilan extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Container(
        padding: EdgeInsets.all(16.0),
        child: TampilanDataPribadi(),  // Menggunakan TampilanDataPribadi di sini
      ),
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
          Text(
            'Data Pribadi',
            style: TextStyle(
                fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white),
          ),
          SizedBox(height: 30),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Email',
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        // Aksi ketika tombol "Ganti" di-klik
                        // Misalnya, tampilkan dialog penggantian untuk email
                      },
                      child: Text('Ganti'),
                    ),
                  ],
                ),
              ),
            ],
          ),
          Text(
            'jhondhoe@gmail.com',
            style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.white60),
          ),
          SizedBox(height: 30),
          Text(
            'Nama Pengguna',
            style: TextStyle(
                fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
          ),
          Text(
            'jhondhoe',
            style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.white60),
          ),
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
              Text(
                'Data Bank',
                style: TextStyle(
                    fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
              ),
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        // Aksi ketika tombol "Ganti" di-klik
                        // Misalnya, tampilkan dialog penggantian untuk data bank
                      },
                      child: Text('Ganti'),
                    ),
                  ],
                ),
              ),
            ],
          ),
          Text(
            'jhondhoe\nMandiri\n10900********',
            style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.white60),
          ),
        ],
      ),
    );
  }
}
