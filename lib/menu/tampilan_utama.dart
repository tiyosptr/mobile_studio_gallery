import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:mobile_studio_gallery/menu/detailhargapage.dart';

void main() => runApp(PaketApp());

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

  final List<String> months = [
    'MARCH',
    'APRIL',
    'MEI',
    'JUNE',
  ];

  final List<Map<String, dynamic>> paketList = [
    {
      'imagePath': 'images/family.jpg',
      'title': 'Paket Keluarga',
      'description': '2-10 Orang',
      'additionalText': 'Dapat 1pcs 10R print foto dan bingkai',
      'price': '200.000',
      'imageWidth': 80.0,
    },
    {
      'imagePath': 'images/prewedding.jpg',
      'title': 'Paket PraNikah',
      'description': '2 Orang',
      'additionalText': 'Dapat 1pcs 10R print foto dan bingkai',
      'price': '150.000',
      'imageWidth': 80.0,
      'imageHeight': 150.0,
    },
    {
      'imagePath': 'images/graduation.jpg',
      'title': 'Paket Kelulusan',
      'description': '1-10 Orang',
      'additionalText': 'Dapat 1pcs 10R print foto dan bingkai',
      'price': '180.000',
      'imageWidth': 80.0,
    },
    {
      'imagePath': 'images/withfriends.jpg',
      'title': 'Paket Bersama Teman',
      'description': '3-8 Orang',
      'additionalText': 'Dapat 1pcs 10R print foto dan bingkai',
      'price': '250.000',
      'imageWidth': 80.0,
    },
  ];

  void _navigateToDetailPage(Map<String, dynamic> paket) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => DetailHargaPage(paket: paket),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        children: [
          Stack(
            alignment: Alignment.topCenter,
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
                  height: 350.0,
                  viewportFraction: 1,
                  disableCenter: true,
                  autoPlayInterval: Duration(seconds: 4),
                  autoPlayAnimationDuration: Duration(milliseconds: 800),
                  onPageChanged: (index, reason) {
                    setState(() {
                      _currentImageIndex = index;
                    });
                  },
                ),
              ),
              Positioned(
                top: 70,
                child: Column(
                  children: [
                    Text(
                      'MONTHLY',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 24.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      'HIGHLIGHTS',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 24.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              Positioned(
                top: 20.0,
                left: 20.0,
                child: Text(
                  'Selamat Datang',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Positioned(
                top: 60.0,
                left: 20.0,
                child: Text(
                  'Joni',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18.0,
                  ),
                ),
              ),
              Positioned(
                bottom: 100,
                child: Align(
                  child: Text(
                    months[_currentImageIndex],
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 20),
          Text(
            'Paket Kami',
            style: TextStyle(
              color: Colors.white,
              fontSize: 20.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 20),
          Expanded(
            child: ListView.builder(
              itemCount: paketList.length,
              itemBuilder: (BuildContext context, int index) {
                final paket = paketList[index];
                return Card(
                  margin: EdgeInsets.only(bottom: 5.0),
                  color: Color(0xFF101717), // Warna latar belakang #101717
                  child: ListTile(
                    leading: ClipRRect(
                      borderRadius: BorderRadius.circular(5.0),
                      child: Image.asset(
                        paket['imagePath'],
                        width: paket['imageWidth'],
                        height: paket['imageHeight'],
                        fit: BoxFit.cover,
                      ),
                    ),
                    title: Text(
                      paket['title'],
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          paket['description'],
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                        Text(
                          paket['additionalText'],
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                    onTap: () {
                      _navigateToDetailPage(paket);
                    },
                    trailing: TextButton(
                      onPressed: () {
                        _navigateToDetailPage(paket);
                      },
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all<Color>(
                          Colors.blueGrey,
                        ),
                      ),
                      child: Text(
                        'Rp ${paket['price']}',
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.black,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home, color: Colors.white),
            label: '_____',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shop, color: Colors.white),
            label: '_____',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person, color: Colors.white),
            label: '_____',
          ),
        ],
      ),
    );
  }
}

