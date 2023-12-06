import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mobile_studio_gallery/navigation/bar.dart';
import 'package:mobile_studio_gallery/pembayaran%20DP/pembayaran_dp.dart';

void main() {
  runApp(MaterialApp(
    home: PesananPage(),
  ));
}

class PesananPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Pesanan',
          style: GoogleFonts.roboto(
            textStyle: TextStyle(
              color: Colors.black,
              fontSize: 24.0,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        backgroundColor: Colors
            .white, // Sesuaikan dengan warna latar belakang yang diinginkan
        iconTheme:
            IconThemeData(color: Colors.black), // Sesuaikan dengan warna ikon
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('Pemesanan').snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }

          var documents = snapshot.data!.docs;

          return SingleChildScrollView(
            child: Container(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 16),
                    for (var document in documents)
                      buildCardFromDocument(context, document),
                  ],
                ),
              ),
            ),
          );
        },
      ),
      bottomNavigationBar: BottomNavigation(),
    );
  }

  Widget buildCardFromDocument(
      BuildContext context, QueryDocumentSnapshot document) {
    var data = document.data() as Map<String, dynamic>;
    var namaPaket = data['nama_paket'];

    return FutureBuilder<DocumentSnapshot>(
      future: FirebaseFirestore.instance
          .collection('Paket')
          .where('nama_paket', isEqualTo: namaPaket)
          .get()
          .then((querySnapshot) => querySnapshot.docs.first),
      builder: (context, paketSnapshot) {
        if (!paketSnapshot.hasData || !paketSnapshot.data!.exists) {
          return Container();
        }

        var paketData = paketSnapshot.data!.data() as Map<String, dynamic>;

        return Card(
          color: Color(0xFF101717),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          clipBehavior: Clip.antiAliasWithSaveLayer,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Image.network(
                paketData['url_gambar'] ?? '',
                height: 180,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
              Padding(
                padding: const EdgeInsets.all(15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          paketData['nama_paket'] ?? '',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        Text(
                          data['status_pembayaran'] ?? '',
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Text(
                          'Rp. ${paketData['harga'] ?? ''}',
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment
                          .end, // Ubah ke MainAxisAlignment.end
                      children: [
                        GestureDetector(
                          onTap: () async {
                            String namaPaket = data['nama_paket'];
                            String status_pembayaran =
                                data['status_pembayaran'];
                            String waktu = paketData['waktu'];
                            int harga = data['harga'];
                            String orang = paketData['orang'];
                            String gambar = paketData['url_gambar'] ?? '';

                            // Check if 'tanggal' is not null before attempting to cast
                            String tanggal = data['tanggal'] ?? '';

                            String jam = data['jam'] ?? 0;
                            String ganti_pakaian =
                                paketData['ganti_pakaian'] ?? '';

                            await Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => PembayaranDP(
                                  namaPaket: namaPaket,
                                  gambar: gambar,
                                  waktu: waktu,
                                  orang: orang,
                                  harga: harga,
                                  status_pembayaran: status_pembayaran,
                                  tanggal: tanggal,
                                  jam: jam,
                                  ganti_pakaian: ganti_pakaian,
                                  dataPemesanan:
                                      data, // Pass data from PemesananPage to PembayaranDP
                                  dataPaket: paketData,
                                  documentId: document
                                      .id, // Pass data from PemesananPage to PembayaranDP
                                ),
                              ),
                            );
                          },
                          child: Text(
                            'Lihat Detail',
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.white70,
                              fontWeight: FontWeight.bold,
                              decoration: TextDecoration.underline,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
