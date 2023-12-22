import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

void main() {
  runApp(GantiDataBank());
}

class GantiDataBank extends StatefulWidget {
  @override
  _GantiDataState createState() => _GantiDataState();
}

class _GantiDataState extends State<GantiDataBank> {
  String? selectedBank;
  List<String> banks = ['Bank BNI', 'Bank MANDIRI', 'Bank BCA', 'Bank BRI'];
  TextEditingController _namaController = TextEditingController();
  TextEditingController _noRekeningController = TextEditingController();

  void _konfirmasi() async {
    String nama = _namaController.text;
    String noRekening = _noRekeningController.text;

    if (nama.isNotEmpty && noRekening.isNotEmpty && selectedBank != null) {
      final uid = FirebaseAuth.instance.currentUser?.uid;

      CollectionReference users =
          FirebaseFirestore.instance.collection('users');
      DocumentSnapshot userDoc = await users.doc(uid).get();

      if (userDoc.exists) {
        await users.doc(uid).update({
          'bank.nama': nama,
          'bank.jenis': selectedBank,
          'bank.no_rekening': noRekening,
        });
      } else {
        await users.doc(uid).set({
          'bank': {
            'nama': nama,
            'jenis': selectedBank,
            'no_rekening': noRekening,
          },
        }, SetOptions(merge: true));
      }
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Data bank berhasil disimpan."),
          duration: Duration(seconds: 2),
        ),
      );
      Navigator.pop(context);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Mohon lengkapi semua data'),
          duration: Duration(seconds: 2),
        ),
      );
    }
  }

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
                Text('Ganti Data Bank',
                    style: GoogleFonts.roboto(
                      textStyle: TextStyle(
                          color: Colors.white,
                          fontSize: 24.0,
                          fontWeight: FontWeight.bold),
                    )),
                SizedBox(height: 30),
                Text('Nama',
                    style: GoogleFonts.roboto(
                      textStyle: TextStyle(
                          color: Colors.white,
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold),
                    )),
                SizedBox(height: 10),
                TextFormField(
                  controller: _namaController,
                  decoration: InputDecoration(
                    fillColor: Colors.white,
                    filled: true,
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(),
                    ),
                    labelText: 'Masukkan Nama',
                  ),
                ),
                SizedBox(height: 20),
                Text('Bank',
                    style: GoogleFonts.roboto(
                      textStyle: TextStyle(
                          color: Colors.white,
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold),
                    )),
                SizedBox(height: 20),
                Container(
                  width: 356.0,
                  height: 45.0,
                  padding: const EdgeInsets.symmetric(horizontal: 5.0),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(),
                  ),
                  child: DropdownButton<String>(
                    isExpanded: true,
                    value: selectedBank,
                    items: banks.map((String bank) {
                      return DropdownMenuItem<String>(
                        value: bank,
                        child: Text(bank),
                      );
                    }).toList(),
                    onChanged: (String? newValue) {
                      setState(() {
                        selectedBank = newValue;
                      });
                    },
                  ),
                ),
                SizedBox(height: 20),
                Text('No Rekening',
                    style: GoogleFonts.roboto(
                      textStyle: TextStyle(
                          color: Colors.white,
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold),
                    )),
                TextFormField(
                  controller: _noRekeningController,
                  decoration: InputDecoration(
                    fillColor: Colors.white,
                    filled: true,
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(),
                    ),
                    labelText: 'Masukkan No Rekening',
                  ),
                ),
                SizedBox(height: 20),
                Expanded(
                    child: SizedBox()), // Memberikan ruang ke tombol konfirmasi
                ElevatedButton(
                  onPressed: () {
                    _konfirmasi();
                    // Aksi ketika tombol "Konfirmasi" di-klik
                    // Misalnya, validasi input dan simpan perubahan
                  },
                  style: ElevatedButton.styleFrom(
                    primary: Color(0xFF445256),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                  child: Text(
                    'Konfirmasi',
                    style: TextStyle(color: Colors.white),
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
