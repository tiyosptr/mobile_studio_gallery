import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mobile_studio_gallery/menu/memilih_jadwal.dart';

final List<String> studioImages = [
  'images/studio1.png',
  'images/studio2.png',
  'images/studio3.png',
  'images/studio4.png',
];

class DetailHargaPage extends StatefulWidget {
  final Map<String, dynamic> paket;

  DetailHargaPage({required this.paket});

  @override
  _DetailHargaPageState createState() => _DetailHargaPageState();
}

class _DetailHargaPageState extends State<DetailHargaPage> {
  int _selectedStudioIndex = 0;
  List<DocumentSnapshot>? _paketData;
  bool _isLoading = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: Stack(
              alignment: Alignment.centerLeft,
              children: [
                Image.network(
                  widget.paket['url_gambar'],
                  fit: BoxFit.cover,
                  height: 400.0,
                  width: 400.0,
                ),
                Positioned(
                  top: 30, // Atur posisi vertikal
                  left: 10, // Atur posisi horizontal
                  child: IconButton(
                    icon: Icon(Icons.arrow_back, color: Colors.black),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            top: 350.0,
            left: 0.0,
            right: 0.0,
            bottom: 0.0,
            child: Container(
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.vertical(
                    top: Radius.circular(40.0),
                  ),
                  boxShadow: <BoxShadow>[
                    BoxShadow(
                      color: Colors.black.withOpacity(0.6),
                      offset: const Offset(4, 4),
                      blurRadius: 16,
                    )
                  ]),
              child: ListView(
                padding: EdgeInsets.all(0),
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      SizedBox(height: 10),
                      Text(
                        widget.paket['nama_paket'],
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 24.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 10),
                      Row(
                        children: [
                          Icon(
                            Icons.people,
                            color: Colors.black,
                          ),
                          SizedBox(width: 10),
                          Text(
                            widget.paket['orang'],
                            style: GoogleFonts.roboto(
                              textStyle: TextStyle(
                                  color: Colors.black, fontSize: 20.0),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 10),
                      Row(
                        children: [
                          Icon(
                            Icons.access_time,
                            color: Colors.black,
                          ),
                          SizedBox(width: 10),
                          Text(
                            widget.paket['waktu'],
                            style: GoogleFonts.roboto(
                              textStyle: TextStyle(
                                  color: Colors.black, fontSize: 20.0),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 10),
                      Row(
                        children: [
                          Icon(
                            Icons.layers,
                            color: Colors.black,
                          ),
                          SizedBox(width: 10),
                          Text(
                            widget.paket['ganti_pakaian'],
                            style: GoogleFonts.roboto(
                              textStyle: TextStyle(
                                  color: Colors.black, fontSize: 20.0),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 10),
                      Row(
                        children: [
                          Icon(
                            Icons.layers,
                            color: Colors.black,
                          ),
                          SizedBox(width: 10),
                          Text(
                            widget.paket['deskripsi'],
                            style: GoogleFonts.roboto(
                              textStyle: TextStyle(
                                  color: Colors.black, fontSize: 20.0),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 30),
                      Text(
                        'Dapat',
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Row(
                        children: [
                          Icon(
                            Icons.folder,
                            color: Colors.black,
                          ),
                          SizedBox(width: 10),
                          Text(
                            widget.paket['keuntungan1'],
                            style: GoogleFonts.roboto(
                              textStyle: TextStyle(
                                  color: Colors.black, fontSize: 20.0),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 10.0),
                      Row(
                        children: [
                          Icon(
                            Icons.picture_in_picture_sharp,
                            color: Colors.black,
                          ),
                          SizedBox(width: 10),
                          Text(
                            widget.paket['keuntungan2'],
                            style: GoogleFonts.roboto(
                              textStyle: TextStyle(
                                  color: Colors.black, fontSize: 20.0),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 10),
                      Text(
                        'Pilih Studio',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: studioImages.asMap().entries.map((entry) {
                          final int index = entry.key;
                          final String imagePath = entry.value;
                          return GestureDetector(
                            onTap: () {
                              setState(() {
                                _selectedStudioIndex = index;
                              });
                            },
                            child: Container(
                              width: 80.0,
                              height: 80.0,
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  image: AssetImage(imagePath),
                                  fit: BoxFit.cover,
                                ),
                                border: Border.all(
                                  color: _selectedStudioIndex == index
                                      ? Colors.blue
                                      : Colors.transparent,
                                  width: 2.0,
                                ),
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                            ),
                          );
                        }).toList(),
                      ),
                      Text('Studio Terpilih: ${_selectedStudioIndex + 1}',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16.0,
                          ))
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
   bottomNavigationBar: Container(
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: ElevatedButton(
          onPressed: () {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => JadwalApp(),
      ),
    );
  },
          style: ElevatedButton.styleFrom(
            primary: Color(0xFF445256),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5.0),
            ),
          ),
          child: Padding(
            padding: EdgeInsets.all(5.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Pesan Sekarang',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16.0,
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
