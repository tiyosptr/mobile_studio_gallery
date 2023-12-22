import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:mobile_studio_gallery/menu/tampilan_utama.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mobile_studio_gallery/main.dart';
import 'package:mobile_studio_gallery/user/data_pribadi.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mobile_studio_gallery/navigation/bar_pesanan.dart';

void main() {
  runApp(PesananPage2());
}

class PesananPage2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Pesanan(),
    );
  }
}

class Pesanan extends StatefulWidget {
  @override
  _PesananState createState() => _PesananState();
}

class _PesananState extends State<Pesanan> {
  late List<Map<String, dynamic>> ordersNotPaid = [];
  late List<Map<String, dynamic>> ordersPaid = [];

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    QuerySnapshot notPaidSnapshot = await FirebaseFirestore.instance
        .collection('Pemesanan')
        .where('status_pembayaran', isEqualTo: 'Belum lunas')
        .get();

    QuerySnapshot paidSnapshot = await FirebaseFirestore.instance
        .collection('Pemesanan')
        .where('status_pembayaran', isEqualTo: 'Lunas')
        .get();

    QuerySnapshot paketSnapshot =
        await FirebaseFirestore.instance.collection('Paket').get();

    setState(() {
      ordersNotPaid = notPaidSnapshot.docs
          .map((doc) => doc.data() as Map<String, dynamic>)
          .toList();

      ordersPaid = paidSnapshot.docs
          .map((doc) => doc.data() as Map<String, dynamic>)
          .toList();

      List<Map<String, dynamic>> paketData = paketSnapshot.docs
          .map((doc) => doc.data() as Map<String, dynamic>)
          .toList();

      // Proses data paket sesuai kebutuhan Anda
    });
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'Pesanan',
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.w900),
          ),
          backgroundColor: Colors.white,
          bottom: TabBar(
            tabs: [
              Tab(text: 'Belum Lunas', icon: Icon(Icons.money_off)),
              Tab(text: 'Lunas', icon: Icon(Icons.attach_money)),
            ],
            indicatorColor: Colors.black,
            labelColor: Colors.black, // Set label text color to black
            unselectedLabelColor:
                Colors.grey, // Set unselected text color to grey
          ),
        ),
        body: TabBarView(
          children: [
            OrderList(orders: ordersNotPaid),
            OrderList(orders: ordersPaid),
          ],
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
              icon: Icon(Icons.location_pin),
              label: 'Lokasi',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: 'Profil',
            ),
          ],
          currentIndex: 1,
          onTap: (index) {
            switch (index) {
              case 0:
                // Navigate to Home
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => PaketApp()),
                );
                break;
              case 1:
                break;
              case 2:
                // Navigate to Maps
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
          type:
              BottomNavigationBarType.fixed, // To ensure all labels are visible
        ),
      ),
    );
  }
}

class OrderList extends StatelessWidget {
  final List<Map<String, dynamic>> orders;

  OrderList({required this.orders});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: orders.length,
      itemBuilder: (context, index) {
        var order = orders[index];
        return OrderCard(
          orderName: order['nama_paket'],
          statusPembayaran: order['status_pembayaran'],
          harga: order['harga'],
          tanggalPotret: order['tanggal'],
          jamPotret: order['jam'], metodePembayaran: order['metode_pembayaran'],
          // Tambahkan atribut lain sesuai kebutuhan
        );
      },
    );
  }
}

class OrderCard extends StatelessWidget {
  final String orderName;
  final String statusPembayaran;
  final int harga;
  final String tanggalPotret;
  final String jamPotret;
  final String metodePembayaran;

  OrderCard(
      {required this.orderName,
      required this.statusPembayaran,
      required this.harga,
      required this.tanggalPotret,
      required this.jamPotret,
      required this.metodePembayaran});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => DetailPage(
              orderName: orderName,
              statusPembayaran: statusPembayaran,
              harga: harga,
              tanggalPotret: tanggalPotret,
              jamPotret: jamPotret,
              metodePembayaran: metodePembayaran,
            ),
          ),
        );
      },
      child: Container(
        height: 110.0,
        child: Card(
          color: Color(0xFF232D3F),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          clipBehavior: Clip.antiAliasWithSaveLayer,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                flex: 2,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8.0),
                  child: Image.asset(
                    'images/family.jpg',
                    height: 110,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              SizedBox(width: 5),
              Expanded(
                flex: 3,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      orderName,
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      'Rp.${harga.toString()}',
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(width: 10),
              Expanded(
                flex: 2,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      statusPembayaran,
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      'Lihat Detail',
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class DetailPage extends StatelessWidget {
  final String orderName;
  final String statusPembayaran;
  final int harga;
  final String tanggalPotret;
  final String jamPotret;
  final String metodePembayaran;

  DetailPage(
      {required this.orderName,
      required this.statusPembayaran,
      required this.harga,
      required this.tanggalPotret,
      required this.jamPotret,
      required this.metodePembayaran});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Detail Pesanan')),
      body: Column(
        children: [
          Container(
            height: 200.0,
            child: Card(
              color: Color(0xFF232D3F),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              clipBehavior: Clip.antiAliasWithSaveLayer,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    flex: 1,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(8.0),
                      child: Image.asset(
                        'images/family.jpg',
                        height: 200,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  SizedBox(width: 10),
                  Expanded(
                    flex: 2,
                    child: Padding(
                      padding: const EdgeInsets.all(0.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment
                            .start, // Mengubah tata letak teks ke paling kiri
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Text(
                            orderName,
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                          Row(
                            children: [
                              Icon(
                                Icons.person,
                                color: Colors.white70,
                                size: 20,
                              ),
                              Text(
                                '2-10 Orang',
                                style: GoogleFonts.roboto(
                                  textStyle: TextStyle(
                                      color: Colors.white70, fontSize: 14.0),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Row(
                            children: [
                              Icon(
                                Icons.access_time_filled_sharp,
                                color: Colors.white70,
                                size: 20,
                              ),
                              Text(
                                '30 Menit',
                                style: GoogleFonts.roboto(
                                  textStyle: TextStyle(
                                      color: Colors.white70, fontSize: 14.0),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Row(
                            children: [
                              Icon(
                                Icons.layers,
                                color: Colors.white70,
                                size: 20,
                              ),
                              Text(
                                '2x Ganti Pakaian',
                                style: GoogleFonts.roboto(
                                  textStyle: TextStyle(
                                      color: Colors.white70, fontSize: 14.0),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Text(
                            'Tanggal Pemotretan : $tanggalPotret',
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.white70,
                            ),
                          ),
                          SizedBox(height: 5),
                          Text(
                            'Jam Pemotretan : $jamPotret',
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.white70,
                            ),
                          ),
                          SizedBox(height: 5),
                          Text(
                            'Harga Paket Foto : $harga',
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.white70,
                            ),
                          ),
                          SizedBox(height: 5),
                          Text(
                            'Metode Pembayaran : $metodePembayaran',
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.white70,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          SizedBox(height: 300),
          Text(
            '* Setelah melakukan pemotretan, mohon melunasi pembayaran',
            style: TextStyle(
              fontSize: 13,
              color: Colors.red,
            ),
          ), // Spasi antara Card dan Button
          ElevatedButton(
            onPressed: () {
              // Aksi yang dijalankan ketika tombol ditekan
              // Misalnya, Anda dapat menambahkan logika untuk melakukan pembayaran di sini
            },
            style: ElevatedButton.styleFrom(
              primary: Color(0xFF232D3F), // Warna background button
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5), // Border radius button
              ),
            ),
            child: Text(
              'Status Pembayaran                       $statusPembayaran',
              style: TextStyle(color: Colors.white), // Warna teks putih
            ),
          ),
        ],
      ),
    );
  }
}
