import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mobile_studio_gallery/login/tampilan_pendaftaran1.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:mobile_studio_gallery/menu/tampilan_utama.dart';

void main() {
  runApp(const Pendaftaran3());
}

class Pendaftaran3 extends StatelessWidget {
  const Pendaftaran3({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: RegistrationPage3(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class RegistrationPage3 extends StatefulWidget {
  const RegistrationPage3({super.key});

  @override
  _RegistrationPageState createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage3> {
  String? selectedBank; // Variable untuk menyimpan bank yang dipilih
  List<String> banks = [
    'Bank BNI',
    'Bank MANDIRI',
    'Bank BCA',
    'Bank BRI'
  ]; // Ganti dengan daftar nama bank yang sesuai
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

      await users.doc(uid).set({
        'bank': {
          'nama': nama,
          'jenis': selectedBank,
          'no_rekening': noRekening,
        },
      }, SetOptions(merge: true));
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => HomePage(),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          constraints: BoxConstraints(
            maxHeight: MediaQuery.of(context).size.height,
          ),
          padding: const EdgeInsets.all(20.0),
          child: Column(
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
                              builder: (context) => const RegistrationPage1()));
                    },
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.of(context).push(
                        PageRouteBuilder(
                          pageBuilder:
                              (context, animation, secondaryAnimation) {
                            return PaketApp(); // Gantilah dengan halaman yang ingin Anda tampilkan saat daftar
                          },
                          transitionsBuilder:
                              (context, animation, secondaryAnimation, child) {
                            const begin =
                                Offset(7.0, 5.3); // Mulai dari kanan ke kiri
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
                    child: Align(
                      alignment:
                          Alignment.topRight, // Sesuaikan sesuai kebutuhan Anda
                      child: Text(
                        "Lewati",
                        style: TextStyle(
                          color: Colors.blue,
                          fontSize: 15.0,
                          // decoration: TextDecoration.underline,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    const SizedBox(
                      height: 5.0,
                    ),
                    const Text(
                      'Daftar',
                      style: TextStyle(
                        fontSize: 30.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(
                      height: 20.0,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        const Text(
                          'Isi Data Bank', // Teks di atas input
                          style: TextStyle(
                            fontSize: 22.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(
                          height: 20.0,
                        ),
                        const Text(
                          'Nama Lengkap',
                          style: TextStyle(
                            fontSize: 18.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(
                          height: 20.0,
                        ),
                        SizedBox(
                          width: 356.0,
                          height: 45.0,
                          child: TextField(
                            controller: _namaController,
                            decoration: InputDecoration(
                              labelText:
                                  'Masukkan Nama', // Teks di dalam border
                              border: OutlineInputBorder(
                                borderSide: BorderSide(),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 20.0,
                        ),
                        const Text(
                          'Bank',
                          style: TextStyle(
                            fontSize: 18.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(
                          height: 20.0,
                        ),
                        Container(
                          width: 356.0,
                          height: 45.0,
                          padding: const EdgeInsets.symmetric(horizontal: 5.0),
                          decoration: BoxDecoration(
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
                        const SizedBox(
                          height: 30.0,
                        ),
                        const Text(
                          'No Rekening',
                          style: TextStyle(
                            fontSize: 18.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(
                          height: 30.0,
                        ),
                        SizedBox(
                          width: 356.0,
                          height: 45.0,
                          child: TextField(
                            controller: _noRekeningController,
                            keyboardType: TextInputType
                                .number, // Hanya memperbolehkan input angka
                            inputFormatters: <TextInputFormatter>[
                              FilteringTextInputFormatter
                                  .digitsOnly, // Hanya memperbolehkan angka
                            ],
                            decoration: const InputDecoration(
                              labelText:
                                  'Masukkan No Rekening', // Teks di dalam border
                              border: OutlineInputBorder(
                                borderSide: BorderSide(),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 30.0,
                        ),
                        const Text(
                          '*Untuk data bank tidak wajib diisi, tetapi ketika ingin melakukan booking wajib diisi.', // Teks di atas input
                          style: TextStyle(
                            fontSize: 13.0,
                            fontWeight: FontWeight.normal,
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
      ),
      bottomSheet: Container(
        margin: const EdgeInsets.symmetric(horizontal: 25.0, vertical: 20.0),
        child: ElevatedButton(
          onPressed: () {
            _konfirmasi();
            // Tambahkan aksi yang ingin Anda lakukan saat tombol ditekan
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
                'Konfirmasi',
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
