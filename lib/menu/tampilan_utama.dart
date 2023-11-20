import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mobile_studio_gallery/navigation/bar.dart';
import 'package:mobile_studio_gallery/menu/detailhargapage.dart';
import 'package:mobile_studio_gallery/chat/tampilan_chat.dart';
//firebase storage ada 10 file

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(PaketApp());
}

class PaketApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(),
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentImageIndex = 0;
  late User _currentUser;
  List<DocumentSnapshot>? _paketData;
  bool _isLoading = true; // Menyimpan data yang telah diambil

  final List<String> imagePaths = [
    'images/family.jpg',
    'images/prewedding.jpg',
    'images/graduation.jpg',
    'images/withfriends.jpg',
  ];

  @override
  void initState() {
    super.initState();
    // Check if a user is authenticated
    if (FirebaseAuth.instance.currentUser != null) {
      _currentUser = FirebaseAuth.instance.currentUser!;
    } else {
      // Handle the case where the user is not authenticated
      // You can display a login screen or handle it as needed
    }
  }

  void _navigateToDetailPage(Map<String, dynamic> paket) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => DetailHargaPage(paket: paket),
      ),
    );
  }

  Future<void> _fetchPaketData() async {
    try {
      final querySnapshot =
          await FirebaseFirestore.instance.collection('Paket').get();
      setState(() {
        _paketData = querySnapshot.docs;
        _isLoading = false; // Simpan data yang telah diambil
      });
    } catch (e) {
      print('Error fetching data: $e');
      setState(() {
        _isLoading =
            false; // Nonaktifkan indikator loading dalam kasus kesalahan
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              alignment: Alignment.topCenter,
              children: [
                CarouselSlider(
                  items: imagePaths.map((imagePath) {
                    return Image.asset(
                      imagePath,
                      fit: BoxFit.cover,
                      width: 400,
                      height: 500,
                    );
                  }).toList(),
                  options: CarouselOptions(
                    autoPlay: true,
                    height: 450.0,
                    viewportFraction: 1,
                    disableCenter: true,
                    autoPlayInterval: Duration(seconds: 4),
                    autoPlayAnimationDuration: Duration(milliseconds: 800),
                    onPageChanged: (index, reason) {
                      setState(() {
                        _currentImageIndex = index;
                      });

                      _fetchPaketData(); // Fetch data only when the carousel changes
                    },
                  ),
                ),
                Positioned(
                  top: 15.0,
                  right: 10.0,
                  child: IconButton(
                    icon: Icon(Icons.chat),
                    color: Colors.white, // Ganti ikon chat sesuai kebutuhan
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              ChatScreen(), // Ganti dengan nama yang benar
                        ),
                      );
                    },
                  ),
                ),
                Positioned(
                  top: 20.0,
                  left: 20.0,
                  child: Text(
                    'Selamat Datang',
                    style: GoogleFonts.lato(
                      textStyle: TextStyle(color: Colors.white, fontSize: 20.0),
                    ),
                  ),
                ),
                Positioned(
                  top: 50.0,
                  left: 20.0,
                  child: Text(
                    "joni",
                    style: GoogleFonts.lato(
                      textStyle: TextStyle(color: Colors.white, fontSize: 20.0),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 20),
            Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: 12.0), // Atur jarak horizontal
              child: Text(
                'Paket Kami :',
                style: GoogleFonts.poppins(
                  textStyle: TextStyle(color: Colors.black, fontSize: 20.0),
                ),
              ),
            ),
            _isLoading
                ? Center(child: CircularProgressIndicator())
                : (_paketData!.isEmpty)
                    ? Text('Tidak ada data yang tersedia.')
                    : ListView.builder(
                        physics: NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: _paketData!.length,
                        itemBuilder: (context, index) {
                          final namaPaket = _paketData![index]['nama_paket'];
                          final orang = _paketData![index]['orang'];
                          final waktu = _paketData![index]['waktu'];
                          final keuntungan1 = _paketData![index]['keuntungan1'];
                          final harga = _paketData![index]['harga'];
                          final imageUrl = _paketData![index]['url_gambar'];

                          return Padding(
                            padding: const EdgeInsets.only(
                                left: 24, right: 24, top: 8, bottom: 16),
                            child: InkWell(
                              splashColor: Colors.transparent,
                              onTap: () {
                                _navigateToDetailPage(_paketData![index].data()
                                    as Map<String, dynamic>);
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(16.0)),
                                  boxShadow: <BoxShadow>[
                                    BoxShadow(
                                      color: Colors.grey.withOpacity(0.6),
                                      offset: const Offset(4, 4),
                                      blurRadius: 16,
                                    ),
                                  ],
                                ),
                                child: ClipRRect(
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(16.0)),
                                  child: Stack(
                                    children: <Widget>[
                                      Column(
                                        children: <Widget>[
                                          Image.network(
                                            imageUrl,
                                            fit: BoxFit.cover,
                                            width: double.infinity,
                                            height: 150.0,
                                          ),
                                          Container(
                                            color: Colors.white,
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: <Widget>[
                                                Expanded(
                                                  child: Container(
                                                    child: Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              left: 16,
                                                              top: 8,
                                                              bottom: 8),
                                                      child: Column(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .center,
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: <Widget>[
                                                          Text(
                                                            namaPaket,
                                                            textAlign:
                                                                TextAlign.left,
                                                            style: TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600,
                                                              fontSize: 22,
                                                              color:
                                                                  Colors.black,
                                                            ),
                                                          ),
                                                          Text(
                                                            orang,
                                                            style: TextStyle(
                                                              fontSize: 14,
                                                              color: Colors.grey
                                                                  .withOpacity(
                                                                      1.0),
                                                            ),
                                                          ),
                                                          Text(
                                                            waktu,
                                                            style: TextStyle(
                                                              fontSize: 14,
                                                              color: Colors.grey
                                                                  .withOpacity(
                                                                      1.0),
                                                            ),
                                                          ),
                                                          Text(
                                                            keuntungan1,
                                                            style: TextStyle(
                                                              fontSize: 14,
                                                              color: Colors.grey
                                                                  .withOpacity(
                                                                      1.0),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          right: 16, top: 8),
                                                  child: Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment.end,
                                                    children: <Widget>[
                                                      Text(
                                                        'RP ${harga}',
                                                        textAlign:
                                                            TextAlign.left,
                                                        style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.w600,
                                                          fontSize: 22,
                                                          color: Colors.black,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                      ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigation(),
    );
  }
}
