import 'package:flutter/material.dart';

void main() {
  runApp(GantiData());
}

class GantiData extends StatefulWidget {
  @override
  _GantiDataState createState() => _GantiDataState();
}

class _GantiDataState extends State<GantiData> {
  String? selectedBank;
  List<String> banks = ['Bank BNI', 'Bank MANDIRI', 'Bank BCA', 'Bank BRI'];

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
                  'Ganti Data Bank',
                  style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
                SizedBox(height: 30),
                Text(
                  'Ganti Nama',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: 10),
                TextFormField(
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
                Text(
                  'Bank',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
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
                Text(
                  'No Rekening',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                TextFormField(
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
