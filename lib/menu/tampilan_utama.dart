import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mobile_studio_gallery/menu/detailhargapage.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:mobile_studio_gallery/menu/bar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

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
      initialRoute: '/',
      routes: {
        '/': (context) => HomePage(),
        // '/detailharga': (context) => DetailHargaPage(),
        '/detailhargapage': (context) =>
            DetailHargaPage(), // Tambahkan rute ini
      },
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentImageIndex = 0;

  final List<String> imagePaths = [
    'images/family.jpg',
    'images/prewedding.jpg',
    'images/graduation.jpg',
    'images/withfriends.jpg',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black,
        bottomNavigationBar: BottomNavigation(),
        body: ListView(children: [
          Stack(
            // alignment: Alignment.topCenter,
            children: [
              CarouselSlider(
                items: imagePaths.map((imagePath) {
                  return Image.asset(
                    imagePath,
                    fit: BoxFit.cover,
                  );
                }).toList(),
                options: CarouselOptions(
                  autoPlay: true,
                  height: 350,
                  viewportFraction: 1,
                  disableCenter: true,
                  autoPlayInterval: Duration(seconds: 4),
                  // autoPlayAnimationDuration: Duration(milliseconds: 800),
                  onPageChanged: (index, reason) {
                    setState(() {
                      _currentImageIndex = index;
                    });
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
                    // Logika untuk menangani aksi ketika ikon chat ditekan
                  },
                ),
              ),
              Positioned(
                top: 20.0,
                left: 20.0,
                child: Text(
                  'Selamat Datang',
                  style: GoogleFonts.poppins(
                      textStyle: TextStyle(
                          color: Colors.white,
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold)),
                ),
              ),
              Positioned(
                top: 50.0,
                left: 20.0,
                child: Text(
                  'Joni', // Ganti dengan nama pengguna yang sesuai
                  style: GoogleFonts.poppins(
                      textStyle:
                          TextStyle(color: Colors.white, fontSize: 20.0)),
                ),
              ),
            ],
          ),
          SizedBox(height: 20),
          Text(
            'Paket Kami',
            style: GoogleFonts.roboto(
                textStyle: TextStyle(color: Colors.white, fontSize: 20.0)),
          ),
          Row(
            children: [
              Expanded(
                child: Column(
                  children: [
                    CardWidget(
                      cardWidth: 400,
                      imageWidth: 110.0,
                      cardHeight: 120.0,
                      imagePath: 'images/family.jpg',
                      title: 'Paket Keluarga',
                      description: '2-10 Orang',
                      additionalText: 'Dapat 1pcs 10R print foto dan bingkai',
                      harga: '200.000',
                    ),
                    CardWidget(
                      cardWidth: 400,
                      imageWidth: 110.0,
                      cardHeight: 120.0,
                      imagePath: 'images/prewedding.jpg',
                      title: 'Paket PraNikah',
                      description: '1-5 Orang',
                      additionalText: 'Dapat 2 pcs 10R print foto dan bingkai',
                      harga: '150.000',
                    ),
                    CardWidget(
                      cardWidth: 400,
                      imageWidth: 110.0,
                      cardHeight: 120.0,
                      imagePath: 'images/graduation.jpg',
                      title: 'Paket Kelulusan',
                      description: '1 Orang',
                      additionalText: 'Dapat 1 pcs 8R print foto',
                      harga: '100.000',
                    ),
                    CardWidget(
                      cardWidth: 400.0,
                      imageWidth: 110.0,
                      cardHeight: 120.0,
                      imagePath: 'images/withfriends.jpg',
                      title: 'Paket Bersama Teman',
                      description: '2-8 Orang',
                      additionalText: 'Dapat 5 pcs 5R print foto',
                      harga: '250.000',
                    ),

                    // Tambahkan CardWidget lainnya di sini
                  ],
                ),
              ),
            ],
          ),
        ]));
  }
}

class CardWidget extends StatelessWidget {
  final double cardWidth;
  final double imageWidth;
  final double cardHeight;
  final String imagePath;
  final String title;
  final String description;
  final String additionalText;
  final String harga;

  CardWidget({
    required this.cardWidth,
    required this.imageWidth,
    required this.cardHeight,
    required this.imagePath,
    required this.title,
    required this.description,
    required this.additionalText,
    required this.harga,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: cardWidth,
      height: cardHeight,
      child: Card(
        color: Color(0xFF101717),
        child: Row(
          children: [
            Container(
              width: imageWidth,
              height: cardHeight,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(5.0),
                child: Image.asset(
                  imagePath,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Expanded(
              child: ListTile(
                title: Text(
                  title,
                  style: TextStyle(color: Colors.white, fontSize: 20.0),
                ),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      description,
                      style: GoogleFonts.roboto(
                        textStyle:
                            TextStyle(color: Colors.white, fontSize: 14.0),
                      ),
                    ),
                    Text(
                      additionalText,
                      style: GoogleFonts.roboto(
                        textStyle:
                            TextStyle(color: Colors.white, fontSize: 14.0),
                      ),
                    ),
                  ],
                ),
                trailing: Transform.translate(
                  offset: Offset(10, 30),
                  child: TextButton(
                    onPressed: () {
                      _navigateToDetailPage(context, {
                        'title': title,
                        'description': description,
                        'harga': harga,
                        'imagePath': imagePath,
                      });
                    },
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<Color>(
                        Colors.blueGrey,
                      ),
                    ),
                    child: Text(
                      'Rp $harga',
                      style: GoogleFonts.roboto(
                        textStyle:
                            TextStyle(color: Colors.white, fontSize: 14.0),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _navigateToDetailPage(BuildContext context, Map<String, dynamic> paket) {
    Navigator.of(context).pushNamed(
      '/detailhargapage',
      arguments: {
        'title': paket['title'],
        'description': paket['description'],
        'harga': paket['harga'],
        'imagePath': paket['imagePath'],
      },
    );
  }
}
