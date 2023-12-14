import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mobile_studio_gallery/menu/tampilan_utama.dart';
import 'package:mobile_studio_gallery/menu/memilih_jadwal.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

const String kPaketCollection = 'Paket';
const String kBackgroundImagesField = 'background_images';

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
  late DocumentSnapshot snapshot;
  List<String> backgroundImages = []; // Use backgroundImages directly

  @override
  void initState() {
    super.initState();
    _loadImage();
    _loadImageUrls();
  }

  Future<void> _loadImageUrls() async {
    try {
      FirebaseFirestore firestore = FirebaseFirestore.instance;
      snapshot =
          await firestore.collection(kPaketCollection).doc(widget.docId).get();

      if (snapshot.exists) {
        dynamic backgroundImagesData = snapshot[kBackgroundImagesField];

        if (backgroundImagesData != null && backgroundImagesData is Map) {
          backgroundImagesData.values.forEach((value) {
            if (value is String && value.isNotEmpty) {
              backgroundImages.add(value);
            }
          });
        }

        for (int i = 1; i <= 5; i++) {
          String backgroundFieldName = 'background_image_$i';
          String backgroundImage = snapshot[backgroundFieldName] ?? '';
          if (backgroundImage.isNotEmpty) {
            backgroundImages.add(backgroundImage);
          }
        }

        setState(() {
          // No need to use studioImages, directly use backgroundImages
        });
      } else {
        print("Document does not exist");
      }
    } catch (e) {
      print("Error loading image URLs: $e");
      // Handle the error, e.g., show an error message to the user
    }
  }

  void _loadImage() async {
    setState(() {
      isLoading = true;
    });

    // Simulate image loading delay
    await Future.delayed(Duration(seconds: 1));

    setState(() {
      imageUrl = widget.paket['url_gambar'];
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
                        items: backgroundImages.map((imagePath) {
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
                                  primary: Color(0xFF232D3F),
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
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              for (int i = 1;
                                  i <= widget.paket['keuntungan'].length;
                                  i++)
                                Row(
                                  children: [
                                    Icon(
                                      Icons.folder,
                                      color: const Color.fromARGB(255, 0, 0, 0),
                                    ),
                                    SizedBox(width: 5),
                                    Text(
                                      widget.paket['keuntungan']
                                          ['keuntungan_$i'],
                                      style: GoogleFonts.roboto(
                                        textStyle: TextStyle(
                                          color: const Color.fromARGB(
                                              255, 0, 0, 0),
                                          fontSize: 20.0,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                            ],
                          ),
                        ],
                      ),
                      SizedBox(height: 10.0),
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
                        children: backgroundImages.asMap().entries.map((entry) {
                          final int index = entry.key;
                          final String imagePath = entry.value;
                          final bool isSelected = _selectedStudioIndex == index;

                          return GestureDetector(
                            onTap: () {
                              setState(() {
                                if (isSelected) {
                                  // Deselect jika sudah dipilih
                                  _selectedStudioIndex = -1;
                                } else {
                                  // Pilih studio jika belum dipilih
                                  _selectedStudioIndex = index;
                                }
                              });
                            },
                            child: Container(
                              width: 80.0,
                              height: 80.0,
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  image: NetworkImage(imagePath),
                                  fit: BoxFit.cover,
                                ),
                                border: Border.all(
                                  color: isSelected
                                      ? Colors.blue
                                      : Colors.transparent,
                                  width: 2.0,
                                ),
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              child: isSelected
                                  ? Align(
                                      alignment: Alignment.bottomRight,
                                      child: Icon(
                                        Icons.check_circle,
                                        color: Colors.blue,
                                        size: 24.0,
                                      ),
                                    )
                                  : Container(),
                            ),
                          );
                        }).toList(),
                      ),
                      Text(
                        'Studio yg dipilih: Studio ${_selectedStudioIndex + 1}',
                        style: TextStyle(
                          color: const Color.fromARGB(255, 0, 0, 0),
                          fontSize: 16.0,
                        ),
                      ),
                      SizedBox(height: 20),
                      Container(
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
                            padding: EdgeInsets.all(10.0),
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
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
