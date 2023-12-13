import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mobile_studio_gallery/navigation/bar.dart';

void main() {
  runApp(PesananPage());
}

class PesananPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Pesanan(),
    );
  }
}

class Pesanan extends StatefulWidget {
  @override
  _PesananState createState() => _PesananState();
}

class _PesananState extends State<Pesanan> {
  List<String> ordersNotPaid = ['Paket Keluarga', 'Paket Keluarga'];
  List<String> ordersPaid = [];

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text('Pesanan'),
          bottom: TabBar(
            tabs: [
              Tab(text: 'Belum Lunas'),
              Tab(text: 'Lunas'),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            OrderList(orders: ordersNotPaid),
            OrderList(orders: ordersPaid),
          ],
        ),
        bottomNavigationBar: BottomNavigation(),
      ),
    );
  }
}

class OrderList extends StatelessWidget {
  final List<String> orders;

  OrderList({required this.orders});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: orders.length,
      itemBuilder: (context, index) {
        return OrderCard(orderName: orders[index]);
      },
    );
  }
}

class OrderCard extends StatelessWidget {
  final String orderName;

  OrderCard({required this.orderName});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => DetailPage(orderName: orderName),
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
                      'Rp.200.000',
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
                      'Belum Lunas',
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

  DetailPage({required this.orderName});

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
                            'Tanggal Pemotretan : 3 Agustus 2023',
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.white70,
                            ),
                          ),
                          SizedBox(height: 5),
                          Text(
                            'Jam Pemotretan : 17.00 - 17.30',
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.white70,
                            ),
                          ),
                          SizedBox(height: 5),
                          Text(
                            'Harga Paket Foto : 200.000',
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.white70,
                            ),
                          ),
                          SizedBox(height: 5),
                          Text(
                            'Metode Pembayaran : Pembayaran Didepan',
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
              'Status Pembayaran                       Belum Lunas',
              style: TextStyle(color: Colors.white), // Warna teks putih
            ),
          ),
        ],
      ),
    );
  }
}
