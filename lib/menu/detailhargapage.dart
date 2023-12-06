import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mobile_studio_gallery/menu/tampilan_utama.dart';
import 'package:mobile_studio_gallery/menu/memilih_jadwal.dart';

final List<String> studioImages = [
  'images/studio1.png',
  'images/studio2.png',
  'images/studio3.png',
  'images/studio4.png',
];

class DetailHargaPage extends StatefulWidget {
  final Map<String, dynamic> paket;
  final String docId;

  DetailHargaPage({required this.paket, required this.docId});

  @override
  _DetailHargaPageState createState() => _DetailHargaPageState();
}

class _DetailHargaPageState extends State<DetailHargaPage> {
  int _selectedStudioIndex = 0;
  late String imageUrl = '';
  bool isLoading = false;
  bool isButtonsVisible = false;

  @override
  void initState() {
    super.initState();
    _loadImage();
  }

  void _loadImage() async {
    setState(() {
      isLoading = true;
    });
    // Kode untuk memuat gambar
    String imagePath = widget.paket['url_gambar'];
    await Future.delayed(
        Duration(seconds: 1)); // Simulasi waktu pemuatan gambar
    setState(() {
      imageUrl = imagePath;
      isLoading = false;
    });
  }

  void _showDocId(BuildContext context, String docId) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Info"),
          content: Text("Document ID: $docId"),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text("OK"),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 255, 255, 255),
      body: Stack(
        children: [
          Positioned(
            bottom: 20.0,
            left: 0.0,
            right: 0.0,
            child: Center(
              child: isLoading
                  ? CircularProgressIndicator() // Tampilkan indikator loading
                  : ElevatedButton(
                      // Tambahkan tombol refresh
                      onPressed: () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(builder: (context) => PaketApp()),
                        );
                      },
                      child: Text('Refresh'),
                    ),
            ),
          ),
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: Stack(
              alignment: Alignment.centerLeft,
              children: [
                imageUrl.isNotEmpty
                    ? CarouselSlider(
                        items: studioImages.map((imagePath) {
                          return Image.network(
                            widget.paket['url_gambar'],
                            fit: BoxFit.cover,
                            width: MediaQuery.of(context).size.width,
                          );
                        }).toList(),
                        options: CarouselOptions(
                          height: 370.0,
                          // initialPage: 1,
                          enableInfiniteScroll: true,
                          reverse: false,
                          enlargeCenterPage: true,
                          scrollDirection: Axis.horizontal,
                        ),
                      )
                    : Container(),
                Positioned(
                  top: 30, // Atur posisi vertikal
                  left: 10, // Atur posisi horizontal
                  child: Container(
                    child: IconButton(
                      icon: Icon(Icons.arrow_back, color: Colors.black87),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
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
                  top: Radius.circular(60.0),
                ),
              ),
              child: ListView(
                padding: EdgeInsets.all(0),
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            widget.paket['nama_paket'] ??
                                'Nama Paket Tidak Tersedia',
                            style: TextStyle(
                              color: const Color.fromARGB(255, 0, 0, 0),
                              fontSize: 29.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              ElevatedButton(
                                onPressed: () {
                                  // Tambahkan logika yang sesuai untuk tombol ini
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => CalendarScreen(
                                        paket: widget.paket,
                                        docId: widget.docId,
                                        studioIndex: _selectedStudioIndex,
                                      ),
                                    ),
                                  );
                                },
                                style: ElevatedButton.styleFrom(
                                  primary: Color.fromARGB(255, 0, 0, 0),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(5.0),
                                  ),
                                ),
                                child: Text(
                                  'Rp ${widget.paket['harga'].toString()}',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      SizedBox(height: 10),
                      Row(
                        children: [
                          Icon(
                            Icons.people,
                            color: const Color.fromARGB(255, 0, 0, 0),
                          ),
                          SizedBox(width: 10),
                          Text(
                            widget.paket['deskripsi'],
                            style: GoogleFonts.roboto(
                              textStyle: TextStyle(
                                  color: const Color.fromARGB(255, 0, 0, 0),
                                  fontSize: 20.0),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 10),
                      Row(
                        children: [
                          Icon(
                            Icons.access_time,
                            color: const Color.fromARGB(255, 0, 0, 0),
                          ),
                          SizedBox(width: 10),
                          Text(
                            widget.paket['waktu'],
                            style: GoogleFonts.roboto(
                              textStyle: TextStyle(
                                  color: const Color.fromARGB(255, 0, 0, 0),
                                  fontSize: 20.0),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 10),
                      Row(
                        children: [
                          Icon(
                            Icons.layers,
                            color: const Color.fromARGB(255, 0, 0, 0),
                          ),
                          SizedBox(width: 10),
                          Text(
                            widget.paket['ganti_pakaian'],
                            style: GoogleFonts.roboto(
                              textStyle: TextStyle(
                                  color: const Color.fromARGB(255, 0, 0, 0),
                                  fontSize: 20.0),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 30),
                      Text(
                        'Dapat',
                        style: TextStyle(
                          fontSize: 20,
                          color: const Color.fromARGB(255, 11, 11, 11),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Row(
                        children: [
                          Icon(
                            Icons.folder,
                            color: const Color.fromARGB(255, 0, 0, 0),
                          ),
                          SizedBox(width: 10),
                          Text(
                            widget.paket['keuntungan1'],
                            style: GoogleFonts.roboto(
                              textStyle: TextStyle(
                                  color: const Color.fromARGB(255, 0, 0, 0),
                                  fontSize: 20.0),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 10.0),
                      Row(
                        children: [
                          Icon(
                            Icons.picture_in_picture_sharp,
                            color: const Color.fromARGB(255, 0, 0, 0),
                          ),
                          SizedBox(width: 10),
                          Text(
                            widget.paket['keuntungan2'],
                            style: GoogleFonts.roboto(
                              textStyle: TextStyle(
                                  color: const Color.fromARGB(255, 0, 0, 0),
                                  fontSize: 20.0),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 25),
                      Text(
                        'Pilih Studio',
                        style: TextStyle(
                          color: const Color.fromARGB(255, 0, 0, 0),
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 10),
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
                            color: const Color.fromARGB(255, 0, 0, 0),
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
                  builder: (context) => CalendarScreen(
                    paket: widget.paket,
                    docId: widget.docId,
                    studioIndex: _selectedStudioIndex,
                  ),
                ),
              );
            },
            style: ElevatedButton.styleFrom(
              primary: Color(0xFF445256),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
            ),
            child: Padding(
              padding: EdgeInsets.all(2.0),
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
          )),
      // Existing code...
    );
  }
}
