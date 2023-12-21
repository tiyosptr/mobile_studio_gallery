import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mobile_studio_gallery/chat/tampilan_chat.dart';
import 'package:mobile_studio_gallery/menu/detailhargapage.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mobile_studio_gallery/pesanan/tampilan_pesanan_new.dart';
import 'package:mobile_studio_gallery/user/data_pribadi.dart';
import 'package:mobile_studio_gallery/main.dart';

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
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late List<Map<String, dynamic>> paketList;
  List<bool> checkedItems = [];
  late QuerySnapshot querySnapshot; // Tambahkan variabel ini
  bool isLoading = true; // Tambahkan variabel isLoading
  bool showTambahDataButton = false;

  @override
  void initState() {
    super.initState();
    paketList = [];
    getPaketList();
  }

  void getPaketList() {
    FirebaseFirestore.instance
        .collection('Paket')
        .orderBy('nama_paket')
        .get()
        .then((snapshot) {
      setState(() {
        querySnapshot = snapshot; // Simpan snapshot di variabel ini
        List<Map<String, dynamic>> tempList = [];
        snapshot.docs.forEach((document) {
          Map<String, dynamic> paket = document.data() as Map<String, dynamic>;
          tempList.add(paket);
        });
        tempList.sort((a, b) => a['nama_paket'].compareTo(b['nama_paket']));
        paketList = tempList;
        isLoading = false; // Set isLoading menjadi false setelah data dimuat
      });
    }).catchError((error) {
      print('Error while loading data: $error');
      setState(() {
        isLoading = false; // Set isLoading menjadi false jika terjadi kesalahan
      });
    });
  }

  void _navigateToDetailPage(Map<String, dynamic> paket) {
    String docId = '';
    for (var doc in querySnapshot.docs) {
      if (doc['nama_paket'] == paket['nama_paket']) {
        docId = doc.id;
        break;
      }
    }
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => DetailHargaPage(paket: paket, docId: docId),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 255, 255, 255),
      body: Column(
        children: [
          if (isLoading) // Tambahkan kondisi untuk menampilkan CircularProgressIndicator
            Expanded(
              child: Center(
                child: CircularProgressIndicator(),
              ),
            ),
          if (!isLoading && paketList.isEmpty)
            Expanded(
              child: Center(
                child: Text('Data Kosong'),
              ),
            ),
          if (!isLoading && paketList.isNotEmpty)
            Stack(
              alignment: Alignment.topCenter,
              children: [
                StreamBuilder<QuerySnapshot>(
                  stream: FirebaseFirestore.instance
                      .collection('Promosi')
                      .snapshots(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData && snapshot.data!.docs.isNotEmpty) {
                      List<String> imageUrls = [];
                      snapshot.data!.docs.forEach((doc) {
                        if (doc['promoImage'] != null) {
                          imageUrls.add(doc['promoImage']);
                        }
                      });
                      if (imageUrls.isNotEmpty) {
                        return CarouselSlider(
                          items: imageUrls.map((imageUrl) {
                            return Image.network(
                              imageUrl,
                              fit: BoxFit.cover,
                            );
                          }).toList(),
                          options: CarouselOptions(
                            autoPlay: true,
                            height: 380.0,
                            viewportFraction: 1,
                            disableCenter: true,
                            autoPlayInterval: Duration(seconds: 4),
                            autoPlayAnimationDuration:
                                Duration(milliseconds: 800),
                            onPageChanged: (index, reason) {
                              setState(() {});
                            },
                          ),
                        );
                      } else {
                        return Center(child: Text('Gambar Tidak Tersedia'));
                      }
                    } else if (snapshot.hasError) {
                      return Text('Error: ${snapshot.error}');
                    } else {
                      return Center(child: CircularProgressIndicator());
                    }
                  },
                ),
                Positioned(
                  top: 50.0,
                  left: 20.0,
                  child: Text(
                    'Selamat Datang',
                    style: GoogleFonts.poppins(
                      textStyle: TextStyle(
                        color: Colors.white,
                        fontSize: 20.0,
                        shadows: [
                          Shadow(
                            blurRadius: 4.0,
                            color: Colors.black,
                            offset: Offset(2.0, 2.0),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Positioned(
                  top: 80.0,
                  left: 20.0,
                  child: Text(
                    'User',
                    style: GoogleFonts.poppins(
                      textStyle: TextStyle(
                        color: Colors.white,
                        fontSize: 20.0,
                        shadows: [
                          Shadow(
                            blurRadius: 4.0,
                            color: Colors.black,
                            offset: Offset(2.0, 2.0),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 15.0),
                child: Text(
                  'PAKET KAMI:',
                  style: GoogleFonts.roboto(
                    textStyle: TextStyle(
                      color: const Color.fromARGB(255, 0, 0, 0),
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
          if (isLoading) // Tampilkan indikator loading jika isLoading adalah true
            Expanded(
              child: Center(
                child: CircularProgressIndicator(),
              ),
            ),
          if (!isLoading &&
              paketList
                  .isNotEmpty) // Tampilkan data jika isLoading adalah false
            Expanded(
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: paketList.length,
                itemBuilder: (context, index) {
                  final paket = paketList[index];
                  final namaPaket = paket['nama_paket'];
                  final orang = paket['orang'];
                  final waktu = paket['waktu'];
                  final keuntungan1 = paket['keuntungan1'];
                  final harga = paket['harga'];
                  final imageUrl = paket['url_gambar'];

                  return Padding(
                    padding: const EdgeInsets.only(
                        left: 24, right: 24, top: 5, bottom: 16),
                    child: InkWell(
                      splashColor: Colors.transparent,
                      onTap: () {
                        _navigateToDetailPage(paket);
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius:
                              const BorderRadius.all(Radius.circular(16.0)),
                          boxShadow: <BoxShadow>[
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.9),
                              offset: const Offset(4, 4),
                              blurRadius: 22,
                            ),
                          ],
                        ),
                        child: ClipRRect(
                          borderRadius:
                              const BorderRadius.all(Radius.circular(16.0)),
                          child: Stack(
                            children: <Widget>[
                              Column(
                                children: <Widget>[
                                  Image.network(
                                    imageUrl ?? '',
                                    fit: BoxFit.cover,
                                    width: double.infinity,
                                    height: 150.0,
                                  ),
                                  Container(
                                    color: Color(0xFF232D3F),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Expanded(
                                          child: Container(
                                            child: Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 16, top: 8, bottom: 8),
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: <Widget>[
                                                  Text(
                                                    namaPaket ?? '',
                                                    textAlign: TextAlign.left,
                                                    style: TextStyle(
                                                      decoration: TextDecoration
                                                          .underline,
                                                      decorationThickness: 2.0,
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      fontSize: 22,
                                                      color: Colors.white,
                                                    ),
                                                  ),
                                                  Text(
                                                    orang ?? '',
                                                    style: TextStyle(
                                                      fontSize: 14,
                                                      color: Colors.white
                                                          .withOpacity(1.0),
                                                    ),
                                                  ),
                                                  Text(
                                                    waktu ?? '',
                                                    style: TextStyle(
                                                      fontSize: 14,
                                                      color: Colors.white
                                                          .withOpacity(1.0),
                                                    ),
                                                  ),
                                                  Text(
                                                    keuntungan1 ?? '',
                                                    style: TextStyle(
                                                      fontSize: 14,
                                                      color: Colors.white
                                                          .withOpacity(1.0),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              right: 16, top: 8),
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.end,
                                            children: <Widget>[
                                              Text(
                                                'RP ${harga ?? ''}',
                                                textAlign: TextAlign.left,
                                                style: TextStyle(
                                                  decoration:
                                                      TextDecoration.underline,
                                                  decorationThickness: 2.0,
                                                  fontWeight: FontWeight.w600,
                                                  fontSize: 21,
                                                  color: Colors.white,
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
            ),
        ],
      ),
      floatingActionButton: Padding(
        padding: EdgeInsets.fromLTRB(0, 120, 0, 52),
        child: Align(
          alignment: Alignment.topRight,
          child: FloatingActionButton(
            onPressed: () {
              // Navigasi ke halaman Obrolan
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => ChatScreen(
                          receiverUserEmail: '',
                          receiverUserID: '',
                        )),
              );
            },
            child: const Icon(Icons.chat),
            backgroundColor:
                const Color.fromARGB(255, 81, 85, 81).withOpacity(0.3),
            elevation: 2,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart),
            label: 'Pesanan',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.location_on_outlined),
            label: 'Lokasi',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profil',
          ),
        ],
        currentIndex: 0,
        onTap: (index) {
          switch (index) {
            case 0:
              break;
            case 1:
              // Navigate to Pesanan
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => PesananPage2()),
              );
              break;
            case 2:
              //Navigate to Maps
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const MyMap()),
              );
              break;
            case 3:
              // Navigate to Maps
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Tampilan()),
              );
              break;
          }
        },
        backgroundColor: Color(0xFF232D3F), // Background color
        selectedItemColor: Colors.white, // Selected item color
        unselectedItemColor: Colors.grey, // Unselected item color
        selectedLabelStyle: TextStyle(fontWeight: FontWeight.bold),
        unselectedLabelStyle: TextStyle(fontWeight: FontWeight.normal),
        elevation: 10, // Elevation
        type: BottomNavigationBarType.fixed, // To ensure all labels are visible
      ),
    );
  }
}
